Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E2C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351041AbiD1S3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351160AbiD1S3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:29:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE238185
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:26:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id r8so3801496qvx.10
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GpptQ4dy/k5LgIpiViLrDGDg5XfwfvJbJPmnlxdtL+E=;
        b=BBwH7DnvsUQtIZ7TDLpaVNjXn+kOMwBwZdOpQ5DVAAsSDw6vugUC4jtt6021g6NHr/
         00vhaWwB4JuA7Tmpd7qVOdNWfwcBc1vZJeV4oAipqg/ghEj9f2dLllid8pDvKy4ILFa+
         C0d+zXiRPWZaIRS5zVzez+iTOM2g0NJiMts+8aQSe3Nbm9GYEAZXSi2TcW2TBQM7MCgZ
         0eZ1Cs16z52DTNVnVzqu9eUIHMoOYjbptZAPf63ynGbEWNW7npYodCPJBfSMxaDe75oB
         EMpjl+VwH+/TVxCHUfmLZV2XCqvRPxYly6MmPMtpCF6yJklPcNzjSzjuX4pS9G90r4hT
         WK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpptQ4dy/k5LgIpiViLrDGDg5XfwfvJbJPmnlxdtL+E=;
        b=5EmFmYsI2fQhbNgiNJkjmrSq0LwxOc2shR2K6ZPljoUOgPGfLHzmIgyLeoPh8HPcjY
         jJkW2GIDFHFD7PKe3BqUN249U9UPAa+RdA2DAUH1fZlX2GWyeor2Ae4y7aPNS66RshhG
         sbjBuIJxREiVCeqpkTCeIH29eacVBHGbZb/zQXiseOioGgpyKsZGVHneNLJuH3P+MCLZ
         TwgRXajej6nd7C7EsMZIewQ8/5Kv6oFv462n+Koj12e9p/HTynG24UQ7my8c5Cy6mhH8
         arbtu4LopxZOQDK4q1h1DZP6UrFXTwIw2u2cWKyTo9GpO7vRosUh0WclHypmqtuSdtYZ
         IhVA==
X-Gm-Message-State: AOAM533HgcFJZb9RoI1spXfAlEarNZHntsmG8LiZ8hzk0ze+gePPj+FT
        XAKicZW020uQVA4i6SUB6iC1+SmAJp+YGw==
X-Google-Smtp-Source: ABdhPJylkVIlHGBY5kdN9lDFxUZYdkiNfZqUriCxkq9SiHU2iXiRP41B4cNfWW8sidypV/Qpscuvsg==
X-Received: by 2002:a05:6214:27ed:b0:456:2dfd:104f with SMTP id jt13-20020a05621427ed00b004562dfd104fmr19324832qvb.38.1651170360806;
        Thu, 28 Apr 2022 11:26:00 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a034a00b0069c06c95bf7sm318852qkm.14.2022.04.28.11.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:26:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] MyFirstContribution: drop PR description for GGG
 single-patch contributions
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <2f6ecbf260135efc2a7ad09564cf6c64ed6d6f0d.1651086288.git.gitgitgadget@gmail.com>
 <xmqqmtg6jim2.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <73b8834b-c2be-7e47-0f77-4853a5a051b7@gmail.com>
Date:   Thu, 28 Apr 2022 14:25:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtg6jim2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-04-27 à 17:56, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +NOTE: For single-patch contributions, your commit message should already be
>> +meaningful and explain at a high level the purpose (what is happening and why)
>> +of your patch, so you usually do not need any additional context. In that case,
>> +remove the PR description that GitHub automatically generates from your commit
>> +message (your PR description should be empty). If you do need to supply even
>> +more context, you can do so in that space and it will be appended to the email
>> +that GitGitGadget will send, separately from your commit message.
> 
> "separately from your commit message" wants to be clarified.  It
> sounds as if GGG will send a separate message.
> 
> I am _guessing_ that you meant something like "the body of your
> proposed log message ends with your sign-off and followed by a line
> with three-dashes on it.  After that three-dash line, and before the
> diffstat and the patch, is an appropriate place to write additional
> information that are meant to help reviewers during review but will
> become irrelevant after the review is done.  Your PR description
> will appear there for a single patch contribution".

Yes, this is what I meant. I'll try to phrase it differently.

> 
> If we do not explain the space after the three-dash line elsewhere,
> perhaps we should do so separately, like we talk about cover
> letters.

Yeah, it is explained in the "Bonus Chapter: One-Patch Changes" subsection [1]
at the end of the "Sending Patches with git send-email" section, so I guess
people only reading the GitGitGadget instructions will not read that far...

Considering your other comment, I think that a little section titled something like
"Anatomy of a patch series" would make sense to introduce how then end product
looks like and then the sections on GGG or git-send-email can reference this earlier section.

Good idea.
Thanks!

Philippe.


[1] https://git-scm.com/docs/MyFirstContribution#single-patch
