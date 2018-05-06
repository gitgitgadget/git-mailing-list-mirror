Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDED9200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeEFMS5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:18:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:40311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeEFMS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:18:56 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6fXs-1eRaDp1MlY-00wSyl; Sun, 06
 May 2018 14:18:45 +0200
Date:   Sun, 6 May 2018 14:18:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/18] branch-diff: also show the diff between
 patches
In-Reply-To: <217c9c08-696f-5e96-d42f-d428ad1fe0a0@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805061411260.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <12d9c7977fdf9cc73c810d2ca31d86a4971cf7f4.1525448066.git.johannes.schindelin@gmx.de> <217c9c08-696f-5e96-d42f-d428ad1fe0a0@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5nBceWyth25y4+6Lg1r4GAQhAGBOL5krnkBJfFxU+71GBmtiN61
 3IqdW6FiFONsxwXXktsDyzfD/uUAWGHHS1x5JqGU5e2+WRBhbR41+h3hGS+tEiV/4e2EjuW
 M9KwWPua40jBNiXC+jYs8e32n5hbo1EbLQv5DrsI/10sS9RvBfFHgB+HPy62roVByW6Bv3g
 kYndL3938Q4xawJ3aI9pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7S1nqIQfHzs=:D6Ksp+iGy5rvpbckHXTyrO
 KsI3h47CMfr/5WtqwybkPun4OysaCLAPB20g+xKaHJIhV/ucY5ZgoOYSON+J/Xr00rCaVGBzL
 U/CB3b/aBu+DnENEGyfTaDvsdJNTZ+f5Epb29+rVK73cdw5dhFlFTbFX4L1BWjJxgLD1p8N81
 /oHeSyO9EJ7Ghv3cvmH0fu5fIAIE6S2nxL2ZIJXvqu7S7yOPxFrC67Xmt9s4GgY3XhCKvlYcw
 9BiRmY6rNMpuyUt5RPt3OG2n44aOce9STyNNroDzUbIsO6mVK9J+kQ6mApF046EK1BpxPv7CW
 V1AzM2kChWvcb8vpMijTOLZdeDBWjs9snsmyhO8mx0AcC3kiCQeYdTVErYwTpgEVsd4fKbd4d
 8fD87WYu6Z/qItt+JwOazyVdL7NIVuodjtK4ULYXgyT/2CdkMHhqBFmeVTyqQwGEo+IhMGKvp
 Nk54TQ00DGDIDEkss35eri0rNNfazINkcVVRVdlrM9pCytUZWHAXn3MSC8VYUyHsBDHNlY/sw
 Kn2VNiyqN0PCT7FVq977Jr8RVrUTqC0Hme5OW0YdAIktNyeScBA0wD/nj4r7C2L6W7Zdi70ih
 wNaiSzxTukreY+bIcnCL+4Ywzhqt3rQzXsmdgZsFol7SUF8bb0216Uv5HoGDFOHFgnl3YPvM6
 UTOWHxICu2Y4V4uzeuwGaKyCLrUgKunm89Ytpfh53ij/iL3fd+m3lb8qyELUy/w+S2C3dmLu5
 zb/+lYMZ4sdFyvxplBIW6N8fbqwZPicj2fgKICJR1Zul5o+kIgkBXf/HVAYTAQvgWPz6Mv9OX
 UTgsAzB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sun, 6 May 2018, Igor Djordjevic wrote:

> On 04/05/2018 17:34, Johannes Schindelin wrote:
> > Just like tbdiff, we now show the diff between matching patches. This is
> > a "diff of two diffs", so it can be a bit daunting to read for the
> > beginner.
> > 
> > And just like tbdiff, we now also accept the `--no-patches` option
> > (which is actually equivalent to the diff option `-s`).
> 
> A quick nit - would `--no-patch` (singular form) option name be more 
> aligned with diff `-s` option it resembles?

The reason I used `--no-patches` is that tbdiff called it that way.

But you're right, the functionality is already available via -s, and we
*do* make this a distinct thing from tbdiff. So I'll simply drop support
for --no-patches.

Ciao,
Dscho
