Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256FB1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbdBIOLh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 Feb 2017 09:11:37 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:14343 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdBIOLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 09:11:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id E66EA1E2DD7;
        Thu,  9 Feb 2017 13:43:44 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Gr7Y1Z8ucAQa; Thu,  9 Feb 2017 13:43:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id B0BF71E3017;
        Thu,  9 Feb 2017 13:43:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8VLdmO3g_FO0; Thu,  9 Feb 2017 13:43:44 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 5AA3C1E2DD7;
        Thu,  9 Feb 2017 13:43:44 +0100 (CET)
Subject: Re: [PATCH 6/7] completion: teach remote subcommands option
 completion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170202013759.25789-1-szeder.dev@gmail.com>
Cc:     bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <16f6cc98-1467-27cf-1beb-3160358add5c@tngtech.com>
Date:   Thu, 2 Feb 2017 11:29:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170202013759.25789-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/02/2017 02:37 AM, SZEDER Gábor wrote:
> The 'set-head' subcommand has '--auto' and '--delete' options, and
> 'set-branches' has '--add'.

Oops. Thanks for spotting this..

>>  		__git_complete_remote_or_refspec
>>  		;;
>> -	update)
>> +	update,*)
> 
> The 'update' subcommand has a '--prune' option.
> 

..and that.
