From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Git.pm with recent File::Temp fail
Date: Mon, 8 Apr 2013 08:43:10 +0200
Message-ID: <20130408084310.2963648c@pc09.procura.nl>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5tX-0000sy-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762683Ab3DHGnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 02:43:16 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:1895 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762678Ab3DHGnP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 02:43:15 -0400
Received: from pc09.procura.nl (adsl.procura.nl [82.95.216.30])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id r386hBAH069161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 8 Apr 2013 08:43:12 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
X-Mailer: Claws Mail 3.9.0-169-ga0305b-dirty (GTK+ 2.24.10; x86_64-suse-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220403>

On Sat, 23 Mar 2013 16:32:47 +0000, Ben Walton <bdwalton@gmail.com>
wrote:

> Hello,

Still failing in 1.8.2.1

> On Fri, Mar 22, 2013 at 7:57 PM, H.Merijn Brand <h.m.brand@xs4all.nl>=
 wrote:
> > git-1.8.2, perl-5.16.3, File::Temp-0.23
> >
> > Without patch:
> >
> > $ git svn fetch
> > 'tempfile' can't be called as a method at /pro/lib/perl5/site_perl/=
5.16.3/Git.pm line 1117.
> >
> > After patch:
> >
> > $ git svn fetch
> >         M       t/06virtual.t
> > r15506 =3D 6c65be7ff36ffc6fd9b960a4b470ca297103004e (refs/remotes/g=
it-svn)
> > =E2=8B=AE
> >
> > patch attached
>=20
> This list prefers patches to be inline so that they can easily be
> commented on, etc.  I took a quick look at your patch and while it
> looks fine to me, fwiw.
>=20
> You may want to resubmit using git send-email though so that others
> will look at it and possibly apply it.

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.17   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/
