From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 18:18:06 +0200
Message-ID: <20090420181806.229b833e@pc09.procura.nl>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 18:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvwEK-0004mz-GX
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 18:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbZDTQSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbZDTQSu
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 12:18:50 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:1320 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZDTQSu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 12:18:50 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id n3KGI7NR025705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 20 Apr 2009 18:18:07 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
X-Mailer: Claws Mail 3.7.1cvs44 (GTK+ 2.14.4; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117006>

On Mon, 20 Apr 2009 10:59:00 -0400, Jay Soffian <jaysoffian@gmail.com>
wrote:

> On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Sorry, I should have checked myself. =C2=A0defined-or "//" is 5.8.1=
 or later.

Being the maintainer of the defined-or patch for perl 5.8, I can
short-circuit this

* defined-or (//) is officially available from perl-5.10.0 and up
  you can be *sure* to have it there. the 'err' keyword that was the
  low-precedence version for // is gone.

* defined-or is available in any version of perl 5.8.x is the binary
  was built with the appropriate patch, which is available on my CPAN
  directory:
  ftp://download.xs4all.nl/pub/mirror/CPAN/authors/id/H/HM/HMBRAND/
  These patches still include the 'err' keyword

* defined-or is definitely NOT available in 5.6.x

All my perl-5.8.x builds include this patch, so all people that use my
perl builds on HP-UX, will have it available.

One major distribution also included it in their perl builds, but I do
not remember which it is.

My personal preference for the lowest usable and reliable perl version
is 5.8.5 (FWIW)

> > Now the real question was if we still support anything older, and i=
f so
> > what is the bottom version?
> >
> > I certainly can go with "5.8.1 or later", but I vaguely recall duri=
ng the
> > gitweb discussion we said anything without the utf-8 support is unu=
sable
> > for gitweb, but I think we also said that the rest of the git codeb=
ase
> > should support running with something older (5.6.1, perhaps).
>=20
> 15 minutes of research:
>=20
> * 2006-06-25 Junio C Hamano: "Tentatively let's say our cut-off point=
 is
>   somewhere around 5.6." --
>   http://article.gmane.org/gmane.comp.version-control.git/22607
>=20
> * 2008-05-30 Lea Wiemann: "Gitweb relies on Unicode support (e.g. "us=
e
>   Encode") and will continue to be compatible with 5.8 and 5.10 only"=
 --
>   http://article.gmane.org/gmane.comp.version-control.git/83339
>=20
> * 2008-08-13 Lea Wiemann: "This makes Git.pm dependent on Perl 5.6.1.=
 Some
>   tests (like t3701-add-interactive.sh) seem to work with pretty much=
 any Perl
>   version out there, and requiring File::Spec changes this" --
>   http://article.gmane.org/gmane.comp.version-control.git/92260
>=20
> * 2008-08-15 Marcus Griep: "Git.pm: Make File::Spec and File::Temp re=
quirement
>   lazy" -- c14c8ce
>=20
> * 2008-08-30 Junio C Hamano: "I agree we should say we rely on 5.6 or=
 newer."
>   -- http://article.gmane.org/gmane.comp.version-control.git/94399
>=20
> * 2008-09-01 Junio C Hamano: "I personally think it is probably Ok to=
 declare
>   that we do depend on 5.8" --
>   http://article.gmane.org/gmane.comp.version-control.git/94523
>=20
>=20
> So here's my take-away. For the *.perl scripts and gitweb, it's 5.8.0=
=2E For the
> test suite and Git.pm, all Perl versions are theoretically supported,=
 but for
> practical purposes, it may be 5.6.0.
>=20
> Whatever is decided this time, perhaps it should be burned into the t=
ops of
> the *.perl scripts (i.e. "require 5.008;"). It should also be added t=
o
> CodingGuidelines. You know, so this conversation doesn't keep recurri=
ng. :-)

--=20
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org=
/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00=
,
11.11, 11.23, and 11.31, OpenSuSE 10.3, 11.0, and 11.1, AIX 5.2 and 5.3=
=2E
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org=
/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers=
/
