Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D9A1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfAYMXm (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:42 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36521 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfAYMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:37 -0500
Received: by mail-ed1-f49.google.com with SMTP id f23so7237251edb.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=xR/IF3UjxI2mqNdi/TJ6zykGDhpS1goBckMP4iER/fc=;
        b=QjJFm3VeAc8XC0Oaq49ER7fXCG+E/qi6l1Jzv69SrHNrMvsM4IFuF01F7pHDSuCJHw
         cW1Zjxp0D9AOOEzD/zWs7mfDQrE3xl309m1Kbqqv/7NDs+hLfJ0qC2SsWpRCDuvzeo38
         7zmWoFwuxAv8qrS8kWbC1zlUgSVO86pUKINzyTmN2NAY5ewC1FqXAQ4osNCa54ioM5qo
         GraazgQsndTRlsfsNCqAUz18LXi52MJFj2sev/a9U6oVe69VyVylTriiRPnfORrIlDsm
         jrbk0Hsn49JE3jyeWUhGfONQywo0DGLv0xUbqjPdkZcwFAnhHwPqmnNrAxvZ3oJcNmlP
         lWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=xR/IF3UjxI2mqNdi/TJ6zykGDhpS1goBckMP4iER/fc=;
        b=twDRRs5TgcQkiWNKsHvv4SN4zVvdhZKt67psBIfzEfN/VCfY9nBYQHYx2Y/+6WupsX
         R39u/lKMa9vPaz54bJlMxKZj5NhnGtHyfbOQ08Dqy6xmEi5h4RuVLAOyb7hJQWT8UXTr
         UEmzEzgG3U+cc8CZhp+Sde18egUngsE2gPx4MhlbSlKTkz4T15iOYyB0ZWHx6mIFzQwm
         zuNn+PAzH68cco8PMku/aCE2P4RWWdWR7t9bENcGUMNWUHGwRx5FvVD4jJFMo+eg8+Nh
         haN3IPccWOYpkJzaPWkywHbbYYe3WGDgCxbCE5LYHrNmoiJpBMWBdCemFMIm1v91AqKh
         P/2w==
X-Gm-Message-State: AJcUukdHjRa9ahyxa9PIZ4RW8uGhrSiKjGIAvx0hhSXBSF75y2AEB123
        pjv6CZKxdUvADHAxV8WtXEDpIjFt
X-Google-Smtp-Source: ALg8bN5W7bThkI5zJfIyCrKC/7mA4EU9FjQlA8ZXSjq9mpCgBPuokALuls0uZkUV8UBZ+t/MUOxkDw==
X-Received: by 2002:a17:906:d191:: with SMTP id c17-v6mr9440558ejz.27.1548419014868;
        Fri, 25 Jan 2019 04:23:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm1197061eju.24.2019.01.25.04.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:34 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:34 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:26 GMT
Message-Id: <fb3f9378aca1ca2e5d59b518b0066cbe273537a4.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 4/7] add--interactive.perl: use add--helper --status for
 status_cmd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
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

