From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: remote to push to local branch: hung up unexpectedly
Date: Wed, 13 Jan 2010 17:12:47 +0200
Message-ID: <20100113151247.GB14248@redhat.com>
References: <20100113130843.GA13545@redhat.com> <be6fef0d1001130615k17855680s57952498260ad09d@mail.gmail.com> <20100113142800.GA13901@redhat.com> <be6fef0d1001130649i6a5f4f29j10800f2532d97796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 16:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4wm-0000Ly-GP
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835Ab0AMPPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 10:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836Ab0AMPPp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab0AMPPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:15:44 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0DFFgCR001690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 13 Jan 2010 10:15:42 -0500
Received: from redhat.com (vpn2-11-140.ams2.redhat.com [10.36.11.140])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o0DFFehT001988;
	Wed, 13 Jan 2010 10:15:41 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1001130649i6a5f4f29j10800f2532d97796@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136830>

On Wed, Jan 13, 2010 at 10:49:44PM +0800, Tay Ray Chuan wrote:
> Hi,
>=20
> On Wed, Jan 13, 2010 at 10:28 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > On Wed, Jan 13, 2010 at 10:15:38PM +0800, Tay Ray Chuan wrote:
> >> Hi,
> >>
> >> On Wed, Jan 13, 2010 at 9:08 PM, Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >> > with url =3D /scm/qemu =A0 (this is repo path)
> >>
> >> Are you working in a "normal" git setup with a .git folder and the
> >> files checked out? Or are you working with a --bare repo?
> >
> > It's a normal setup.
>=20
> I used this script with v1.6.2.5, push was ok.

And so it was for me. Also if I clone the tree everything
is OK.  So it's specific to this tree.

>   #!/bin/bash
>   GITZ=3D"/home/rctay/ext01/dev/git/git-1.6.2.5/git \
>   --exec-path=3D/home/rctay/ext01/dev/git/git-1.6.2.5/"
>   $GITZ --version
>=20
>   mkdir foo
>   cd foo
>   $GITZ init
>=20
>   echo hello > file1
>   $GITZ add file1
>   $GITZ commit -m "new file"
>   $GITZ checkout -b pci
>=20
>   $GITZ config remote.anthony.url .
>   $GITZ config remote.anthony.push +refs/heads/pci:refs/heads/anthony
>=20
>   $GITZ push anthony
>=20
> --=20
> Cheers,
> Ray Chuan
