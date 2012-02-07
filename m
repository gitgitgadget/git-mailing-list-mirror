From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 15:02:05 +0200
Message-ID: <20120207130204.GA7600@redhat.com>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com>
 <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 14:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rukgc-0007uJ-P5
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 14:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2BGNCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 08:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472Ab2BGNCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 08:02:04 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q17D23Y9007772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 7 Feb 2012 08:02:03 -0500
Received: from redhat.com (dhcp-4-60.tlv.redhat.com [10.35.4.60])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q17D21X4024860;
	Tue, 7 Feb 2012 08:02:01 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190172>

On Tue, Feb 07, 2012 at 07:57:08PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Tue, Feb 7, 2012 at 5:41 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >> > #git clone -n lab:/home/mst/scm/linux
> >> > ....
> >> > error: Trying to write ref HEAD with nonexistant object
> >> > cec64082f689f949a397cb9b39423dc41545fa0e
> >> > fatal: Cannot update the ref 'HEAD'.
> >> >
> >> > Looks like a bug, doesn't it?
> >>
> >> Which git version? =A0IIRC there was some bugfix recently in that
> >> area...
> >
> > Sorry, forgot to mention that. It's pretty recent:
> > $ git --version
> > git version 1.7.9.111.gf3fb0
>=20
> The series that Jakub mentioned is probably nd/clone-detached 5ce2b97=
,
> which is already included in your tree. Does 1.7.9 work?

I'll try that.

> I tried but it was ok for me. I think ref processing at local probabl=
y
> goes wrong and does not request commit from HEAD.  If the repo is not
> confidential, you can zip it and send me.

Can't unfortunately :(
Would some verbose logs help?

> --=20
> Duy
