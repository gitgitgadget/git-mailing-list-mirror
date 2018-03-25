Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBC51F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeCYSTX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:19:23 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44219 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeCYSTW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:19:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id j26so17450681qtl.11
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cRtdVsXKNDeAWBcOQQTn0vEMPm1HuDEa3MoT7GPVZx0=;
        b=fu8A+40HulImIRUmZS2/IMVmjMNvZ3GokeNQw8S+I6ZYugExwGZ71JUwDJus6VgRQF
         5szkNaTfPXPssHONYlKyD0Ye40sMOvLI7DlfHUrfkE48EhpxN6G2MVs3N88AEuwSSotu
         TVbvgPEa16ygTNiWnjUk4k6VllI788h9+AK7scpcXvIZn8Jp0wuW7E2apYjxRjgWeA1z
         0mm943QCdCQQxeoOC5WqIzG07websKJTHOgFWD/3FPdeQIvAG2imG19Of8h7AhOVqDJ0
         Fr/qYP065x2R2MmYu5cNJga7G7rlOo9piHzjcaS0zM13oLWJKU+QCt2pg8BsgST86hd4
         +2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cRtdVsXKNDeAWBcOQQTn0vEMPm1HuDEa3MoT7GPVZx0=;
        b=OHVhEfqbmXALqsLqfZn/kxlx0DlnoERmmBwGmJc1GW0B+pVajbpsBJpOpP+s5HPwX5
         W0rDlSVLl/iYYrpu/6viOCsZZdeOXPLvZD4dQH3U4DBQeLuTI6oODzt4qVqismRRf7tx
         TYYklVbncjWsBAsEH7kRgYq6M3l4ROUBujN+CGpb0wTxondwwOQfoC+4yBsiOG+DScM+
         tf0ajUPYfxLvqfxYwIb3Z531EMycmKr9B0ph5mLiPV8Sc27fJY1FycP6kR1KxQp2jBzn
         AhFs0XeGYLrqmxVn3RzRamiAS8YeYrjqhisRzLMGv7yyknGFn47LOSIh/Gki4fAX5ya9
         ATPQ==
X-Gm-Message-State: AElRT7GsXIRWam8laymed13zR0MF+RHn086TixpjFLJpvzK0hMCxDK5h
        5CAkebaAea9XwAMBHP4ypb4=
X-Google-Smtp-Source: AIpwx4+Amhnc13kl5/774iZYbncNGQUrMLK5Xv/awlwjk0TpU+7bRD4qLXw/0YNj+gG2WK6ak4+kVw==
X-Received: by 10.237.51.33 with SMTP id u30mr25300572qtd.257.1522001961249;
        Sun, 25 Mar 2018 11:19:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 92sm10001234qta.5.2018.03.25.11.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:19:20 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takuto Ikuta <tikuta@chromium.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com>
 <87k1u2y8pg.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2d0a2e2-44a1-9aa6-9c52-e341b44c18f4@gmail.com>
Date:   Sun, 25 Mar 2018 14:19:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87k1u2y8pg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2018 1:59 PM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Mar 21 2018, Junio C. Hamano wrote:
>
>> A release candidate Git v2.17.0-rc1 is now available for testing
>> at the usual places.  It is comprised of 493 non-merge commits
>> since v2.16.0, contributed by 62 people, 19 of which are new faces.
> I have this deployed on some tens of K machines who all use git in one
> way or another (from automated pulls, to users interactively), and rc0
> before that, with a few patches on top from me + Takato + Duy + Derrick
> since rc0 was released (and since today based on top of rc1). No issues
> so far.
>
> The specific in-house version I have is at:
> https://github.com/git/git/compare/v2.17.0-rc1...bookingcom:booking-git-v2018-03-23-1

Thanks for testing the commit-graph feature, Ævar! I'm guessing you have 
some mechanisms to ensure the 'git commit-graph write' command is run on 
these machines and 'core.commitGraph' is set to true in the config? I 
would love to hear how this benefits your org.

Thanks,
-Stolee
