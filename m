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
	by dcvr.yhbt.net (Postfix) with ESMTP id BECD61F464
	for <e@80x24.org>; Sun, 29 Sep 2019 01:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfI2BaU (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 21:30:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39040 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2BaU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 21:30:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so5951584ljj.6
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MALbgJabHoDHRs3I8zfSqSiy1gbp0EAkgHDQieoSEV4=;
        b=V3GjEFmlXqy4EnTal2s/5wF7DpbWGkWFlxA19WjWx0A1i6cdhzuhoUCdzmwOqb1fZM
         Gynp4zBQBQfbFAjlXTCx9UiJ5ZtS1qDDf0Zfk8ele6vBzBqUnYM0LP63TLDvz6eSNELT
         N/lSsCMjTTnWpPi1KixlJvi0+KM+SGpZEBuQ7ggyOL5H5jq0YKESWpffQVcVeghmKA2S
         5kWPXvsdtP6U/uHvlYH0zKZmiqkxWY2bKN4LHtPJyCKP72afzw61+nKBJJFz1vBSBMIQ
         ooekFyApj4fygqIGiN3DznWHigqvuV98a0KMcjQtc9f1Su+AjVRRPmi54z+OKXvJyzD7
         hkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MALbgJabHoDHRs3I8zfSqSiy1gbp0EAkgHDQieoSEV4=;
        b=PuyjLYuVfpoiN5EDtYDeEmiXnNumXRlgblaIRlX3VpAGdlGgyKz3GwRajFHvecE2mn
         wZWrQgF+iBZZ+dSPmgQnZY2RhZjp0Az9/OesUAz1/FSlFExsMyQKgqcDAjHc9ywNq855
         RvU9sIlrkux1EnQTKLSifzuVfSLHrZARBNz+tu2p9wKgxsj7PkiJyLtLBzT3YgNBF5uy
         CrWf6vCyV1PNKpwDEaPA8AomSGyuOl+C+ny2itjdsl+Io2tluqlLV9AlaoJlgNo69+JM
         0It60NIiwEGNv1NFvyQx/wq4fDDPI93LT2lzOPP0f4v/i7o7raHsUXQOL2bWuoNSdxHk
         7mZA==
X-Gm-Message-State: APjAAAUyEa2c/MUnhKQhQ49wMdotqw1J+WR2S8b0n6AwwqtgYrpEsEoB
        3j1awanvDp8T5EFqN1kFDO0F3c8F
X-Google-Smtp-Source: APXvYqzhDP5CpJ16EAf/j19wK2UEQKiKQv9R4b5AI1TZVpY/ke8oEuCUd14Z3fAnRh+5exvxGc+pKA==
X-Received: by 2002:a2e:63da:: with SMTP id s87mr7380416lje.79.1569720618370;
        Sat, 28 Sep 2019 18:30:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm1689539lfn.12.2019.09.28.18.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 18:30:17 -0700 (PDT)
Date:   Sat, 28 Sep 2019 18:30:17 -0700 (PDT)
X-Google-Original-Date: Sun, 29 Sep 2019 01:30:15 GMT
Message-Id: <pull.349.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.349.git.gitgitgadget@gmail.com>
References: <pull.349.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] git-add--interactive.perl: Add progress counter in the prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kunal Tyagi <tyagi.kunal@live.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git contributors!

I'm Kunal Tyagi. While I was choosing the relevant patches for a commit
using the git add -p command, I found that there was no feedback regarding
how many hunks from the current file had been processed and how many were
left. So I decided to add a small change to the prompt which basically just
displays (${current-hunk-id} + 1/${total-hunks}) before displaying the
prompt during user interaction. This patch doesn't account for all total
hunks, only per file.

I don't know perl so even this one liner might have mistakes. I did test
this locally and hope this works for others. Personally, this change feels
helpful to me when I have to separate a long list of changes after an
erroneous commit.

On the #git-devel freenode channel, I was informed that @dscho is rewriting
git-add in C. If so, perhaps a similar change could be added in the rewrite.
I haven't seen his patches in detail so I can't comment if it'll be as
trivial as in perl.

Regards Kunal Tyagi

Kunal Tyagi (1):
  git-add--interactive.perl: Add progress counter in the prompt

 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-349%2Fkunaltyagi%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-349/kunaltyagi/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/349

Range-diff vs v1:

 1:  8edf23f816 ! 1:  a9c5906899 git-add--interactive.perl: Add progress counter in the prompt
     @@ -2,6 +2,14 @@
      
          git-add--interactive.perl: Add progress counter in the prompt
      
     +    Adds a feedback regarding how many hunks from the current file have been
     +    processed and total number of hunks
     +    Also included: changes to the test script due to change in expected
     +    output string
     +
     +    Change in UI: displays '(${current-hunk-id} + 1/${total-hunks-in-file})' before
     +    displaying the current prompt during user interaction
     +
          Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
      
       diff --git a/git-add--interactive.perl b/git-add--interactive.perl
     @@ -12,7 +20,7 @@
       			print;
       		}
      -		print colored $prompt_color,
     -+		print colored $prompt_color,"(", $ix+1, "/$num) ",
     ++		print colored $prompt_color,"(". ($ix+1) ."/$num) ",
       			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
       
       		my $line = prompt_single_character;

-- 
gitgitgadget
