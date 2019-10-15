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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D5B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfJOKZh (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35208 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfJOKZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so23170511wrt.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=agDXgOJaFkcboIW19GxSFHiUKsoGUzjIn0UKD8h3arU=;
        b=ij0pEWGp4Tb5fm/cZShdOLbdWc7TsgLzNWILGdWNrYDKKbPiku2NagExX733a+S9KM
         0eroQV+PUg1VHxAa8r9hOHz34WHPx6AhGNRTQJlqOoy1StjrcMnIA2BDlbAqUzeRhYZA
         XIGiqZetBL6ZyT5Ua13agDZWTN/kEgzuDvvbFWfu9HPhDY+GTrZajKbU/WxCpwWOkITl
         s2l80GbnGWTSEb00EVHSiKjoQkseoM5hwFtQjn4Hf3r0g6sS+xYlaz2+CIJKOHEqbAae
         lzZb0gIgw40Fg7AtDgJM21GWznPp9+nv7Lg49937TuOLEFv5AolnlHIJTPKbTAphddRd
         XgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=agDXgOJaFkcboIW19GxSFHiUKsoGUzjIn0UKD8h3arU=;
        b=dNQ+ygcnDiwB7ujvbouPaOvc9iPQKHZsDSM8HUc7vDkUiNqTV59IDSGxk1BCMSvXeI
         CW2QsILrHoCCJPCiJZcodI9V+cWmKVYg31YObbo2ICHcWSHF/iLc7J/Fr4NQfVEAjpj+
         G8La2oDkZvmVGCkWHAzcWXpVon2HbijJW7wjrhEv9UHMckl+NW4wy77MwMVi1ceGR8T6
         qIVJC4aq4Q9rNMWRB7fMmREf8WxNRKjUDeKfJl57gi1w3U3TSVYaVpJ2qv69HYWvV4UE
         8x+tmOqYxVx1PrFYMRNbTJBBegN5L7djp5b572ux6s09FPv+l9roFzIs/lNy8yovaTaL
         lHJQ==
X-Gm-Message-State: APjAAAU2zywTXujaIF5byu+0u9OTDXDZNWcv7i8bGK+1AOcMP09PImFE
        H5mF1dAP2YvbM1NPnTGX5JOgRpKH
X-Google-Smtp-Source: APXvYqx/06tgyWEktprL8oMBLXVAVDVMaC7As89gmGs7ck9z7MXgBzhKtBCKhEr4JBp5L/QiBl/GzA==
X-Received: by 2002:adf:b781:: with SMTP id s1mr29818053wre.343.1571135135264;
        Tue, 15 Oct 2019 03:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 63sm32038136wri.25.2019.10.15.03.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:34 -0700 (PDT)
Message-Id: <b9689e85e593062f4d82cb955f36c8ef65ad0c4e.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:27 +0000
Subject: [PATCH v2 1/6] t3404: remove unnecessary subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Neither of the commands executed in the subshell change any shell
variables or the current directory so there is no need for them to be
executed in a subshell.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2f1d5bd23..c26b3362ef 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -945,10 +945,8 @@ test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
 	git add bis.txt &&
 	git commit -m "fixup! two_exec" &&
 	set_fake_editor &&
-	(
-		git checkout -b autosquash_actual &&
-		git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
-	) &&
+	git checkout -b autosquash_actual &&
+	git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual &&
 	git checkout autosquash &&
 	(
 		git checkout -b autosquash_expected &&
-- 
gitgitgadget

