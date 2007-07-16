From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Mon, 16 Jul 2007 20:30:50 +0200
Message-ID: <200707162030.55268.simon@lst.de>
References: <46977660.7070207@trolltech.com> <7vmyxydwld.fsf@assigned-by-dhcp.cox.net> <20070716053511.GC32566@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1267465.UgG9j0rreM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAVLq-0004sX-5f
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbXGPSbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXGPSbP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 14:31:15 -0400
Received: from verein.lst.de ([213.95.11.210]:52803 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbXGPSbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 14:31:14 -0400
Received: from luria.local (2.84-48-121.nextgentel.com [84.48.121.2])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6GIUZNK022975
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 16 Jul 2007 20:30:36 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070716053511.GC32566@spearce.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52705>

--nextPart1267465.UgG9j0rreM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 July 2007 07:35:11 Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > Thanks.  Marius' patch was whitespace damaged in the context lines,
> > > but it was easily repaired.  I've got a couple of other small items
> > > in my fastimport repository that I'm going to ask Junio to include
> > > in 1.5.3 shortly.
> >
> > Thanks for taking care of this.  I have pulled gfi master into
> > 'master'.  Perhaps we would want to tag -rc2 this weekend, run
> > with it for a week or so and see if we need -rc3 before the
> > final.
>
> I'm not entirely sure how we're going to handle the git-p4 patches;
> I see there's already another set available to use '-x -' to avoid
> command line length problems.
>
> I'm more than happy to play patch monkey and ship them through the
> fastimport repository, but since I'm not a p4 user that offers little
> value to the process, other than perhaps to save you a little time.
>
> Simon suggested he might setup a git fork on repo.or.cz himself, at
> which point you could pull the patches for git-p4 directly from him.
>
> Simon?

Yes, sounds good to me. I have tried creating a git clone on repo.or.cz but=
=20
somehow I can't edit the project. Need to find pasky on IRC to help me :).=
=20
Until then I have created a repository on freedesktop.org:

	git://people.freedesktop.org/~hausmann/git-p4
	http://gitweb.freedesktop.org/?p=3Dusers/hausmann/git-p4;a=3Dsummary


Simon

--nextPart1267465.UgG9j0rreM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGm7lfWXvMThJCpvIRAoCZAKC7mL48hJnowALLpm/JmE2BGFzqTACeKtn9
+cmne2g9fBXutMj65hcsx0E=
=LHBr
-----END PGP SIGNATURE-----

--nextPart1267465.UgG9j0rreM--
