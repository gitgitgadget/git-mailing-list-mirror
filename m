From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 10:21:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602131021170.2964@virtualbox>
References: <56B32953.2010908@gmail.com> <20160204111307.GA30495@sigill.intra.peff.net> <alpine.DEB.2.20.1602041216240.2964@virtualbox> <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu> <20160212234041.GA15688@sigill.intra.peff.net>
 <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1870764721-1455355316=:2964"
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 10:23:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUWPw-0001Mf-4W
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 10:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbcBMJWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 04:22:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:59376 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbcBMJWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 04:22:13 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0ME47n-1aDhXf0H8B-00HN4u; Sat, 13 Feb 2016 10:21:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:04gqT9r4PcfCmC9KC1WLLO+WvrnH00E8sQ3nY0klM+XLs979hHM
 MBTnapU09FXy0vAPq+joLYreAdp73ZU1QHjjnDzUGhgQ2Xd2CxXe33XWAerkD2QGYQijNC2
 u2xJoHZdNFUgXX2TSwtEooUGaXP2/OLz+Lqxy0SVtbGLrC2I7thiSPNp7+/2gg9R6KaaPLQ
 KSClaGAMKOKV5rV5yLgjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JhrEnzCT4yw=:TZWK3g9SmwqlTrhrCsYKQT
 1/LNzlQWer2hkOn2Z/jy2hIbkkn+snNNO9l9DCZ324QdmfWA0UaLmjNv6RnOSmPGk5uznhdXO
 v4WXn58mbOCSIBUDNTl4q4RedO4bGFE8GMZv392pic3ay9ugDQGtiDqv+1qcuTnkxppJqH7F9
 EnwjWOGLdrVCwEpEmEXieGeqkkp3oAcccpajaIjaMnnpy3LvghdqtzYP59nKd1okmk+0RDrFq
 20neSmM+8haFFOPk/RT680kx9GqyAk7IDGM1ByWDRfkfKTsM16RVrymvcgsp1g8hpnw6pw7sw
 mHZdPK0MPtBb263qVIQn5I3DTSH5SFtM77CI46/JG4Sm95dpSlnrzFccpq9jpO+wJK7DkO488
 EpIqk690HON9Jqu8G5TIeNa1O9ivAiBNLbbM9P3KGdVnYf1Tp5HfxO3DWxL803FeGZ8k90Pzq
 8shV/4wmsaRZuL7NlqKZaj8OiviBss3Yqft5DXAmIFT99yVyBOk5tFeBnllxzw/+xxSwTNERc
 oLbZrE5e18QNSJ73ghoHqMQuWYPv3TRhW+A/bic6+lfOtTgeqEFF4Zp+YMdSbt9OHPF0UYRSr
 Xdx2HUdGaXXnlDFWJLhw9WjnPHZHIgL8LTt1mrRrtDQKOdrvXKak6W18Jm22xgfTMHswXvTrG
 5r6hadNvmJaEykfPIIIXLhl7RjH3bqKsXxU/9JYEL9eh6tVt3yA3C0ZG9CqM9jcZBhOdGuD35
 aASjfa5/lxkeoor/CBT0sa/O9vJX+4Gyhs49RFwELilc9Z0MnOkQBFOKVjSH9a0/hSv951Oi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286107>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1870764721-1455355316=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 13 Feb 2016, SZEDER G=C3=A1bor wrote:

>  $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"
>=20
>  real  0m7.641s
>  user  0m5.888s
>  sys   0m1.832s
>=20
> Using 'refname:strip=3D2' for both 'git for-each-ref' in __git_refs():
>=20
>  $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"
>=20
>  real  0m2.848s
>  user  0m2.308s
>  sys   0m0.596s
>=20
> Quick'n'dirty PoC using 'refname:strip', '**' globbing and a few more
> tricks to let 'git for-each-ref' do the filtering instead of the
> shell loop behind __gitcomp_nl():
>=20
>  $ cur=3Dm ; time IFS=3D$'\n' COMPREPLY=3D( $(__git_refs_PoC '' 1) )
>=20
>  real  0m0.247s
>  user  0m0.208s
>  sys   0m0.032s
>=20
> Not bad for a Friday night, huh? :)

Nope, not bad at all. May I have that patch, please? ;-)

Ciao,
Dscho
--8323329-1870764721-1455355316=:2964--
