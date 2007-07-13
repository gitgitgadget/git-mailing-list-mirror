From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Fri, 13 Jul 2007 15:33:54 +0200
Message-ID: <200707131533.55544.simon@lst.de>
References: <46977660.7070207@trolltech.com> <81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1910681.MZ3Q4r739d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9LH0-0000Vs-UU
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 15:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbXGMNd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 09:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756974AbXGMNd1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 09:33:27 -0400
Received: from verein.lst.de ([213.95.11.210]:39259 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756777AbXGMNd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 09:33:26 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6DDXKNK030831
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Fri, 13 Jul 2007 15:33:21 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52392>

--nextPart1910681.MZ3Q4r739d
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 July 2007 15:03:51 Alex Riesen wrote:
> On 7/13/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> >      argmax =3D min(4000, os.sysconf('SC_ARG_MAX'))
>
> I wonder why the code in question does not use "-x"?
> I use it git-p4-import and haven't seen the limit yet.
> I.e.:
>
>    $ ls |p4 -x - print -q
>    $ p4 help usage
>    ...
>    The -x flag instructs p4 to read arguments, one per line, from the
>    named file.  If the file is named '-', then standard input is read.
>    ...

Good idea!


I still think the patch makes sense as stop-gap for 1.5.3 though, because=20
without it git-p4 doesn't work at all on Windows.

Simon

--nextPart1910681.MZ3Q4r739d
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGl39DWXvMThJCpvIRAtW5AJoCSTCIooFmANb4g4Sk/mvPAwH+CQCcDOJw
D3+6KKBt0kuwDaeTX0gVkcQ=
=G9cE
-----END PGP SIGNATURE-----

--nextPart1910681.MZ3Q4r739d--
