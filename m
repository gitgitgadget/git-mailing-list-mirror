From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 19:56:22 +0100
Message-ID: <20150219195622.2828cc6a@pc09.procura.nl>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
	<20150218170007.784be6aa@pc09.procura.nl>
	<54E4CFDC.40401@drmicha.warpmail.net>
	<20150218182547.GA6346@peff.net>
	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
	<20150218185734.GB7257@peff.net>
	<54E5BBDD.7040100@drmicha.warpmail.net>
	<20150219121438.59050ce8@pc09.procura.nl>
	<54E5C6E2.9040101@drmicha.warpmail.net>
	<20150219125433.GA1591@peff.net>
	<54E5E347.4070401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/dl/n00WH6q/3JkxbYELn5Bm"; protocol="application/pgp-signature"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOWHD-0005hc-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 19:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbbBSS4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 13:56:40 -0500
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:50069 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbbBSS4j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 13:56:39 -0500
Received: from pc09.procura.nl ([92.66.41.201])
	by smtp-cloud2.xs4all.net with ESMTP
	id uJwc1p00P4LQezg01JwdZL; Thu, 19 Feb 2015 19:56:38 +0100
In-Reply-To: <54E5E347.4070401@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.11.1-76-gc8fc78 (GTK+ 2.24.23; x86_64-suse-linux-gnu)
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264110>

--Sig_/dl/n00WH6q/3JkxbYELn5Bm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2015 14:21:11 +0100, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Jeff, you got it wrong. You should do the hard part and leave the easy
> part to us!
>=20
> Thanks anyways, I'll add this to my HP_UX branch.

I did not mention this in earlier mails. When using the HP C-ANSI-C
compiler, MAX_INT is not set.

I had to add
--8<---
#ifndef   SIZE_MAX
#  define SIZE_MAX              (18446744073709551615UL)
/* define SIZE_MAX              (4294967295U) */
#  endif
-->8---

to these files

sha1_file.c
utf8.c
walker.c
wrapper.c

And yes, that could be dynamic and probably be in another header file

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/dl/n00WH6q/3JkxbYELn5Bm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU5jHfAAoJEAOhR6E+XcCYbRQIAJkLFBkxuW+uwI1MVL/CJrM1
Na/VWtOMSQ+pN2LgNu/5VxGQH/47PLSjdk8yZoKcBarf+7MAanOalmQrO1FQp5gb
PIQT2UoYklV2elOkn29bvvYF0/OrHyL7Fs1krZpBAvwarghphCBPaZamVMHnwbj+
ugKYiVQpomI0DKlyRvfeinS+f+sI8FcgmbGNooN7EF9GKnSMbFjFEJe0qm5D59hU
6C/tMNCaVEIKdpKkEQVbKeIfXf+YnggL49ycAQROi9gKAlrsETV1nbbA9tU8k1ZT
6zscMc6c08NcAB5oWYVR4xG2BT67XKb+G+/ttXEelspPu0R+2kOz/Z6vb21T2mQ=
=gBAn
-----END PGP SIGNATURE-----

--Sig_/dl/n00WH6q/3JkxbYELn5Bm--
