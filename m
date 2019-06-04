Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E3C1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfFDO42 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:56:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38746 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfFDO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:56:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so14091945qtj.5
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aaX9vvP1Pw0L8I3dQ3UhMvFnNnGhEvFivHMiIQ4Xv4g=;
        b=e8DRq3cvMGKJPuPeok97n7+RW+L9IOd+a5l/x2MqlldOS9PCrJeeF3x/hQGu6s+f3Z
         Ctw87GmwfcY353F5t3KYurAt/3P6HlOB7Q85xzQNYwvPlhEJK6fjbi+7zHHqQIeNOYFs
         +6T4TyoYJqNZu5poA6+EW6IdVhLaoj2rloGFQ0nvwYWh/3h20/oQQL83ze6jBOicmCon
         GgVK69XD7J9EpvjjNMiEcKI99gHpeh7agLOyOI74gS1AtzL39uXUK87228KQchbIjou+
         /oPy2d1apySXKk3uwAYUaePMCrHXOkbY7AoGs8iLNTFaRGMP3+EPmAu7Rz1nhOAbQpki
         yQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aaX9vvP1Pw0L8I3dQ3UhMvFnNnGhEvFivHMiIQ4Xv4g=;
        b=jRkM/nLDNKMT4XGb6uYTlO/5ZCVpOWCfKerNoudCzBejhwA/IiiguyC3kgp6u//+7z
         D6fK3BAia5b5IUG6PB1ZcQMWlsEtlIqVb6L5TmtLbtVvclUBwPI3ckzrDFNh2AXR7ama
         dqUwpC/x5jNoh25/I58MElfSuIXHofjb/cpG1Fm1+zQ3yDTdbc/FBDziTtYnimnvcu2z
         /6ERfMKtCsOTiKx8awvCeGbd06964BoBHhqyYuihY/Qmwaxw5lCGbN5TkpIAedYRuKa8
         q2jHw6ULHhKasUuT4y5mh4lEG2iKLFLHwHf8DMTosCqfpX01A/t+Cm7QfU73xdJPORLU
         cRQw==
X-Gm-Message-State: APjAAAUWUlu2iUItexmL/yx9jli+SNnLueevUOBcbwi9SIYw5kvhR8q8
        5Luy6jP8/i2t2oLBpl7G1r0=
X-Google-Smtp-Source: APXvYqwRhwTgfLX3nzY93QtqRSBzRJ+FhgshY46DM8E6+VrKx5idQ1ogHF6TZ8kwDoMAbuGlgr3VHg==
X-Received: by 2002:ac8:252e:: with SMTP id 43mr21558031qtm.61.1559660186990;
        Tue, 04 Jun 2019 07:56:26 -0700 (PDT)
Received: from [10.0.1.7] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id r40sm3053178qtr.57.2019.06.04.07.56.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:56:26 -0700 (PDT)
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update
 config defaults
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1906041641280.1775@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a89e2c3-cbca-176c-1964-7e25d90c0ff7@gmail.com>
Date:   Tue, 4 Jun 2019 10:56:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906041641280.1775@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2019 10:43 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 3 Jun 2019, Derrick Stolee via GitGitGadget wrote:
> 
>>  1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
>>     'large' as a value. This enables several config values that are
>>     beneficial for large repos.
> 
> I find `core.size` a bit non-descriptive. Maybe `repository.size` instead?

Thanks for the suggestion! If the "repository." doesn't make sense as a top-
level category, then maybe "core.repositorySize" would work?

A thought I had overnight that may broaden our options would be to think of
this as a tolerance for experimental features. Maybe "core.adoptionRing" with
options for "slow" and "fast", where "slow" takes things that have been cooking
a long while (index.version=4, core.commitGraph=gc.writeCommitGraph=1) and the
"fast" option gets all of those values plus the more experimental options
(status.aheadBehind=false, fetch.showForcedUpdates=false).

Alternate names with this slow/fast idea could be:

* core.experimentTolerance={none,low,high}

* core.autoConfig={none,some,all}

Hopefully these options can trigger some creativity to decide on a good
name that an experienced Git user could understand.

Thanks,
-Stolee
