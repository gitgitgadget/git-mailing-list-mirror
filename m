Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A1E2018E
	for <e@80x24.org>; Sun,  7 Aug 2016 09:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbcHGJHB (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 05:07:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:55404 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGJHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 05:07:01 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MVe87-1bkDkv0v6d-00YzBK; Sun, 07 Aug 2016 11:06:54
 +0200
Date:	Sun, 7 Aug 2016 11:06:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
In-Reply-To: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608071104070.5786@virtualbox>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3aGC+Jjvh8MpAjXs1L2RuQTdn69fDm8K1/VMTGlxKl7bbPFAxjT
 T6RMBGxPMuEa0eiR3tHhSfqv5dhalgc0Dt7T/De4TLHxGJ+mcKgmAg+x54sa9YWqwt/aTb8
 I4AKJxVvHoCxiSbcMp1eLKH5mydOwcnXUmTW/W0xwjr0nNFROI+LpnGeu5jVdJItn9o8n8A
 V6Wgw/vI1zlelDB0pOa7Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:6n/1Sg/DWEA=:F+jN6WMvtAFcVfIJQuivBj
 CZh05u/fPxqY0dO7Xpc19OEgvKBqmYJLDqbv+FgjGxvMUaqkxwz51l7X5TeyEQ7Flk0wNdXJK
 oN9DoZrsD8vsYSvHlS9Tq6pdv7gl65jTdZzikNXZmznFVLSOxz9mjJsfDFiAlZ4U3ULmyhW15
 0Kil+JjJLJCGnMKhOmV6oX52aMJU1+eH08wPAS+trH4SkhFNm1VqsdRG9FNLbF8clpFqpyhgH
 50gqA5gFn8lgkD2tvzW/Fpw4kEBK5dGq2OB44VQgbpnvB6akuPHR1qgDWghJCEdP+By4z59Qc
 HI5lcbBgSbjESD7gXjvQJH/w19N1fGIVBcjMt55JXP7vJQV6jmfhbAAI7LTa+0qNxSzRM1bF9
 t4ZXUGVI+v5ajY+ZJVSQW49bnXili8C7WlvuwmIotu+Qllr1GW8/ZtbK+y2JHzUjzAonbPfng
 KpPxoK1QXak8tZoE3zg0Fvecwt+OZB2JePLcaM0k97KhhF7vkCBV0rhpYup8iJMfB0AtpxtoQ
 /FDRsw3Sodk/T+Ec/2QVOablFrYllx/9I89SEFnZFmKyF4nmArdskjaci8d40Sncvokyz1gXj
 Y+unaTTI+dqFuvYQjbL22mPINbr2E99akKdcPIgijj973ctK8obIiQ4q0wS0HbSHN6/mqvFMU
 hloLhSvIRWxJd6Uh81NduRYLxBA2UUKFn8JlmlTyDonPM97/P8yMWlr/6S1O85tE2n0pvKHm6
 u42RJ0mS1VVdZ/bYKz3/T+yQ6Dg5pPNSrzRqfyVxCzYyIWJ83UZSZslpvbMPX1Zbke5acsPhA
 mLfv6by
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> * js/import-tars-hardlinks (2016-08-03) 1 commit
>  - import-tars: support hard links
> 
>  "import-tars" fast-import script (in contrib/) used to ignore a
>  hardlink target and replaced it with an empty file, which has been
>  corrected to record the same blob as the other file the hardlink is
>  shared with.

For the record: this came up, and is required, for my CI work on Windows,
as many MSYS2 packages contain hard-linked files (think about *all* the
builtins in Git, for example). I will use Git to synchronize MSYS2 setups
between build agents.

Ciao,
Dscho
