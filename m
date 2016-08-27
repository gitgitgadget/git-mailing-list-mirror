Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8F41F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 22:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbcH0W0o (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 18:26:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36619 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbcH0W0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 18:26:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so4426717wmf.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BECtaPFN7bZPB+VQdzH+usXzxhrKtuIBoBIIuRVuy2s=;
        b=XNu1AO92sXLkH3CpIrPaTA/HrtgUBMYfI9upE1/pTWyN0xImM/grDzRdZQy5dQbAkR
         DEM6aQkLULBfrVBB4K0Q9sNGcz4hR4YL3qK0BwZ6iKy64lIrE8rxG6R+MI2r4FFjVDQ3
         2MqkTKoTQ+6h/yAeuZhQlNqzbOz6WOMOtAPkXbf8Ed9V4QwCMnu9gMuDif1qWu6fR/gg
         vETzhBYJc1E+1LmwprGBg2eh/eQipyeQhXFgD04m4i2E/pY1Jzb81ygdSD/zL6PxC9Dh
         sVgLGl5+WK1/Cxh9eqiP8uHzCPvhlEaQG0fjU6+zzizvH8n01JU2go6TVnjgU225yEiJ
         316g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BECtaPFN7bZPB+VQdzH+usXzxhrKtuIBoBIIuRVuy2s=;
        b=TQL5jRflhvn1z1FxS6938KiB3T+v3lu1+hhzMYsXINv9mQQtVoGCKSdSho8BHdcqnz
         8JavRV4Z+bootNRz1Jop1Hc1VQoG59XZxQHKtq4tHXKLKNihAmOAVXd14Vo39k02h7d/
         cDYYZ2k57cbioDx367L4cVUc1SJhOvsB9S7ktOJ+y1yXDfJO/MeEomMym6eeASWkZIIf
         72V0f/2jnzZh99R2Y9Ulj8bvTSYvWKt05tnqJGssr0PUWXWabQoEvIJax16FX0CVsWul
         iWzVHCkuF+EtxKtMpCysppqzJzRZuqIk8EDZZYAUfE5iEQoyz1k0zZmnSm4pD+9csFM+
         DSKw==
X-Gm-Message-State: AE9vXwMtiYvNPj5K8AM8SLlr223fZZ/C+CrplsyAd2TrnCk19JgVKD9MKS/teiZNGfvE7A==
X-Received: by 10.194.161.70 with SMTP id xq6mr10848861wjb.189.1472336801746;
        Sat, 27 Aug 2016 15:26:41 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id a203sm6331294wma.0.2016.08.27.15.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 15:26:40 -0700 (PDT)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5e480a5b-3752-55c0-65ed-52ca5802851f@gmail.com>
Date:   Sun, 28 Aug 2016 00:26:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.08.2016 o 15:15, Duy Nguyen pisze:
> On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> My point stands. We are way more uninviting to contributors than
>> necessary. And a huge part of the problem is that we require contributors
>> to send their patches inlined into whitespace-preserving mails.
> 
> We probably can settle this in the next git survey with a new
> question: what's stopping you from contributing to git?

Added to second take on proposed questions for Git User's Survey 2016
https://public-inbox.org/git/ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com/T/#u
'[RFCv2] Proposed questions for "Git User's Survey 2016", take two'

Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 
-- 
Jakub Narębski
