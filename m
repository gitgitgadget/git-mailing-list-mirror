Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7446C1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935513AbeB1WnP (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:43:15 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:55055 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935428AbeB1WnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:43:14 -0500
Received: by mail-wm0-f46.google.com with SMTP id z81so7989360wmb.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NfL/of+3hkO9pL5aKAQD20eXT8rQOMsfamlg0a34PfM=;
        b=KiWQt7nYpLGCx2rR0S4TCF9zVAukTlj/XxTyDPOOqU4WspdRR92zDKXdzJt6jgMi1f
         9KNqhFjZYd3dx/w8s3z4BIS179tTiTtY6n77xuESpwkUfF0uaGuhHJEzn6bDtlUMj9Fb
         sG8IsQG+K2wZdX2tmiKofQrGhUN94T1s8GlDAyyhbbMLZQibjuU96Qb2bdDwyQvvAiYh
         upsTRuZJCMFtzMpHh1hIC6XDkLu7wXbyy6Cy/JDVe83fg/0Zc9Lvl1A8Y/ZtcdCF8QBs
         WeFB/lzDNwtflLM/7X0TbJAYvrpmQ0/IceYQ8oPtxZem789aoo/NNeKSuhvVdJeNgLxr
         PU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfL/of+3hkO9pL5aKAQD20eXT8rQOMsfamlg0a34PfM=;
        b=gPbWlCCVBxy6bMkmybVwRAe3gM4WS0wzZVqyiGI0BuxnbzGgMkeYhivhgEWF6LlCQ5
         qVVrYCwtJ627vZ8vO3CWePORhVJQVxmAsjDDVVDnE+Jy4lGxmUxDv2cYEdEiMRrTUAsa
         nKbQtHbCdx9qgpGNT0LU8Qo5FV3uYQWntjspFEpVUbqIDSnVyilRbb+mF+pEaalwedlO
         6pKvDIvxMvtRmzQr7SB7FTAPm6BLbCOX3dUi7iXmDTBx3eblj8ibjIqeRZEzs6GC3U8u
         oinjoJImutpZ1ct9DD7AyCDMBauFKsO30v0/U+Tcx079RIcMlTr4SIaBkofu9brPpeXF
         SnVg==
X-Gm-Message-State: APf1xPBBdAgKsJDcBYzHNWUzNodB7rXbL7EQqJpqabIXmjMuNoZvQCXa
        LvhTE8bY1+xZUk2HqzAex/jpqDY0
X-Google-Smtp-Source: AG47ELvY/Mun7h7TKm0fhQtnzOv8Bf4EvCETMc2pBTXFYI5gy3tKn5VfLOGLO7Ck89Gvbl08Gft71w==
X-Received: by 10.28.1.14 with SMTP id 14mr81050wmb.40.1519857792689;
        Wed, 28 Feb 2018 14:43:12 -0800 (PST)
Received: from [192.168.0.104] (AToulouse-658-1-45-219.w86-221.abo.wanadoo.fr. [86.221.52.219])
        by smtp.gmail.com with ESMTPSA id 198sm4842907wmg.8.2018.02.28.14.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 14:43:11 -0800 (PST)
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180228172906.30582-1-alban.gruin@gmail.com>
 <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
 <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
 <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
 <b9aa0939-8b20-0f35-84f4-5b519080ca34@gmail.com>
 <CAPig+cQ3MuFhMHKGyejE2o0WnVZGvLwcLVgVLpshU_j01MkcaA@mail.gmail.com>
 <xmqqvaegiw3o.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <5683c0ae-9510-a54f-c50e-79718cb2eb1e@gmail.com>
Date:   Wed, 28 Feb 2018 23:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaegiw3o.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 28/02/2018 à 23:32, Junio C Hamano a écrit :
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Wed, Feb 28, 2018 at 5:17 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>>> Yes, but I can split the line like that:
>>>
>>>     % cat >baz.go<<\EOF
>>>     package baz
>>>     func baz(arg1 int64,
>>>         arg2 int64) {
>>>     }
>>>     EOF
>>>     % go build baz.go
>>>
>>> This complies to the standard formatting (at least, gofmt doesn't change
>>> it), but making the regex strict about the brace would cause it to
>>> ignore those funcs, although I don't know how common they are.
>>
>> Makes sense. Thanks for the clarifying example. I wouldn't be at all
>> surprised it such formatting exists in the wild, so keeping the regex
>> as-is seems a good idea.
> 
> Does input like that appear in the tests the patch adds?  If not, it
> probably is a good idea to have it somewhere in the commit (even if
> there is no test addition, having it in the log message to explain
> why the regex is done like so would be a good idea).
> 
> Thanks.
> 

Yes, it's in a file called "golang-long-func".  I'll send another patch
later to fix the typo in the commit message and the indentation in the
tests. I'll clarify the regex in the message, too.
