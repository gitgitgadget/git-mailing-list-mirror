Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B661B203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 08:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbcGWIxH (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 04:53:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:62510 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbcGWIxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 04:53:03 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MbxJ8-1bj6YA335S-00JL0K; Sat, 23 Jul 2016 10:52:48
 +0200
Date:	Sat, 23 Jul 2016 10:52:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/3] minor git-jump improvements
In-Reply-To: <20160722162707.GA13905@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607231050360.14111@virtualbox>
References: <20160722162707.GA13905@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4wIOUgpv+rEQ4HEQJVEl1is1LdQ2ONGEXYQmdbC1iV1/zkxttrV
 DjcOWbD5vavlKsnOC6o1XERFUENb212X0EjhofuFPCOdR9AdgFBmGIhCwfL+JbdaxJHOzUH
 OicFNOqN42hCAanGyYDhNEcW38mfZpFVDMJWYPEP7Vr8bzS4G0jvuBN7GpubNnbpiC8c2Ey
 1ihMmM2srfzn85cEnRykg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kOG81wEj4xg=:nK2Xh33yQTH5tbvdjae6It
 +OlWzFi0gDXe4137dp3oB32sd+Dv/a++IcYBgkWoJ64BH3x4mQ3onv2hHsgfCsj+4CBy00bZD
 wikQGAUcgE0/JBLWw9LQN23daEwBrAeYt7mbATwgu/XlAfA3t/+iy4numAUVgdM/7vvwN+XT1
 2VgZYtDZq3vX733CA8k/spdSoIJ5C/5V2HelZOcoHD3hENIeWkwO/6dzTBVOFOqwLVHsqgYWg
 LZNj0p8PJZyDoC36VJkReegj3DYJSLVn2mR/JB8ZUABcojaf+eDDBk+urpVEzi5jz+nlSjlwt
 IxgGFQ50B9KlFKlihzAobkWWao3wkuhw5PeEAQC4fcgah21geqLoNaUibUOa3mDqiCAYqBsGG
 rzBBB6o/B/csfsIWoEE4xKUXeOZuRY/sriUgpW2usZDFCvpPwaq3DpI3XrK4cN0FjtHlX4Sqh
 7NbaTsUWXKb1Q/2Lhk1bA05bA7O7IIRRF7LxUwalcFrZUDJc7NzOCMcC8HRtSOOKoMYygJOV4
 njahD3Gt0m4UAjm0V/aMAcxlX1+6EBk8Af08DgZAca5e//J81l9qYar1duGtm8VR2W4c2eehj
 NOCdFdmMnw8mO9xlpFmZR4zyS+4dv0Ki206/Mb0Du8LOKlhybjn/fnKcmwWnuMKt2VdW5xwD1
 42/7lr9WTFlVO+8AjN/2SuF7BDCustARARuIYV4XefOIfT8Nx6uNM4cYvrOFBvRYw5HgB3V5H
 YhP45Q+9S1hKtlh3jtJGX+hcXROeKc2iti6e58iQT0vOLde/bjFXGsekJUf2Y4M7t+CYIKLe7
 gRa5I5x
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 22 Jul 2016, Jeff King wrote:

> Here are a few quick fixes and features for git-jump. The first is a bug
> I noticed and fixed recently. And that reminded me of the second one,
> which I'd been carrying in my local copy for a long time.
> 
>   [1/3]: contrib/git-jump: fix greedy regex when matching hunks
>   [2/3]: contrib/git-jump: add whitespace-checking mode
>   [3/3]: contrib/git-jump: fix typo in README

These 3 patches look good to me.

They also made me aware of git-jump's existence and purpose. I think I
shall use this script a lot myself from now on.

Thanks,
Dscho
