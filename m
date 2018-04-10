Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A042E1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeDJUEk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:04:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJUEj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:04:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id g8so28497587wmd.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8sWZ3IPBqk/SOnmFt9raDdUsgVbMYwWiOqlSeMJk5yE=;
        b=VKbdlVCet788cXMeiH1MCiC3Lmh+5SmBF/ik9J8+AtjnWNPcgTd+H0Pm4QrulOZSHu
         Ljnjrh7t7BsP3Vi71W/NiYOQi5TFQMMfpFq1pzXmHBdGLZ6n5KIXLoU+9YJ1rdsnQ/Ji
         YqGS6hIGf9GsDf1m+hcVvkUDV0idm1y7U16fUCsw4WeKogIqInYf7C9cX96EC2Kjyk/m
         xsjyxl74qmka5d/XUdK32fCMR+RzePaWlwUMyC1tiZEgpnArMKAUkZ7WqICliJC8lef0
         ESiVS5n2zp9OiX0YWl1CnFY+nQkb6HzMHA5u7pWrlzdOD0y4loyqMwNOIKUbI5jUYkw5
         x2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8sWZ3IPBqk/SOnmFt9raDdUsgVbMYwWiOqlSeMJk5yE=;
        b=T+TbsgqsyPsD0j5ujz88ytTcL/HYZ128TWk1mfyHOCa6WTrLYRWi5uby0MsXRC79Cr
         YUevyinsx9Shq1V9v51EYktHS0LjXLHUOX0uuRe+m8PZyUQy+yt6l1/9BYUf3WENH+k6
         a6OdFJD+j4mGczLlMioVbGVtiH4Tp6uz1+nLqVuLiJISDqBNTXoDaEe59flTIxJtSNcc
         Hasit4rHJOZNNRlNloZRz0Bsz+GhdVmt4b4KNiAXMwebkba61a6OhxXD2XtjFNwVrCPw
         D5fjS57xiPWJps+SSZSmhl2WpN2DJiGX3sK++jAKdu3ab7PbV2fzASLCMeqImhLBCH2p
         R2OQ==
X-Gm-Message-State: ALQs6tBTCpR33bm/klq09pJ1SFh+3A7d7U7YHz4AINf8OpXHEpGeyCwW
        zftyQGoijmFE0GgCgsELCtIQcw==
X-Google-Smtp-Source: AIpwx48pu9W2nKouOXE1daz6Swidrh6LTVvC/m1pA5x6NIjym9Nf/Tya3iNL6SZ8BfuNw1tsRXOSOA==
X-Received: by 10.28.134.203 with SMTP id i194mr640043wmd.114.1523390677862;
        Tue, 10 Apr 2018 13:04:37 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:35db:2474:c452:ca1e? ([2001:a62:81d:ab01:35db:2474:c452:ca1e])
        by smtp.googlemail.com with ESMTPSA id z11sm3536689wre.15.2018.04.10.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 13:04:37 -0700 (PDT)
Subject: Re: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180410183224.10780-2-asheiduk@gmail.com>
 <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asheiduk@gmail.com; prefer-encrypt=mutual; keydata=
 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
 khKIKhAKu5lezA==
Message-ID: <f45ef7cb-dc0c-8c63-1d2f-6ece0d0091cc@gmail.com>
Date:   Tue, 10 Apr 2018 22:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2018 um 21:13 schrieb Martin Ågren:
> On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> The section 'post-rewrite' in 'githooks.txt' renders only one command
>> using backticks (`git commit`) but the other commands using single quotes
>> ('git-rebase'). Align this formatting to use single quotes.
>>
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> ---
>>  Documentation/githooks.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index f877f7b7cd..070e745b41 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -417,8 +417,8 @@ to abort.
>>  post-rewrite
>>  ~~~~~~~~~~~~
>>
>> -This hook is invoked by commands that rewrite commits (`git commit
>> ---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
>> +This hook is invoked by commands that rewrite commits ('git commit
>> +--amend', 'git-rebase'; currently 'git-filter-branch' does 'not' call
>>  it!).  Its first argument denotes the command it was invoked by:
>>  currently one of `amend` or `rebase`.  Further command-dependent
>>  arguments may be passed in the future.
> 
> Hmm, I wonder if that is actually intentional. `git commit --amend`
> could be run exactly like that and would do what this paragraph expects
> of it. The 'git-rebase' is a Git subcommand name, i.e., not some
> copy-paste command-line ready for use. If it were something like `git
> rebase -i HEAD~5`, I would expect the backticks.

That page mostly uses single quotes and no dash ('git send-email')for
formatting. Reading 'CodingGuidelines' my understanding is, that git
commands should be typeset with backticks, no dash (`git send-email`). 
So 'git-rebase' (an similar) *should* be typeset as `git rebase`. But
doing so consistently would be a full-diff for this manual page.

Should I do this?

> 
> A second discrepancy is the dash in "git commit" vs "git-rebase" and
> "git-ls-remote". That could perhaps be explained by the same reasoning.
> 
> Martin
> 

