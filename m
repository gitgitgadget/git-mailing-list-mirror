Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8938B1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBTLlh (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35390 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfBTLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so10607628edp.2
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=cBNgCYKoXWN6+GVeRw8zlTQ+2JxOqpCfS67cb8YABYg=;
        b=BOBCjqA1eioR3zNn/um2g43pAAHKXVYoWzrn/BQQ64dUaUor5SSB7geTeApHZWd0la
         uQrf3s7UY/NFVAHXoV1boY4uzOKcYL1KnsBIzZdoHvEil1Oove1sPjASuEKr4+ujZ8Ax
         bAUOgEa/J3R7gYDrscOMiKtUX7jNIJmqMrdf1uK6xSivtAmeFOqRHiLOb6HHtBoz6Pu8
         5Xwmrvvmay6juLqJXxxZw4TmO0qMFXi/+XSKFaQiWDmqyXYK8hK9uw+CshHyv4zmTdyy
         7kEaHWpMtyL5LdeZ3GBjzp6QOzCB699pYgfQRihBbHL2Di47yWVHkkSFxX6KFuKSGJJ0
         Hhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=cBNgCYKoXWN6+GVeRw8zlTQ+2JxOqpCfS67cb8YABYg=;
        b=dmycc5TZlWtb541ytRQz32Su/RwmSKkZstMWlIQK4FvYK+XfoEhQj+9TZl+L5ZTyt3
         DpC663fPBV2jCcoDam0eCZGQB0DCxZV2HFTKYO6OD1NQ0jiwWPn29WOVJDLAx1v+oiVv
         LsYu+XsOfFuUwnIAy+nhXr6MMK+kUzuyiJXl88hCOr8rp8HGJ6h0kYO3Jqvtq+OlO9AE
         lpKopP3mLIF5uZwHbfuIrA4XnzhEgTyCNy/PpEiv8ZxquFkhAoITalbo3OTufhp1fVmA
         urHpNy7WmDPuhakBE/yoCmxoTRj4tcKO+WESFSN2dG/Hraf0/8caqEnuR3chNdiB5LuY
         /Ymw==
X-Gm-Message-State: AHQUAuZKuZ66MVrDxtGg8851BosVGlndaT9m/SEWNDa0+kYDS/XaUoyw
        IoFZcgW4U5lLQUa6A8n5ojkT6RKm
X-Google-Smtp-Source: AHgI3IawnAQNwF336TI+qe5HsdbB7UWo0cNo2T7Lh3iOXw77r+MFIEzxl24+8lp89pMAn8qvcZzsZA==
X-Received: by 2002:a50:b8a5:: with SMTP id l34mr15875565ede.196.1550662893392;
        Wed, 20 Feb 2019 03:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm4221474ejr.62.2019.02.20.03.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:32 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:32 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:23 GMT
Message-Id: <883963ee6e9cb430a6f37822114ffe03a0550c45.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/10] add--interactive.perl: use add--helper --status for
 status_cmd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Call the newly introduced add--helper builtin in
status_cmd() instead of relying on add--interactive's Perl
functions to print the numstat.

If an error occurs, it will be reported, but the Perl script will
not exit, since the add--helper is called within an eval block.

As the Perl script will go away soon, so will this scenario, where
the built-in helper is called  from the Perl script. Combined with
the fact that it would be hard to test, we'll pass on adding
a regression test for this.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-add--interactive.perl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..c2c6b4d5e3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -597,9 +597,8 @@ sub prompt_help_cmd {
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	my @status_cmd = ("git", "add--helper", "--status");
+	!system(@status_cmd) or die "@status_cmd exited with code $?";
 }
 
 sub say_n_paths {
-- 
gitgitgadget

