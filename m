Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B7820A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdBAXXi (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:23:38 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:12259 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBAXXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:23:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9A6C21E308A;
        Thu,  2 Feb 2017 00:23:34 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id acLIAy24fcff; Thu,  2 Feb 2017 00:23:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 56ACA1E308C;
        Thu,  2 Feb 2017 00:23:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PdMf0bVI63aW; Thu,  2 Feb 2017 00:23:34 +0100 (CET)
Received: from [192.168.178.29] (aftr-185-17-206-21.dynamic.mnet-online.de [185.17.206.21])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 0E6011E308A;
        Thu,  2 Feb 2017 00:23:34 +0100 (CET)
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
 <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
 <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
 <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
 <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <125e9d0a-7ea2-5a7e-5b5f-3bd3975b8855@tngtech.com>
Date:   Thu, 2 Feb 2017 00:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   The negated form `--no-create-reflog` only overrides an earlier
>   `--create-reflog`, but currently does not negate the setting of
>   `core.logallrefupdates`.

Even better than Junio's version. I especially like that it mentions
where the default setting comes from.
