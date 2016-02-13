From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 18:14:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602131811570.2964@virtualbox>
References: <56B32953.2010908@gmail.com> <20160204111307.GA30495@sigill.intra.peff.net> <alpine.DEB.2.20.1602041216240.2964@virtualbox> <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu> <20160212234041.GA15688@sigill.intra.peff.net>
 <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu> <alpine.DEB.2.20.1602131021170.2964@virtualbox> <20160213145333.Horde.ZTzk8ajnzz2uB2UcNeCdPtB@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1688441962-1455383694=:2964"
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 18:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdn3-0001kU-PG
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbcBMRPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:15:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:53210 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbcBMRPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:15:12 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lcj9b-1Zkoun2L5j-00k7Lo; Sat, 13 Feb 2016 18:14:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160213145333.Horde.ZTzk8ajnzz2uB2UcNeCdPtB@webmail.informatik.kit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:s8txaGpFCa5DUowxxZHzxvenAZe8XtTO7tXjp+0nk455UcrnWem
 kIXGXWJN08muQfEZyQ54SU8jP0pg2qQQWRCtzBBsKSP+3cntdXAxCzX0o9oV0gWBfHStu8J
 uazwIlZl4/0PG3Jse9e2+xCO9Zd2IlZhCC19KhdNuT8wwrgQnO3lRzVSEMe+IYkWJusIMHI
 lHtE1uN450v4zOD261jFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qVqtSEYBjbY=:3Ue2g0mYrd4eZZ8h6YKEVG
 eHVm0jKwtiT4oNzp/Ze+F7nTAW2zKzvOkMN52DCMcr1nVdaLSzyIumToxf/Eru6TZNqY3ku3D
 dRmU7PA7GU3+V+wSrSk0FBCgC1unvljA6LwrFfiVBB4lWrUQPZUU+Lds9fPiIGAcKNIhlhKBB
 I8H+B+OaxEcBC+/88TSqJ9SFFFXSlka5gdYeGDKnNnrXfoVSgKdrtAKWAA1IR3ELDdB806PgS
 v8ZFh1DVctuMTPUSjA/fiCmUURogfpS6ix7FS29EfI1KU9qcvz3/jkMrG3+O896uI14nrAVsQ
 PVgriO7whn/RBodjl0+/K4HHTCbUd2pUhzrhfxVI4zWkXrQsgmvR1fkq963hKVLcqvL4s7b3n
 G+wx+859hy2mcuMj3V9Wks7ukoTUCCpYfxxrOjlfH5b22Hd/YTVa+Juz3UxD2NGy/p+XeLNfN
 bFB4aSjKTKO+whzTcd0ma48AIMEGRwXcI+N989fXvuhxLHMtF9I1GzqUwsC3h+es0wPaoSKoP
 UHzt7h0s00C8d3pgqlbPu2xzU1JZrhCZWdZo/KrIL1ccQCEFC2knd5aPYleJrWze6ILhYhMM9
 PkoYENuC4qyNzfQyF8OR1CHPISo08PG+dsjYHi3tiysBh7MKKdGfCFK9gYUvRUiB5mbCx/i1R
 a4a5E9pE8YY4QXOL6gt1Wdlz+7qQYVepTA30PrQHlUJ4H8ja9E/ui76Cfn1lRX86ealcHTvv1
 Cqome7aHtTeNDmvBgBi1HMxtEkpZW+/fEHlqRQakgm78eGqu7g04sjjAEheGgHDKbW0Adto9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286117>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1688441962-1455383694=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 13 Feb 2016, SZEDER G=C3=A1bor wrote:

> Maybe even run some numbers on Windows?

Here you are:

-- snip --
# Junio's 494398473, i.e. `master
$ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"

real    0m8.260s
user    0m0.265s
sys     0m0.216s

# G=C3=A1bor's 6fc6f416, i.e. with strip=3D2
$ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"

real    0m2.072s
user    0m0.295s
sys     0m0.203s

# G=C3=A1bor's 47b146d7, i.e. `completion-PoC-refs-speedup`
$ cur=3Dm ; time __gitcomp_direct "$(__git_refs_PoC '' 1)"

real    0m1.574s
user    0m0.030s
sys     0m0.015s
-- snap --

This is with a fairly normal, real-world repository:

-- snip --
$ git for-each-ref | wc -l
10303
-- snap --

Ciao,
Dscho
--8323329-1688441962-1455383694=:2964--
