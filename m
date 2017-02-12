Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FBD1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 23:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdBLXCP (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 18:02:15 -0500
Received: from mout.web.de ([212.227.15.4]:57347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdBLXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 18:02:14 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCvVz-1cV2fB0c2F-009fbO; Mon, 13
 Feb 2017 00:02:02 +0100
Subject: Re: What's cooking in git.git (Feb 2017, #03; Fri, 10)
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
 <77af28f3-7a8e-fc6a-40ae-c4203d1a3a67@web.de>
 <xmqq8tpdifoa.fsf@gitster.mtv.corp.google.com>
 <36fdf8c9-f82d-4996-09ef-7d718ab3ac41@oracle.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2bd2d811-2e2d-1aec-e864-d92c8234fef2@web.de>
Date:   Mon, 13 Feb 2017 00:01:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <36fdf8c9-f82d-4996-09ef-7d718ab3ac41@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RMQ6Q0piCqsbUzqMrl7+izhIAwsQcVJJ3s4xdKfDSNw1EOUr/iC
 ngHSxYHwA1mnTv5Q1vexP+dp5J1eyghXiFH8WtykJfOU2XUFvN/l6p2H3Y3iQDHhFsKpmU0
 shTh5OLyWVm2zv6oWYXverf4kA2Z25VzTRvpztj3wIoSi/9ddfR5Y1w7Hb52nbSdIOxiAdA
 clvd3Xmf0gUeqtW3cLuCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1b8NrsuOwYw=:82sfSN49TGhPzyiOG8fLaN
 cHnc4LyFxIqP5iD9ALBlPpP229xAIbqmq3rUPmh9ym/EY9LKMV9FDsxeFkilluCAcOUJyJFaK
 Zp9fe4qggicTxeLY4g27y0F9eF2rnwrAAoEoY9yts1Kyu1MVwS4tlZJj+5J29/qAPzRXU/Yfr
 McCM+y3JvU7YqCNH5nFc7H+kZJMEzKbsfI5X5N9WciZrnrFbkuGmdIQsOg2Jy+KAGppAEP5s/
 12fvoiM1x1v/5Af6cTFDlwGqzpqMfz+dpZ/R6iNjuLqCAqTENbKenwaC1m3Mm2EX7yPPoAZk7
 cm06wWEuv7/tJyGX2dQaVqVBCumOhiNZSbetOz8RGjqf/DkG6kYVCRblz7lt5g6OtgLAdIsIJ
 lA76+V3Z8TSkEwmXhPMq9n6f8EgtYOwULlKOigF7MJ3rA2QOZTg2Si0zk/nhucMJ/b5OWe1YN
 Y8NXf49Vx4E06hT1KvfmJvqEth8Tm5lltOA5spbaX+6+xp6jz2Jaj4GWWRfQlenE3sgCxr+97
 Q39EHKNbZ7vuslMDCGcM0e77nADCT9ZNT6f6B8CFk1nPQchGMerpOYNRZUnH1wMaW4MxyLFPQ
 mkLfgdrjBchqqi7+3bS3cB4mrE+uvXvKZx6q/3vsM2tD8Q8W0p7kfcdr7p3PcKR45ScCFEYf2
 tfiyRE3S2RFzZizsSt0uibc1fy18O9dkX5iz43YcErWliZ6ezhmyaz+LTekknLPJuoNBFtaKQ
 FF5a3U4fd7QHQtJf65rdSYxh/RifPBO4vJLwYZKA1qjt6kWE77tg4fpaid6p3hvzjVCEyTRuG
 K6xQH0T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2017 um 19:32 schrieb Vegard Nossum:
> I said I would resubmit the patches with more config options and more
> command-line arguments (to avoid potentially breaking backwards
> compatibility), but IIRC the response seemed to be "preceding blank line
> heuristic is good enough" and "why bother", so I ended up not not
> resubmitting anything.

I was (and still am) looking forward to your patches.  The current 
heuristic is simplistic, the patches you already sent improve the output 
in certain scenarios, my proposed changes on top aimed to limit 
drawbacks in other scenarios, but together they still have shortcomings.

Avoiding new switches would be nice, though (if possible).  I feel we 
need a lot more tests to nail down our expectations.

René
