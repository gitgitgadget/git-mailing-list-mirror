Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B3D1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBTLlk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35394 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBTLli (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so10607711edp.2
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=vWvZwd8ddG+CblAEqu3PKbtCl1nm8ciFqGKmDAbRAwA=;
        b=Dy5oJcoDiWaVnoUdZXCfsulR3SNc5g7+oOtayP6zWA78Rq5fqCM4/78wSjaZuPMLpK
         QPFDJOlNkIZ7x2XA8nVLyLNCiBrVebIcWZmyFivQ0DpLbuXkzuVakVnXU+GimPRYb48e
         xS6on27oj4IVs1QPbJk7JXWkp5K4Tlabt6gRNtMdWEnvVNzHxnAR+JYHQ1Oo3j7vquP7
         5phR37NXmgd4bGNQ/3lolZBkZQVt+zxdZHfTFaGo+cuhlJ+4Xq2BUmmV75dbrOfWbjp9
         Vts0y71qOLY88wplw/98NU4FIeZx3kKfqcVc2uCOEiUo7QGOMV0UZhUgbn8CJmEx+Wtv
         uiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=vWvZwd8ddG+CblAEqu3PKbtCl1nm8ciFqGKmDAbRAwA=;
        b=IGOUMOcUuukYXbgJofATO1rUR2rSxw0R7xPMQD9RrBmPdAosrPYm3X83Y8SqxHoJM1
         /bUnN88M0VwVZAaNsNv+9ZhtzZwsNKqxGfewqI7DgnTTyuxhknp/k2FlUILeAmp+j+Ia
         N1zKZqEkjDCy7AP14uwdg4Y2DUHAIxNNKizAXG9p+VQ3zzl+yvT0LBieatNp1Wd/goVg
         F9alCnyX5j7V/RKWv8Vmmucey60IdXN1plsfghomWsO7f43w8CD0qPTi+nX2Ii5Klj9i
         vYtDophe/9fQSgiJHulFhhHO9anylsK2WH+SvwEyHpLiqEmfYqNMj7MQ2xiCi7S94PMG
         cHlw==
X-Gm-Message-State: AHQUAuYsY23rvixT7DuBwvMinszmW14c+RT+SYuPpGylmCuuiZAyzzNP
        tx4zG1WP8cNprrKTWyZHucjmbjz5
X-Google-Smtp-Source: AHgI3IZ4OD/cIFZ03aCj4UsXFcdhdP3U7/P4f8ec9IZoxwtDLVMTThuH/xaDDYrAJl505VUQXYN4Xw==
X-Received: by 2002:a50:9012:: with SMTP id b18mr21933015eda.30.1550662896340;
        Wed, 20 Feb 2019 03:41:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm5823763edh.39.2019.02.20.03.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:35 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:35 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:27 GMT
Message-Id: <2b4bdce7300f3b6ba70f00a9eb524f5fa1ceff8f.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 10/10] add--interactive.perl: use add--helper --show-help
 for help_cmd
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
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Change help_cmd sub in git-add--interactive.perl to use
show-help command from builtin add--helper.

If an error occurs, it will be reported, but the Perl script will
not exit, since the add--helper is called within an eval block.

Just like the change where the Perl script calls the add--helper
to print the numstat, also here we forgo adding a regression test:
the Perl script is on its way out (and this patch is part of that journey).

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-add--interactive.perl | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c2c6b4d5e3..88b7be6602 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1718,16 +1718,8 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-# TRANSLATORS: please do not translate the command names
-# 'status', 'update', 'revert', etc.
-	print colored $help_color, __ <<'EOF' ;
-status        - show paths with changes
-update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
-patch         - pick hunks and update selectively
-diff          - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+	my @help_cmd = ("git", "add--helper", "--show-help");
+	!system(@help_cmd) or die "@help_cmd exited with code $?";
 }
 
 sub process_args {
-- 
gitgitgadget
