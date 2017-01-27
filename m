Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE71F1FB2E
	for <e@80x24.org>; Fri, 27 Jan 2017 20:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdA0UtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:49:06 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:46520 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdA0Usi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:48:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 7EE171E2E2F;
        Fri, 27 Jan 2017 21:48:35 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VrKqwZbzZZXO; Fri, 27 Jan 2017 21:48:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id D8B811E2FBA;
        Fri, 27 Jan 2017 21:48:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UQe4BjmMx6lz; Fri, 27 Jan 2017 21:48:34 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-206-252.dynamic.mnet-online.de [185.17.206.252])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 88EAD1E2E2F;
        Fri, 27 Jan 2017 21:48:34 +0100 (CET)
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
To:     Stefan Beller <sbeller@google.com>
References: <20170127200136.29949-1-cornelius.weig@tngtech.com>
 <CAGZ79kb29usw4WyMdy3c5-rGH1nEcQ1gUabzdAtGgOW9zfTCDA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <01fc4c33-2d4e-e19f-d447-6a187e15d2ed@tngtech.com>
Date:   Fri, 27 Jan 2017 21:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb29usw4WyMdy3c5-rGH1nEcQ1gUabzdAtGgOW9zfTCDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> So maybe s/signed-off-by/helped-by/?
> 

This is getting real complex :-/

As I said in the notes for the patch:

>>     As I don't know what is appropriate, I took the liberty to add everybody's
>>     sign-off who was involved in the discussion in alphabetic order.

With your explanation, I guess the most accurate sign-off chain would be:

Signed-off-by: Stefan Beller <sbeller@google.com> (as you sent a patch)
Helped-by: Philip Oakley <philipoakley@iee.org> (no patch, but helpful)
Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com> (this patch)
Signed-off-by: Junio C Hamano <gitster@pobox.com> (once he decides it's good)
