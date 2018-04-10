Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDFD1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeDJM6C (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:58:02 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35007 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeDJM6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:58:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id u86so8238214pfd.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+jr5jvTOXT35UVLxwObbH9TatGoslGzIl+z2oDB4ZdI=;
        b=Z14zd8Qsgdhjyo9iuTkrzbjF/xAB2kUsxv3PNBvLKXnnBvR+7ctl/TEg/GlVnZOS9M
         Ab7jBtfHaPwq1tOzmxapdbHyF0QCXpI1hz+5klmWQmtI/6wTRWJbLdVY5LAYbeUiJWnT
         nhSa8pwkAWjxvAjfjAVXz55jA7sDgmmLfs5TnhM0CaCYxFog1cTnWIGrrvzhFkgYI6+g
         /FaaIoe70573tQ8wJh0w5sJccj2EryyqekzyppeMDpOQe2LRA987J7BXRFU36u4+60gU
         +ZD5aIvDoPonzfQwqb+BLnltixqKEGhfe8AUHfhW3PSWOR30HxSEtqnWX+U0R/R1Pk/T
         6ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+jr5jvTOXT35UVLxwObbH9TatGoslGzIl+z2oDB4ZdI=;
        b=BcL6Y9LLyBVCcDvVl1+GkpAbNEQOd2UQcIqk9txVwFGATydrnmrRkD8RNm1fAuw2D1
         JA6xAhoL8PvgoBtz/FntdFRHiMxuwwOQpnrwIQWok4M5x+B3aUczx9cDkrPWLp1bl4w3
         66INaygVSj9UZFXFmIogMxwp9PSpFTkChfYsZKMbeVDhn+n+J2ltND6zbI/T0GR9aLlx
         sxGq0w7+3xS7WmEhTkUTW7dMafCK4KKusWkCDxhc90JF5GoLhRy7+bpIeCOl1Q4/Axs2
         JuViRBqW/G8qFHFTzX0HQGLbeev1ErdxSMKVGDBclDoG5Lc0UUqCvZFtJRtpb9z9b8uE
         qlow==
X-Gm-Message-State: ALQs6tBgutqblt0AWs+fh1Z/MVDO0I3v5rUPhgSiMeE6gNToQh4oaa0n
        mmUBEmdpyYfqpmZ5GCSZo4nhMy1j
X-Google-Smtp-Source: AIpwx49lRP5fwJNHfa4c5cPgp/uzxevqcHdWMq2UxbCfNieY97lX1wovoVmyzJS0awab+GVbYwQ75A==
X-Received: by 10.99.96.79 with SMTP id u76mr200516pgb.199.1523365080741;
        Tue, 10 Apr 2018 05:58:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 204sm5190840pgb.67.2018.04.10.05.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:58:00 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
 <98394864-ece6-5112-0274-b2399087f207@gmail.com>
 <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
 <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
Date:   Tue, 10 Apr 2018 08:57:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>
> I guess we'd want a final cleaned-up round after all ;-)  Thanks.

v8 sent [1]. Thanks.

-Stolee

[1] 
https://public-inbox.org/git/20180410125608.39443-1-dstolee@microsoft.com/T/#u
