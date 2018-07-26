Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E741F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeGZNUY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:20:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37838 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbeGZNUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:20:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so1018216lfb.4
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+n2hFeDuq90kKT2VX3fGToaAEnDYx/6iStZCiVx+3A=;
        b=I+SdPtai/lCyiIE34fQ3s0/QbRx8fcLHsMc4t75RZEtbA41gDw1qd83egePVi3TI5h
         cWFzhaga9bsFxJZW6etpwGT9HHEdjmaBtkZ8/UfIOQ8eH3CHVA0oMkDTziUUm+UCN9yn
         kVmw0hDM9/GWASsLv+hs2Xi3Jvvk/L//0pTj77j6bPqBQq+V4FrZyUFO0km1Yni0Hxzo
         7zEzywviG4NEg9nTW01AwvVPIL1LarubtVKv7YaXi/V6xfewywWkJR/+iUpZnQ5qfFaq
         bKWs08DBRTAnVXSW6op7hc2/jhzgjl/4uCOGIGBAaTNarBkiLdP4qOSip0JcKGXQfr9q
         PY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+n2hFeDuq90kKT2VX3fGToaAEnDYx/6iStZCiVx+3A=;
        b=Ss89G6qGu0NMwOvqwuxWC9GMqpt4Ekw9r4BUpyHUP4LNWIJVKOuxcdhcisx9BWukeI
         lh0yR23N3CTwZGvAT6Z7Ucej5/5H/dTqSQRg61YI7q3se7jmkeO+ifbOCn/OTrWgoGQP
         JODan1S6bR6n5UhhQeXb9xDQCshv9fh4rSHm1FwlJ/SgIZpoInSXURPQA6yNBOVfqw1Z
         nqG/SVikown0e256EhL86OfIMkXKuHYVHIIGyEFg3TEZLnzCnpBoHNsdkvUaoUj9Q1vd
         BqHu6F+/JwSYNeDnztFZ3/gDNesIDMzdmXAaCE0s3qGzQoBYcZOJjH7z3l/PEPKajjXa
         tn0g==
X-Gm-Message-State: AOUpUlFqt1mzCkZcnJLTxc/5lMUHF2zvC7BUplFJF8MVcxtSNL6G6Bk7
        pWpVdLAZiXsdwTteurtaGZI=
X-Google-Smtp-Source: AAOMgpfs6g3iVFvQYClAqL9unmvWpFVf/wQzqLYceJKIwFfSj2qSnwM2RFiVRZAdGlFfpdG9rf80mA==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr1221871lfl.78.1532606630949;
        Thu, 26 Jul 2018 05:03:50 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id m129-v6sm158911lfe.50.2018.07.26.05.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 05:03:50 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <b8c65df5-d150-1bc6-1858-c2c042ae4bb2@gmail.com>
Date:   Thu, 26 Jul 2018 14:03:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-05-30 10:03, Eric Sunshine wrote:
> Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
> git-branch-diff[1] which computes differences between two versions of a
> patch series. Such a diff can be a useful aid for reviewers when
> inserted into a cover letter. However, doing so requires manual
> generation (invoking git-branch-diff) and copy/pasting the result into
> the cover letter.
> 
> This series fully automates the process by adding a --range-diff option
> to git-format-patch. 

[...]

> 
> Eric Sunshine (5):
>   format-patch: allow additional generated content in
>     make_cover_letter()
>   format-patch: add --range-diff option to embed diff in cover letter
>   format-patch: extend --range-diff to accept revision range
>   format-patch: teach --range-diff to respect -v/--reroll-count
>   format-patch: add --creation-weight tweak for --range-diff
> 
>  Documentation/git-format-patch.txt |  18 +++++
>  builtin/log.c                      | 119 ++++++++++++++++++++++++-----
>  t/t7910-branch-diff.sh             |  16 ++++
>  3 files changed, 132 insertions(+), 21 deletions(-)

Would it make sense to mention new option in the cover letter section of
Documentation/SubmittingPatches?

--
Best regards, Andrei Rybak
