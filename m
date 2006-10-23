From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Allow deletion of several patches at once
Date: Mon, 23 Oct 2006 14:37:14 +0200
Message-ID: <20061023123714.GB10872@diana.vm.bytemark.co.uk>
References: <20061022125337.15194.64831.stgit@localhost> <20061022125816.15194.3341.stgit@localhost> <b0943d9e0610230457l2ff82a05pd9c7eddfcfac68f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 14:37:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbz3T-0004RZ-8N
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 14:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWJWMhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 08:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWJWMhS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 08:37:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:65042 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751913AbWJWMhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 08:37:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Gbz3K-0002qJ-00; Mon, 23 Oct 2006 13:37:14 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0610230457l2ff82a05pd9c7eddfcfac68f2@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29830>

On 2006-10-23 12:57:03 +0100, Catalin Marinas wrote:

> On 22/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > +    applied =3D {}
> > +    unapplied =3D {}
> > +    dontexist =3D {}
> > +    for patch in args:
>
> Any reason for not using the parse_patches() function in
> stgit.command.common? It allows one to specify patch ranges like
> patch1..patch2. Have a look at how it is used for the push or float
> commands.

Ah, no, I just didn't know it existed. I'll send an updated patch (but
it may be a few days).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
