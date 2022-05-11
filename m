Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A9AC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 17:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbiEKRpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiEKRpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 13:45:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D94219F69
        for <git@vger.kernel.org>; Wed, 11 May 2022 10:45:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a19so2203113pgw.6
        for <git@vger.kernel.org>; Wed, 11 May 2022 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KI9i4nP/ddy3wA3rBT23oIHvt+35FmBIKGVQF4gS1A8=;
        b=Yd3j9gLoKzskZCG8AvdFZMdTDjsg5TqnUGsboCky3VBL4HrqleVhoMR3boB1BVoXEN
         b3slMJbAZVBIQB9sQ2mAwny9rQi97SplWepBFAL8lybDI1R2o6QXKBEBN09sxUFOjDO4
         GYA61JqvqX90YBw90/n/XHA0g4ayvo7tKQ5DifVwlYjpTQ6d+xVs1az4tK7Ma26stPHD
         9yNB5bZQRcnym9iBHW/1ZIFv5huiWTiA9deWCBT2jnj8KHPOPLRyIIsflmim5rjtM3T1
         g1FQLfXCpjLyyjgugilfzkoHL7wyFrpmdfWUU66qNuuag0sqR0vgqOphgHyOwjwFMiYy
         6llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KI9i4nP/ddy3wA3rBT23oIHvt+35FmBIKGVQF4gS1A8=;
        b=qigvqCXJow9frwahR23G1hyffJOI/40bgRfMVrmvTKhgXnOSvnQf7/UEvZAafF3RF0
         n0Cyq+CsYa/3iHsxrdtwF4MsCcUAiQ6bNkFUimMNHmP1YzIDi9bT8ZMATFrCiWojUdcD
         qwH3nRxmXiTA4ho9QbTFh8NUFZIyY0yYIfEQ7gv6jPfZ8sq/yrS9CT/kauGN/yslPcnC
         N/QOfiq9PMQeTq++J4IlflgVZMb+9Ntt74GqeEChgCj/cIGSp+IANlG3P11yQOwXUsQa
         m2UN/QrmFbUZrgWJh6aq+VOE4W0gzncX3YVVF4R2sIrefB5qAeCn7gHr0mk5rIKHasPC
         fkrg==
X-Gm-Message-State: AOAM533+9AMQbDninIFUTgIr0cbdsr30yHCYUvzzbu8i7kQq+uE9pBin
        no0ImUkBjwl/Wo+lS6gPqnEG+Lls6zVQ
X-Google-Smtp-Source: ABdhPJxhOJFj2umxANnCqLJO4JK19PbH88a6Db0dk/slXoEpgCKTIpGDYZdzRAFcLqPX46Hi1CqBnQ==
X-Received: by 2002:a63:455e:0:b0:3c6:270f:cec4 with SMTP id u30-20020a63455e000000b003c6270fcec4mr21549505pgk.417.1652291108486;
        Wed, 11 May 2022 10:45:08 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b0015e8d4eb21asm2210519plh.100.2022.05.11.10.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:45:07 -0700 (PDT)
Message-ID: <becf5e06-ddd3-62af-5b85-3e4ce8a4017f@github.com>
Date:   Wed, 11 May 2022 10:45:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/5] Improve MyFirstContribution's GitGitGadget section
Content-Language: en-US
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> Thanks a lot for the reviews! Here is an updated version.
> 
> Changes since v1:
> 
>  * Based on v1 feedback, instead of reusing the 'git send-email' content
>    verbatim in the GGG section, added a new section and reference it in both
>    'git send-email' and GGG sections. (patches 1/5-4/5)
>  * In patch 5/5 (patch 3/3 in v1), tweak wording and add a reference to the
>    "Bonus Chapter: One-Patch Changes" section.
> 

This version addresses all of my earlier comments, and overall looks good to
me. Thanks again for updating this documentation!

> v1: Two small improvements to the MyFirstContribution tutorial:
> 
>  * Describe the purpose of the cover letter in that section also, and give
>    an example just as in the 'git send-email' section
>  * Instruct contributors to drop the GitHub-generated PR description for
>    single patch contributions.
> 
> Philippe Blain (5):
>   MyFirstContribution: add "Anatomy of a Patch Series" section
>   MyFirstContribution: add standalone section on cover letter
>   MyFirstContribution: reference "The cover letter" in "Preparing Email"
>   MyFirstContribution: reference "The cover letter" in GitGitGadget
>     section
>   MyFirstContribution: drop PR description for GGG single-patch
>     contributions
> 
>  Documentation/MyFirstContribution.txt | 149 ++++++++++++++++++++------
>  1 file changed, 114 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1226%2Fphil-blain%2Fmyfirst-contrib-single-patch-ggg-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1226/phil-blain/myfirst-contrib-single-patch-ggg-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1226
> 
> Range-diff vs v1:
> 
>  -:  ----------- > 1:  59af7e5e5ad MyFirstContribution: add "Anatomy of a Patch Series" section
>  -:  ----------- > 2:  9552d80a80d MyFirstContribution: add standalone section on cover letter
>  1:  7e84d5b286d ! 3:  d7699289ea6 MyFirstContribution: move cover letter description to a separate file
>      @@ Metadata
>       Author: Philippe Blain <levraiphilippeblain@gmail.com>
>       
>        ## Commit message ##
>      -    MyFirstContribution: move cover letter description to a separate file
>      +    MyFirstContribution: reference "The cover letter" in "Preparing Email"
>       
>      -    In a subsequent commit we want to reuse the explanation of the purpose of
>      -    The cover letter form the "Sending Patches with git send-email" section
>      -    in the "Sending Patches via GitGitGadget" section.
>      +    The previous commit added a standalone section on the purpose of the
>      +    cover letter, drawing inspiration from the existing content of the
>      +    "Preparing Email" section.
>       
>      -    To avoid text duplication, move this explanation to a separate file and
>      -    include it in MyFirstContribution.txt.
>      +    Adjust "Preparing Email" to reference "The cover letter", to avoid
>      +    content duplication.
>       
>      -    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>      +    Also, use the imperative mode for the cover letter subject, as is done
>      +    in "The cover letter".
>       
>      - ## Documentation/MyFirstContribution-coverletter.txt (new) ##
>      -@@
>      -+This is an important component of change submission as it explains to the
>      -+community from a high level what you're trying to do, and why, in a way that's
>      -+more apparent than just looking at your diff. Be sure to explain anything your
>      -+diff doesn't make clear on its own.
>      -+
>      -+Here's an example body for `psuh`:
>      -+
>      -+----
>      -+Our internal metrics indicate widespread interest in the command
>      -+git-psuh - that is, many users are trying to use it, but finding it is
>      -+unavailable, using some unknown workaround instead.
>      -+
>      -+The following handful of patches add the psuh command and implement some
>      -+handy features on top of it.
>      -+
>      -+This patchset is part of the MyFirstContribution tutorial and should not
>      -+be merged.
>      -+----
>      +    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>       
>        ## Documentation/MyFirstContribution.txt ##
>      -@@ Documentation/MyFirstContribution.txt: filter their email for this type of flag.
>      +@@ Documentation/MyFirstContribution.txt: directory you specified - you're nearly ready to send out your review!
>      + [[preparing-cover-letter]]
>      + === Preparing Email
>      + 
>      +-In addition to an email per patch, the Git community also expects your patches
>      +-to come with a cover letter, typically with a subject line [PATCH 0/x] (where
>      +-x is the number of patches you're sending). Since you invoked `format-patch`
>      +-with `--cover-letter`, you've already got a template ready. Open it up in your
>      +-favorite editor.
>      ++Since you invoked `format-patch` with `--cover-letter`, you've already got a
>      ++cover letter template ready. Open it up in your favorite editor.
>      + 
>      + You should see a number of headers present already. Check that your `From:`
>      +-header is correct. Then modify your `Subject:` to something which succinctly
>      +-covers the purpose of your entire topic branch, for example:
>      ++header is correct. Then modify your `Subject:` (see <<cover-letter,above>> for
>      ++how to choose good title for your patch series):
>      + 
>      + ----
>      +-Subject: [PATCH 0/7] adding the 'psuh' command
>      ++Subject: [PATCH 0/7] Add the 'psuh' command
>      + ----
>      + 
>      + Make sure you retain the ``[PATCH 0/X]'' part; that's what indicates to the Git
>      +-community that this email is the beginning of a review, and many reviewers
>      +-filter their email for this type of flag.
>      ++community that this email is the beginning of a patch series, and many
>      ++reviewers filter their email for this type of flag.
>      + 
>        You'll need to add some extra parameters when you invoke `git send-email` to add
>        the cover letter.
>        
>      @@ Documentation/MyFirstContribution.txt: filter their email for this type of flag.
>       -This patchset is part of the MyFirstContribution tutorial and should not
>       -be merged.
>       -----
>      -+Next you'll have to fill out the body of your cover letter.
>      -+include::MyFirstContribution-coverletter.txt[]
>      ++Next you'll have to fill out the body of your cover letter. Again, see
>      ++<<cover-letter,above>> for what content to include.
>        
>        The template created by `git format-patch --cover-letter` includes a diffstat.
>        This gives reviewers a summary of what they're in for when reviewing your topic.
>  2:  afb80b8e9ee ! 4:  f6034b0964b MyFirstContribution: also explain cover letter in GitGitGadget section
>      @@ Metadata
>       Author: Philippe Blain <levraiphilippeblain@gmail.com>
>       
>        ## Commit message ##
>      -    MyFirstContribution: also explain cover letter in GitGitGadget section
>      +    MyFirstContribution: reference "The cover letter" in GitGitGadget section
>       
>           The "Sending Patches via GitGitGadget" section mentions that the PR
>           title and description will be used as the cover letter, but does not
>           explain what is a cover letter or what should be included in it.
>       
>      -    Mention the purpose of the cover letter in that section, and give
>      -    examples for the title and description, leveraging the excerpt extracted
>      -    from the "Sending Patches with git send-email" section in the previous
>      +    Refer readers to the new "The cover letter" section added in a previous
>           commit.
>       
>           Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>      @@ Documentation/MyFirstContribution.txt: https://github.com/gitgitgadget/git and o
>        
>       -Review the PR's title and description, as it's used by GitGitGadget as the cover
>       -letter for your change. When you're happy, submit your pull request.
>      -+Review the PR's title and description, as they're used by GitGitGadget as the
>      -+cover letter for your change. The cover letter describes your proposed
>      -+contribution as a whole and is ideal to mention any context that might be
>      -+useful for reviewers. The title of your PR should be something which
>      -+succinctly covers the purpose of your entire topic branch, for example:
>      -+
>      -+----
>      -+Adding the 'psuh' command
>      -+----
>      -+
>      -+Your PR's description will used as the body of the cover letter.
>      -+include::MyFirstContribution-coverletter.txt[]
>      ++Review the PR's title and description, as they're used by GitGitGadget
>      ++respectively as the subject and body of the cover letter for your change. Refer
>      ++to <<cover-letter,"The cover letter">> above for advice on how to title your
>      ++submission and what content to include in the description.
>       +
>       +When you're happy, submit your pull request.
>        
>  3:  2f6ecbf2601 ! 5:  33256c6b4ba MyFirstContribution: drop PR description for GGG single-patch contributions
>      @@ Commit message
>           Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>       
>        ## Documentation/MyFirstContribution.txt ##
>      -@@ Documentation/MyFirstContribution.txt: Adding the 'psuh' command
>      - Your PR's description will used as the body of the cover letter.
>      - include::MyFirstContribution-coverletter.txt[]
>      +@@ Documentation/MyFirstContribution.txt: respectively as the subject and body of the cover letter for your change. Refer
>      + to <<cover-letter,"The cover letter">> above for advice on how to title your
>      + submission and what content to include in the description.
>        
>       +NOTE: For single-patch contributions, your commit message should already be
>       +meaningful and explain at a high level the purpose (what is happening and why)
>      @@ Documentation/MyFirstContribution.txt: Adding the 'psuh' command
>       +remove the PR description that GitHub automatically generates from your commit
>       +message (your PR description should be empty). If you do need to supply even
>       +more context, you can do so in that space and it will be appended to the email
>      -+that GitGitGadget will send, separately from your commit message.
>      ++that GitGitGadget will send, between the three-dash line and the diffstat
>      ++(see <<single-patch,Bonus Chapter: One-Patch Changes>> for how this looks once
>      ++submitted).
>       +
>        When you're happy, submit your pull request.
>        
> 

