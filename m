Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87943C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 04:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiBBEws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 23:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiBBEwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 23:52:47 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30879C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 20:52:46 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so18370945oth.12
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 20:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/C8uqoGt2wOZMX1U74eKr4c/wWEq+ENg7PQx309yKW8=;
        b=ZsUiYSfYGapNlbqEfKJkoFvAhZdk7axjPfSixVXb6x2X9xV/yJdyCeX3KmrtusbfR8
         BusBjk+ZJMezjoTDSL31HMYnIVdAtR3VBrwlTsnSUKSGq4zPYiXQtb4zrj/Q7ExIklT6
         cxgjg13oecf8bSMYkeMFOQooRJxPWEBs/92SQUGAEgYFLFuop9t4AJpXMAxfLspRnBD9
         xxwGCm9ZJqEiYMN+XzPB/bGrW+MeQ/Bz8180ZtkrnC/NhvEfzzv4WiasrJ68HfcFJaqK
         kEX3Z4NGANdq8Ex14U/TitGr+LlOoVTclMkIamQmAo5/7YQwr6iexEDEtgu4lz5+xDse
         jdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/C8uqoGt2wOZMX1U74eKr4c/wWEq+ENg7PQx309yKW8=;
        b=hq50Js7AOfYXFiNG4ODKTHt2s/RderXhiigZhBH9gVA6xl19thJDcdSPtC6DxkbGBv
         hs7HdiH7pbj1qzdb4xqrAg8OryjJQqilMb8NeNMsSorpDE+WrIZVEXCTbFPg3VAUyw8Q
         XWSGYnirzdVkMbprSjLQiwSldgDScmooNIV7gum3WZk7AIKSShPjvFSS9HI4aibSPs55
         ka0l6NO02TruDltHYwBaSlt/ODUfTXj3WuMzpONtG56p6LXSXhGIXBHAPkmxdcu3uuQX
         AKaKPOuBu1KnTMczGkSKGW4TWSuvPJnBpv1OQtDaiVskXGhkmENuyNwh7AfFDmcgrMJZ
         6jKQ==
X-Gm-Message-State: AOAM5324URzAyk5gDX/5DkXtmhLgGE9XIPEr84uGSaYKgERyR1Q7MJif
        aNe+ueTP5emR1YqWPZYt+SxiV8nPzsSbB8oHCNO9+nRdGqHZPg==
X-Google-Smtp-Source: ABdhPJz4y4fPSonmvRDTy2Xy7fPLvXiffg4TOBBdbM8ToQoGjx0Okq4Zc91y8sB+8ddNYlSeh4pT5qoRqvtArqvvers=
X-Received: by 2002:a05:6830:448c:: with SMTP id r12mr12374216otv.114.1643777565503;
 Tue, 01 Feb 2022 20:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220130094357.515335-1-shaoxuan.yuan02@gmail.com> <20220130094357.515335-2-shaoxuan.yuan02@gmail.com>
 <xmqq35l29mcu.fsf@gitster.g>
In-Reply-To: <xmqq35l29mcu.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 2 Feb 2022 12:52:33 +0800
Message-ID: <CAJyCBOTs-b98q7b7THCZvqS=yVqgoOm4XshoOAQyuusy6S6pBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t/lib-read-tree-m-3way: replace double quotes with
 single quotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 7:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> The old one does not use "double quotes", though ;-)
>
> Also, the above belongs to the log message proper, as it would help
> readers of "git log" in the future, as opposed to merely helping
> reviewers only while the patch is under review (e.g. differences
> between v1 and v2 is a good thing to write after "---", as "git log"
> readers will not have access to v1, and will not even want to know
> that there was v1).

Thanks, think I should put the explanation message above the "---"
so "git log" has it. It's a really helpful tip (I think I was too
cautious to put
more message above "---" so I just left it blank but a commit title).

> Documentation/SubmittingPatches has more hints on the log message
> writing to help anybody who wants to participate in this project.
>
>  * The title summarizes what problem is being solved (yours is
>    fine).
>
>  * Then the status quo is explained in the present tense.
>
>  * Readers are made to realize what is wrong about the status quo.
>
>  * The approach taken to solve that problem is outlined.
>
>  * Then orders are given to the codebase to "become like so" in
>    imperative mood.
>
> Applying the above to this patch:
>
>         t/lib-read-tree-m-3way: modernize style
>
>         Many invocations of the test_expect_success command in this
>         file are written in old style where the command, an optional
>         prerequisite, and the test title are written on separate
>         lines, and the executable script string begins on its own
>         line, and these lines are pasted together with backslashes
>         as necessary.
>
>         An invocation of the test_expect_success command in modern
>         test scripts however writes the prerequisite and the title
>         on the same line as the test_expect_success command itself,
>         and ends the line with a single quote that begins the
>         executable script string.
>
>         Update the style for uniformity.
>
> or something along that line, perhaps?

Another thanks. I should've been reading throughout the details in
Documentation/SubmittingPatches and I'm doing so.

I will try to get the format straight as per the suggestions (learned
a lot from them)
and documentation then submit a v3 sooner :-)

--
Thanks,
Shaoxuan
