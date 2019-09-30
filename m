Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E632D1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 05:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfI3FXC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 01:23:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfI3FXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 01:23:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so9609286wrx.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s54ZLOsTw5GxvWdSipcSBV1L3kwAI8QfzQZV5q6dX90=;
        b=eoAqWmh1nIHHEmToIpSE9Ww/papdIaN68JLsj1dIQGPc9XwrqckVPpQmGmBkLF17X0
         V/EZaMTy3J55iB0VFDERbT8JaRvZquILMvzyxjoXQ8UwP9vyy67u3wob08o2JWN6GlzM
         vi1IyYRb51Db1zpZw/k2FspMKCGqcAfSEv7MMwmlrA4eQCF2w3V1RhUvm74LfN0bXMOH
         TMpuiNRRstpd7UMIHYozZhvOedD3rgtZXBl7nDcE2CuPoR0fcGS1wsOCFfhbCKtg4T3h
         Q7Tnx2mwvGT/vXzOxeKXv60dupdwa0N71Her6LKAZwEl9u+QrpCx8u55U5UKWFz2PTUk
         cxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s54ZLOsTw5GxvWdSipcSBV1L3kwAI8QfzQZV5q6dX90=;
        b=KtzLCaBJUyU0wTr7a5iymIp/T1ntAxOsuUO8UYr7dFZx6PXN5iPwShVvjMg6E5E9cH
         OGqGJFxjGDU7bw1rYTLFOmrOj/vHBfFdX1WkpUQuISSw03thdaxmG+nr+SYclU6R+six
         M/czs1wBssUFrr714inCSnUODEAJ+UGCXOTGHrCxjVuT3C31YTFvrL9x6bFsXvxdDwEe
         ctIi2Xw0ngQuaH+IB2WXeRRnCk4kh5u3i+hKPwVe/bwhMpPR/ax0PyCAZ/MlKm3bwWyh
         DhvxRveoDZjmYiY5efVj+x1KlYMLiGexJzTdBINgB4Fo7ICiSXNOtCyKK59A0B6rGzeQ
         JCTg==
X-Gm-Message-State: APjAAAUXp2UdFU0suDiZmCroDML1E9KGH8cKzcOOPzdB1n3X+pS84SlV
        PhfLFZ7hBOkyc8N/J1rXAPcCqv4c
X-Google-Smtp-Source: APXvYqyR7ZrKuLrW4fOnrQuuQFxmJUq0+CpO99DOhDlAMXLeEoi412iiH44LidwsKMzR5o1wngtO5w==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr12385095wro.329.1569820979314;
        Sun, 29 Sep 2019 22:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f186sm20799142wmg.21.2019.09.29.22.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 22:22:58 -0700 (PDT)
Date:   Sun, 29 Sep 2019 22:22:58 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 05:22:56 GMT
Message-Id: <pull.349.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.349.v2.git.gitgitgadget@gmail.com>
References: <pull.349.v2.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] git-add--interactive.perl: Add progress counter in the prompt
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
  add -i: Show progress counter in the prompt

 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-349%2Fkunaltyagi%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-349/kunaltyagi/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/349

Range-diff vs v2:

 1:  a9c5906899 ! 1:  b351c74a3f git-add--interactive.perl: Add progress counter in the prompt
     @@ -1,14 +1,10 @@
      Author: Kunal Tyagi <tyagi.kunal@live.com>
      
     -    git-add--interactive.perl: Add progress counter in the prompt
     +    add -i: Show progress counter in the prompt
      
     -    Adds a feedback regarding how many hunks from the current file have been
     -    processed and total number of hunks
     -    Also included: changes to the test script due to change in expected
     -    output string
     -
     -    Change in UI: displays '(${current-hunk-id} + 1/${total-hunks-in-file})' before
     -    displaying the current prompt during user interaction
     +    Report the current hunk count and total number of hunks for the current
     +    file in the prompt
     +    Adjust the expected output in some tests to account for new data on the prompt
      
          Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
      
     @@ -20,7 +16,7 @@
       			print;
       		}
      -		print colored $prompt_color,
     -+		print colored $prompt_color,"(". ($ix+1) ."/$num) ",
     ++		print colored $prompt_color, "(", ($ix+1), "/$num) ",
       			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
       
       		my $line = prompt_single_character;
     @@ -33,7 +29,7 @@
       	git apply patch &&
       	printf "%s\n" s y y | git add -p file 2>error |
      -		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
     -+		sed -n -e "s/^(.*) Stage this hunk[^@]*\(@@ .*\)/\1/" \
     ++		sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
       		       -e "/^[-+@ \\\\]"/p  >output &&
       	test_must_be_empty error &&
       	git diff --cached >diff &&

-- 
gitgitgadget
