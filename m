Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30A0204A1
	for <e@80x24.org>; Tue, 29 Nov 2016 00:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbcK2ABq (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 19:01:46 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33812 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbcK2ABo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 19:01:44 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so62213188pgx.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 16:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=akLo0HUygXmq+5VgYvyQmMzoHt8cV3ri0kwQGEZuA7k=;
        b=nrwe/LOQGaWRLYPkurxOftzEces4Rl6v7DJa2mnTNONQHpoOLB4kQ2pNWPeIn1x5/f
         YQKMQV7pkNexHFYUPljO23qBP2ch56LULr8mAzcO9rXeNDutS3qxO9xbwLGlThSxPEL9
         LsfNYgas4XvXFFJMjYBNkQX3HtDtcdf08VSgyvpxPy66X1AbmP4/8LSWUXRwSL261rOe
         K3aGknp4BvDPGmfIfvouKvAFpDBE3yKiZzX0WVgBbVyhXUWqM3rQPs2/xLFgEHf03rjk
         3XhWx5Nmmx1qi8Y6b7I+iSk2S6nmD6youTEWEKtV9QKZGWhY/7EQD2Z0keUqGUNjKapM
         u5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=akLo0HUygXmq+5VgYvyQmMzoHt8cV3ri0kwQGEZuA7k=;
        b=Id+eOlHlWjmcXC+Nn3VZhYmprL4W5hSYdYTGRjrH5dxLjSLmPKFnfVG7UTYM+XmdOI
         XgbSEy9FmQR7lEFk7BXCxX1SbYtCvK5OgmebPb36ssGhTfE3EI617ZZdArwysEF0nTVC
         jXqRiYjAxyPPh0uoxx8smdVGMvZe5/cd5sETzVt228DTd0WXlTqWVM0vJgGogchmUbKI
         AmD93nFXwSyqLFscVgNyS30JVLfJTMZh5d4CctwgpQ05T4TV4fIVwM7ae/Vxs3yIuH7Q
         ZVV/0YEgPyFzpYJulK4v0aLMxotB6Dq7HwrTQFhcJJEK6xYDVkgcCf8kpO0+A6buyYLH
         kQDw==
X-Gm-Message-State: AKaTC008hm2hCizPtcIiQEWLz76qCrmyplhjoGjzBrOsCvi0ZAQU3xvzXhRPDum8BiSyQO/G
X-Received: by 10.98.30.1 with SMTP id e1mr24536790pfe.28.1480377703851;
        Mon, 28 Nov 2016 16:01:43 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:6928:f29a:e903:ed30])
        by smtp.gmail.com with ESMTPSA id i194sm72011664pgc.46.2016.11.28.16.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 16:01:42 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
Cc:     Stefan Beller <sbeller@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <732c0e78-74b5-befa-e3c5-5ed9f221fa3a@google.com>
Date:   Mon, 28 Nov 2016 16:01:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23/2016 03:21 PM, Junio C Hamano wrote:
> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
>  - sequencer: use trailer's trailer layout
>  - trailer: have function to describe trailer layout
>  - trailer: avoid unnecessary splitting on lines
>  - commit: make ignore_non_trailer take buf/len
>  - SQUASH???
>  - trailer: be stricter in parsing separators
>
>  Commands that operate on a log message and add lines to the trailer
>  blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
>  "commit -s", have been taught to use the logic of and share the
>  code with "git interpret-trailer".
>
>  What's the doneness of this topic?

Stefan Beller mentioned [1] that this seemed OK to him from a cursory 
read. Do I need to look for another reviewer (or a more thorough review)?

[1] <CAGZ79kY8AUwOYAQX=PEHU3H+AhLAuxtC9+hb42da6TrSdz4BzA@mail.gmail.com>
