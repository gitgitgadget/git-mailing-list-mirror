Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AC21F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935004AbeB1VcX (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:32:23 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36567 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934860AbeB1VcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:32:22 -0500
Received: by mail-wr0-f175.google.com with SMTP id v111so3963641wrb.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=haItMqMA0FFQAxRpouBLM3+AU/zRah1hVSel/314yfU=;
        b=Db3ge7c+NSuqfLJ+NJCPZ/g2ii6CMYuK0nvl5bykSW17d9R7rCp9b0CtTOArPYwby2
         J4ovvkr4RA98t0tDVadFvonevGAeMSNytY9djfIhNAi3dySeIWRIm4GDrSHil5nNlFut
         +iQK5LRh6BG9o0AVLaowWUOwQYBl03pPfqsR1gVCWlDY9Fj+uh++yq0sbz+NrDmFo6OB
         4pdDARKwuih3o4SZuZUlv78n7aWYXGr2YkU1zvRG/hjB/u+QhpuRIKEv6J50byqsu5fJ
         OItCmo31NIzfb0Qq1Iqa62mv9wW7qgiYKBBGFNjU3E+ffaWdHMfGlxB1WfkLetXe1iaX
         r8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=haItMqMA0FFQAxRpouBLM3+AU/zRah1hVSel/314yfU=;
        b=mFO/KkROOLxF33qpUK/a/zNhr2KMCsJFIxt3AGvOZSd5YlYURGVEHwiDZ0mAG0j6Uc
         d2zLExshL3F+Z/bPQ9FoF6jdMYfn/gmnqu8XMkufuU5a7HDnwes7QIVRTAhEo39dHz/H
         ZfkaL+f9I5+IFbem783b/wjkjMKDJyxY1b4pNpA5F8Uq/w8Zl49tNsActLtkInV1o6ad
         UNtGnGEKb0mh6U7MpekfVM9OPDIHzX2uGVoSmOoAmTyO7LlmcgWuMw4fRbLjjL1qCF9g
         DK5bR81QbdaQlJYI4BEZmpKBfoHYX4R1SwSM5+Y3J0RgIsN0PoMEEl5OiBwYTfMXt2yn
         sfnQ==
X-Gm-Message-State: APf1xPBpeug7VNfwgth3vjV3Oc/VDWp7VpWAJFCswuGWTGHvfV8IBnY0
        HhnvVC5T9PWCluyxw2dRIuEYRNfU
X-Google-Smtp-Source: AH8x226Qaw5iElkSC9cgSqd9WjKeDG1bvWwEiUOxjykikOoGtfu4Gtu5KilFwVGGeQg1Be6Or6yNtA==
X-Received: by 10.223.138.130 with SMTP id y2mr16147508wry.242.1519853540867;
        Wed, 28 Feb 2018 13:32:20 -0800 (PST)
Received: from [192.168.0.104] (AToulouse-658-1-45-219.w86-221.abo.wanadoo.fr. [86.221.52.219])
        by smtp.gmail.com with ESMTPSA id p76sm3110759wmb.19.2018.02.28.13.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 13:32:19 -0800 (PST)
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180228172906.30582-1-alban.gruin@gmail.com>
 <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
Date:   Wed, 28 Feb 2018 22:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> diff --git a/userdiff.c b/userdiff.c
>> @@ -38,6 +38,15 @@ IPATTERN("fortran",
>> +PATTERNS("golang",
>> +        /* Functions */
>> +        "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
> 
> Why is the brace (and possible following whitespace) optional?
> Considering that the language demands that the brace be on the same
> line, I'd think the brace should be mandatory.
> 

I did this to support non-standard formatting. It's a niche case though,
maybe we could only support the standard formatting and modify the doc
to reflect this change.

> I suppose you made whitespace after 'func' optional to be able to
> recognize a method (which hasn't been gofmt'd):
> 
>     func(x *X) name {
> 
> rather than the more typical:
> 
>     func (x *X) name {
> 
> I wonder if it would make sense to tighten the expression to recognize
> functions and methods as distinct cases:
> 
>     function: mandatory whitespace following 'func'
>     method: optional whitespace but mandatory '(' following 'func'
> 
> Your current expression could accidentally match:
> 
>     /*
>       Fish like to have
>       functors for lunch {
>       just like eels}.
>     */
> 
> but, even the suggested tighter expression could "accidentally" match
> example code in a comment block anyhow, so I guess it probably doesn't
> matter much in practice.
> 

Same as before, I did this to support non-standard formatting.
