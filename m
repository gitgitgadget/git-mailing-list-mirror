Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72DC1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 12:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbcHQMql (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:46:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:55968 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbcHQMqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:46:40 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lzc5y-1b5qIa1HqU-014jyZ; Wed, 17 Aug 2016 14:46:34
 +0200
Date:	Wed, 17 Aug 2016 14:46:32 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:	git@vger.kernel.org, peff@peff.net, j6t@kdbg.org
Subject: Re: [PATCH v2 0/1] convert: Correct NNO tests and missing `LF will
 be replaced by CRLF`
In-Reply-To: <20160813212919.11282-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.20.1608171445500.4924@virtualbox>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net> <20160813212919.11282-1-tboegi@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1385830644-1471437994=:4924"
X-Provags-ID: V03:K0:mHAvgO3+fcD+wleAJoBBfYpyFHWjymSePPU3UZsw7rdx6eIDbcj
 MaQ3HjYskrD3a//kGlWUjvFNeH/Vurw4tFptK5phm0weM81uGwgFXRfkeYhx6fzAbS/8Tp8
 ncYQVMj80sXNUfrldhuD+45CODfJzhcbGRGC8fuKy9m2GmdD+//uE3Ngo5nolSXaJ7ii15T
 bDzeHH7+AMdPELQSYiwww==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mNFmPQyRz/0=:YL1ryPqYOKXN/BlEPpnHOz
 IipHFtdp7zod1baPpPtlpWrgVGIwB05/JxuUNO/Wald8uzBlunpRvzzUyVfPG62b9tsyO3BhQ
 McC8C3M3/cocsFLYbbiBi87zAvhqZlPbHinS+MLVb60ZW6hwhgsNrCQgPZhxnT28JQR+ctCb5
 nmvLGE15RWoExJB8uaGrG/i7M0VA8oBBdhOFqFDNlDEeVCz1D10aYfPDQREI/GcrdcOjoYJjk
 XNratvsrn59mIqvnkbBfh4VZyXYF43J2OEla32v0MiTUfE7jWahDb6k9vR9VFbcbEXMw95yr6
 jwdQIvY72jSu2DH1voP5oQcFh5DRuOlW1wMuOCrrhYVGG6WfjvK03TDpkshz1XOU3BGxbGJkQ
 6DxIhLGh/Oj1KwZySX+XcsY58zpCuxAmxTc1BYq6MfAENqAbf7auMyGsfyzg64fF9/0QK4i0w
 sp77bO+sEToQjTW0Lhe76ximqAzFgwrNpVrgz9cbCFoeQJcWwl5hNmYxd6arn3OCiqW6mzwEi
 Q5U+yNauNGDpIrOJMDSkl6KKq0p3WGEkcb4EBG4CRU/kEygyeMYhZUcdMcZdWuIXyKFtnviNJ
 21aG93AyxGWpctvGp612Fun3lIM5VjKHvjU43KpicBtsfSBpCbnkBGJVQtug+bw43NYd2gWWO
 9JMcKau97OxNY8LbRyB7k5tYB22qTJNAdyJH3Fw+N/F/qDQ0WYMdRIqzvpdOLgRU7jhPArW3u
 T9N3aK9zDnjJdeoCL0j/B44+Mtx0XtCa2DvldYxQXe6Kx+WSgm5otYlV9DuxDqgY2vn+ZDENT
 vhmKczC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1385830644-1471437994=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sat, 13 Aug 2016, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> Change since v1:
> - The changes done in 1/2 in t0027 needed to be reverted in 2/2.
>   Put both changes for convert.c and t0027 into a single commit
> Thanks to Johannes Sixt.
> Torsten B=C3=B6gershausen (1):
>   convert: Correct NNO tests and missing `LF will be replaced by CRLF`

Thank you so much for the fix!

Ciao,
Dscho
--8323329-1385830644-1471437994=:4924--
