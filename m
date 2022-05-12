Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41CC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359593AbiELXns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359584AbiELXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9BB289BCB
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so3900522wmq.1
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmaTi3iMcqfH3DlAXD5zkK24n74C5FauFWxtmrgwbag=;
        b=e/ik2RuW0GDJXzX5IcJHkSOt1HKaM4l9qLlCaTkDprnlBrDSaPNzRJy13TmPhXcRCe
         TJM9F5CQmE3/P1zeiGzZrcoR49rLeeAtdg+gSEKZqpKy4FX3I66Anj/U+WBNdeohqcIE
         IPkmmfxl7QT5KpdRe/e5AmKxJdK8t9FUV12IlY9hNSWch9BPpjc2HeoAy+NDeyFf0Woq
         H+o/hggEESFybcji74tFi1eJJgCl5ewD5gALPQXMVHfdvp2WXSmFCBG1OdqPQ/Xppl8H
         vDBhjb7Mq5HvuEuFjJvcKPjxdrVjtpQ1tCEIpDy+dnwGyaEe1Z1G6uzS3i2l6G6GJ6C7
         BqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmaTi3iMcqfH3DlAXD5zkK24n74C5FauFWxtmrgwbag=;
        b=yGPAbsEsiSjKfsuNYzYFKTrBmuPYnm9s7WMI/S7HHPIYtatfV+EqWb2T35Ttp+PBAg
         VpoScoo0N0twNtVY6JCCUpC8s9UCa3fv4zbiDYQ3JjHT655K+xe4EaZ3vMXMPk963NyV
         pJfk4/dHK3nZrBR5ZDcu5tZiBerCncY7mL7OAHX8T7OgYndkJJMLq2eBYhfaxIJ7lcir
         RnV4YxlA/E0bogjV3MfV3HcnGjldC/WTdep0ht1GcdonhpzTnR8y+cVoBluCIHV2SnKv
         oLT2CHXLLR7tgIQMDjD5sLMTDNRTwzcTjrogl2zF6LVDJDxhKsZoqRHy4m1DrWD5izyW
         5w+w==
X-Gm-Message-State: AOAM532gaurv3lQlzbBoFSh8JBNkEgRFC4yE5KLbdeLxbht5dlWs+Pdm
        AB3bhyunUCSFX0rbhLe/ysGTJ/bPFtU=
X-Google-Smtp-Source: ABdhPJxvH4LGPsNxJ2f4bM8uxWMg+8wrZtJHuyd5zV9UhOn2pg/cZkZ8msVyC/7Xb8N84EaLmaBglQ==
X-Received: by 2002:a05:600c:5104:b0:394:5d72:ff81 with SMTP id o4-20020a05600c510400b003945d72ff81mr12392967wms.123.1652399018600;
        Thu, 12 May 2022 16:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v28-20020adf8b5c000000b0020c5253d8cdsm729624wra.25.2022.05.12.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:37 -0700 (PDT)
Message-Id: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:32 +0000
Subject: [PATCH v3 0/5] Improve MyFirstContribution's GitGitGadget section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * tweaked 2/5 following Junio's comments (added more details, tweaked the
   wording and added a note about single patch series).

v2: Thanks a lot for the reviews! Here is an updated version.

Changes since v1:

 * Based on v1 feedback, instead of reusing the 'git send-email' content
   verbatim in the GGG section, added a new section and reference it in both
   'git send-email' and GGG sections. (patches 1/5-4/5)
 * In patch 5/5 (patch 3/3 in v1), tweak wording and add a reference to the
   "Bonus Chapter: One-Patch Changes" section.

v1: Two small improvements to the MyFirstContribution tutorial:

 * Describe the purpose of the cover letter in that section also, and give
   an example just as in the 'git send-email' section
 * Instruct contributors to drop the GitHub-generated PR description for
   single patch contributions.

Philippe Blain (5):
  MyFirstContribution: add "Anatomy of a Patch Series" section
  MyFirstContribution: add standalone section on cover letter
  MyFirstContribution: reference "The cover letter" in "Preparing Email"
  MyFirstContribution: reference "The cover letter" in GitGitGadget
    section
  MyFirstContribution: drop PR description for GGG single-patch
    contributions

 Documentation/MyFirstContribution.txt | 155 ++++++++++++++++++++------
 1 file changed, 120 insertions(+), 35 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1226%2Fphil-blain%2Fmyfirst-contrib-single-patch-ggg-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1226/phil-blain/myfirst-contrib-single-patch-ggg-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1226

Range-diff vs v2:

 1:  59af7e5e5ad = 1:  59af7e5e5ad MyFirstContribution: add "Anatomy of a Patch Series" section
 2:  9552d80a80d ! 2:  ee3238f5a91 MyFirstContribution: add standalone section on cover letter
     @@ Commit message
      
       ## Documentation/MyFirstContribution.txt ##
      @@ Documentation/MyFirstContribution.txt: We can note a few things:
     -   v3]", etc. and sent with a new cover letter, itself a reply to the cover
     -   letter of the previous iteration (more on that below).
     - 
     +   _n_-commit series.
     + - Each patch is sent as a reply to an introductory email called the _cover
     +   letter_ of the series, prefixed "[PATCH 0/_n_]".
     +-- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
     +-  v3]", etc. and sent with a new cover letter, itself a reply to the cover
     +-  letter of the previous iteration (more on that below).
     ++- Subsequent iterations of the patch series are labelled "PATCH v2", "PATCH
     ++  v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
     ++  three patches in the second iteration. Each iteration is sent with a new cover
     ++  letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
     ++  previous iteration (more on that below).
     ++
     ++NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
     ++_i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
     ++though).
     ++
      +[[cover-letter]]
      +=== The cover letter
      +
     @@ Documentation/MyFirstContribution.txt: We can note a few things:
      +Be sure to explain anything your patches don't make clear on their own, but
      +remember that since the cover letter is not recorded in the commit history,
      +anything that might be useful to future readers of the repository's history
     -+should be in your commit messages, not in your cover letter.
     ++should also be in your commit messages.
      +
      +Here's an example body for `psuh`:
      +
     @@ Documentation/MyFirstContribution.txt: We can note a few things:
      +This patchset is part of the MyFirstContribution tutorial and should not
      +be merged.
      +----
     -+
     + 
       At this point the tutorial diverges, in order to demonstrate two
       different methods of formatting your patchset and getting it reviewed.
     - 
      @@ Documentation/MyFirstContribution.txt: but want reviewers to look at what they have so far. You can add this flag with
       Check and make sure that your patches and cover letter template exist in the
       directory you specified - you're nearly ready to send out your review!
 3:  d7699289ea6 = 3:  2caec6e619a MyFirstContribution: reference "The cover letter" in "Preparing Email"
 4:  f6034b0964b = 4:  02598d431e0 MyFirstContribution: reference "The cover letter" in GitGitGadget section
 5:  33256c6b4ba = 5:  76bcb6612e4 MyFirstContribution: drop PR description for GGG single-patch contributions

-- 
gitgitgadget
