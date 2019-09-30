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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2E11F463
	for <e@80x24.org>; Mon, 30 Sep 2019 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfI3FXC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 01:23:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3FXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 01:23:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so9621084wrs.0
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6Yu1ugChssk7xr0x9mEegOFbGUezqTxvNCeBPhRlfg=;
        b=dojVwo2B661rXxjWjxFZrWcN5ZSR+gXAh8ERDdSClh7JYCvDv0ETTvsuwTdb3ZESXm
         mP391ZMFa1RF9/VSSBXFm3p94y9sd8/ZnXEy4T/1K4endABwtMVszR2PBJ9IzsnIkSuJ
         2pcUZGeZMiTzg64FHTnQZBgg7GRYq3ib9QMnjUmA4m5h+fcKQVHH6qGQ2NCU4COIbQfM
         RflPHLZJTosEgzXqJB4Hl7snI02veY/L7uUSq/q3gGCh0ZNBsqc1LliPNj5YSHZkvSj+
         euH96rmhJ2+LPknfkOr8a2XNQSOXDrAhFqlQq2/SEkRj98t0cCGk1xlrU6DJNB6R42bI
         n2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u6Yu1ugChssk7xr0x9mEegOFbGUezqTxvNCeBPhRlfg=;
        b=PiYJV82nARJMtE2CM9zTa3GS/u+fDYkzdWfFMnNoIbjGEp6PCNR5khqYwnN3C0O8iQ
         WlmN8K3JJ6O7Bay+rtjPa+99NM4MDSLsy9jVsR4yjysNxOBia7fkL8KapziwdYdkA6oz
         NED4FtrhME+u1Jzp1lJX6Z0HYJ5K4SmzQXGXfbnoRa5O/qg97Vq3NaAPtI+LfWDPw/V4
         8kAv8BsqV6WyDw8avO0T8guj9+7+MeS5i0mLZL7Ai2vRww8pOsjHaCdAyVjWxegRQQq7
         fi06ahCFx/YKn4mvx0rDYhVhsNrIq9LmrZ79lfjkjzAA/BOzVvrLXXEy0MJ4XMjZwv5O
         FxYA==
X-Gm-Message-State: APjAAAWrGAyY+6rDz4Y8huIxwJGv3yD9RokHJt3iijKB6ZuVM65ftOWJ
        mtz9uwAg7pRjRRticmHFYILt5Brd
X-Google-Smtp-Source: APXvYqwu3FBHDoNI2c8/sE1pR0r0KFAsXuFi7naxa4EE53SCBeb/YpTbwbsVcaHaKE7yB6FNkTOICA==
X-Received: by 2002:adf:828d:: with SMTP id 13mr12049486wrc.115.1569820979954;
        Sun, 29 Sep 2019 22:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm11351199wrm.52.2019.09.29.22.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 22:22:59 -0700 (PDT)
Date:   Sun, 29 Sep 2019 22:22:59 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 05:22:57 GMT
Message-Id: <b351c74a3fc5787e8a41c12342b592d38ef0dede.1569820977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.349.v3.git.gitgitgadget@gmail.com>
References: <pull.349.v2.git.gitgitgadget@gmail.com>
        <pull.349.v3.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] add -i: Show progress counter in the prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kunal Tyagi <tyagi.kunal@live.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kunal Tyagi <tyagi.kunal@live.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kunal Tyagi <tyagi.kunal@live.com>

Report the current hunk count and total number of hunks for the current
file in the prompt
Adjust the expected output in some tests to account for new data on the prompt

Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
---
 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c20ae9e210..52659bb74c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1541,7 +1541,7 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color,
+		print colored $prompt_color, "(", ($ix+1), "/$num) ",
 			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
 
 		my $line = prompt_single_character;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 69991a3168..d50e165ca8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -314,7 +314,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	printf "%s\n" s y y | git add -p file 2>error |
-		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
+		sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
 		       -e "/^[-+@ \\\\]"/p  >output &&
 	test_must_be_empty error &&
 	git diff --cached >diff &&
-- 
gitgitgadget
