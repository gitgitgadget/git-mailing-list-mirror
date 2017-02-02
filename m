Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72261F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdBBJQk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Feb 2017 04:16:40 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:64457 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdBBJQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:16:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 045C41E2D05;
        Thu,  2 Feb 2017 10:16:36 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tWSa2H9L9D1N; Thu,  2 Feb 2017 10:16:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id B07161E2E1D;
        Thu,  2 Feb 2017 10:16:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CZpdnaX5VCPR; Thu,  2 Feb 2017 10:16:35 +0100 (CET)
Received: from [192.168.178.72] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 51D7D1E2D05;
        Thu,  2 Feb 2017 10:16:35 +0100 (CET)
Subject: Re: [PATCH 2/7] completion: add subcommand completion for rerere
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170202005724.24754-1-szeder.dev@gmail.com>
Cc:     bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <303e3381-ad15-c991-afc2-3a55706142f3@tngtech.com>
Date:   Thu, 2 Feb 2017 10:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170202005724.24754-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/02/2017 01:57 AM, SZEDER Gábor wrote:
> You didn't add 'rerere' to the list of porcelain commands, i.e. it
> won't be listed after 'git <TAB><TAB>'.  I'm not saying it should be
> listed there, because I can't decide whether 'rerere' is considered
> porcelain or plumbing...  Just wanted to make sure that this omission
> was intentional.

Yes this is intentional. There is a number of plumbing commands that
have command completion, but are not listed in 'git <Tab><Tab>' (e.g.
ls-tree, ls-files, ls-remote, ...). Given that rerere will not be
frequently invoked, I would not add it to the porcelain commands.
