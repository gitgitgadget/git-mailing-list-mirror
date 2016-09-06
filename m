Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BE41F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755217AbcIFHMd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:12:33 -0400
Received: from mail-out.elkdata.ee ([195.250.189.24]:41419 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbcIFHMc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:12:32 -0400
Received: from mail-relay.elkdata.ee (mail-relay.elkdata.ee [195.250.189.180])
        by mail-out.elkdata.ee (Postfix) with ESMTP id F033C64EACCD;
        Tue,  6 Sep 2016 10:12:26 +0300 (EEST)
Received: from mail-relay.elkdata.ee (unknown [195.250.189.180])
        by mail-relay.elkdata.ee (Postfix) with ESMTP id 959B2124E7A6;
        Tue,  6 Sep 2016 10:12:24 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay.elkdata.ee ([195.250.189.180])
        by mail-relay.elkdata.ee (mail-relay.elkdata.ee [195.250.189.180]) (amavisd-new, port 10024)
        with ESMTP id sI-1fx0j4jUa; Tue,  6 Sep 2016 10:12:22 +0300 (EEST)
Received: from mail.elkdata.ee (mail.elkdata.ee [194.106.101.168])
        by mail-relay.elkdata.ee (Postfix) with ESMTP id 44143124E77D;
        Tue,  6 Sep 2016 10:12:20 +0300 (EEST)
Received: from mail.meie.biz (unknown [90.190.182.21])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id 8E08E67BF415;
        Tue,  6 Sep 2016 10:12:18 +0300 (EEST)
Received: from [192.168.1.111] (papaya.meie.biz [192.168.1.111])
        by mail.meie.biz (Postfix) with ESMTPSA id EC75E145C9D;
        Tue,  6 Sep 2016 10:12:17 +0300 (EEST)
Subject: Re: 2.10.0: multiple versionsort.prereleasesuffix buggy?
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>, peff@peff.net
References: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
 <20160906010759.14883-1-szeder@ira.uka.de>
Cc:     git@vger.kernel.org
From:   "Leho Kraav (Conversion Ready)" <leho@conversionready.com>
Organization: Conversion Ready - Lead Generation, E-commerce Website
 Development & Conversion Care
Message-ID: <d95c133b-7d8d-b9f1-7f3b-bcdd4b24aca1@conversionready.com>
Date:   Tue, 6 Sep 2016 10:12:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101
 Thunderbird/47.0
MIME-Version: 1.0
In-Reply-To: <20160906010759.14883-1-szeder@ira.uka.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.09.2016 04:07, SZEDER Gábor wrote:
>
> [versionsort]
> 	prereleasesuffix = beta
> 	prereleasesuffix = -beta
> 	prereleasesuffix = RC
> 	prereleasesuffix = -RC
>
> Best,
> Gábor

Yes, yes you are the best. Workaround works, tyvm. I was heading in that 
direction, too, but never thought to remove leading dash on the 
alternates - instead I tried "-b", "-R" and similar just to see what 
happens.

