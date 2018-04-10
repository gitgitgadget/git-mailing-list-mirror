Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA081F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeDJMZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:25:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:57563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbeDJMZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:25:08 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LtaDM-1eMfhz48G4-010vfP; Tue, 10 Apr 2018 14:25:04 +0200
Date:   Tue, 10 Apr 2018 14:25:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804101423120.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d0GFWJ2BbjKQ53jHPtSX7K6NyZvQlIdNJqm4w5fAm/tG0HufRZy
 zQUR+J9jTcHp+LqzUEiLN4f7alBMtfVNo55nrqMkzpMZCBuT9kEWdFLyHD3wSwDKbS60WNE
 T/KPTnLrDQbebE548eZCq/45yjyKwmcP9scngCGPDIS9RXvRRLwStHpUuualffXrfbciuHq
 ZIVN2ILGjg+f5oKmf93tQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bYLcxewcpHQ=:1k/csZ39SqmwIINiT7Q8u9
 BrVBVtuoyqn2jeXy5pFq1gEL2Rso9Nlu2Y6oi08DeMH6hVnyFvMIyxcCs+FjQThy2TVPmBM6g
 CRO/RKHPgAITzLW0CKVr3gR1E+Qk0fxrzw/RoIYfUY50QH9tZw3wy/0e6t60ECx8rgCSea2cH
 /9CY4azRsZruKslqkmWLXvNAClmTEWH7ZwASvRUSz0HGobtvnP3dPEW1eEbnQGO0qddITDfIT
 pFV/xIjF2OfASDR3HnkDVi6LrWEQPqPnDlVNpiiv1i8tEsjVx3CxnRI0UDtaqEmy4IkueHd8G
 Xr0OsN53Ua4v4RuOe2iFBAvOM3K730RzPzke7mu7zubLiYdMC8YhoiWDgUhGM/KhE9PhE26J4
 jBw5eDetf/CdQYBCngY7tXMv8r5hEoOnLnydcgrDc8G9rfF/giRBdpm1eCd73gm7xPGLTbYBn
 juT4V71xCeoxyQgCZcmNvQp4jw1QdyIjwEDlQeIqTc9SUJucFotkUdi0O5o/j/IQMlArfU9BH
 S6j6E30ceGDGjAbmHYegZH+4GJ5jElHD7amKR086VetFez2kkGTnqcyd4b/6YMcBbcctvmKSv
 Ae++28H+2vyP/QFl5mzKP/1erGneGeThHk8NasdZ8kNX47x2AiPcxXKIGoGOVo+DHhpdXi1w2
 9jS684ulO3d57FKmKesPjrFcTl3AmkmyYOOeRueONLYBtdKSdPoUNGNJ6chBx4Le9Nh1JhqC3
 B9bTimMoRTi3WoaV1Cphvzo330aEkGCTGDmZt2SO6QLq7pyt2aatdJ+PHtAZd2YQTce5/gHmu
 licNHsOxgvzorvQ6X5rSRKscKCI1Zk4lHzCyp5Y9Ndqi4HJWJw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Apr 2018, Junio C Hamano wrote:

> * js/t5404-path-fix (2018-04-09) 1 commit
>  - t5404: relax overzealous test
> 
>  Test fix.

Please note that it is not a "path fix". It is a fix for when the test is
looking for an error message, and may currently mistake something else for
an error. Specifically, it changes the regex looking for the error
message.

Hence my (IMO superior) branch name fix-t5404-error

Ciao,
Dscho
