Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6012E1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfG2UIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36834 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfG2UIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so63284486wrs.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78g8+gaDXo8uS1s5S5WVm7dLUprygkhQyQhnC+pZgoE=;
        b=aRlLjso/mXtBqi1yHiqjkMit0qGMDphvaem5R6H+F1QAce8lXoDHEFOGXihW+5SOq+
         UbXGuABdUFeZZN47VfpGpVIVvXNBczOccaUnO4lb+TgopTHu6uaxtoiF5dFXl8p/LWQd
         boFjASYXpwSOsYUAkI5I9de/DlI/NGHfekKflQvnlbOFwlcBKExPBWct/zR/d5p6f8G3
         921O8v0msgwyMslP/g53vL6QT3wL/8xznzBsmGvacI8beIDUxesZKr4glHkBClQWOwQm
         yG/UWDLeUjuw2LTeHsBhKWGOBF2hNzsu8Ir+UY40kAZg3ObIzKcxREXDGctFVHkeYkus
         gIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78g8+gaDXo8uS1s5S5WVm7dLUprygkhQyQhnC+pZgoE=;
        b=Jv0mcgByc45w3fn4Z39ZkFwae0WSrbzpxDOLZ7bmVuVvcpSQCiVtMt3KzfsuYABlop
         bMckTkpEEKyLNZaW2QKpQnKjfj6s0SMLFeuAeX1Zxo2SKFW/itJISPxiNNWQB1xwzOnJ
         aJ13ltXLdOoVue53SdIvvfrL/JE4b3GXj6LTBUKYK685qKkrQFgse28G+d6YtPU/smt7
         B0YeseuMfL7uaCRSf2XtoUnWXB1i1/5ctY9sd8jjZMLr4Rn5bpiIeSDGjRKG6aXCclOk
         AxF4RYLZQE1uOmFbdDbeQzweBrBDyrl7c1P/MhTPjwEdQKvjFOV42UOa9SdQm2C/LKS9
         3kCQ==
X-Gm-Message-State: APjAAAUvm7/is7uHFdctaC1jiuZrrG/3O+5bGcpD8FiFH4tgB37tpLgr
        siqIVKtJ1FGErVbJVJLEZavfnKT9
X-Google-Smtp-Source: APXvYqzwR5rmzZMzCMrcVMTiPZbcQ3Hkex3sVlrYVlGfYwk5/FnD7iRPDyPlZGmoVi9MCERhm4W5fQ==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr74725344wru.275.1564430886353;
        Mon, 29 Jul 2019 13:08:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f70sm80788963wme.22.2019.07.29.13.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:44 GMT
Message-Id: <c10fd668ef943c2bfc0cfb909e5807ee87d65e23.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/23] contrib/buildsystems: handle quoted spaces in
 filenames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

The engine.pl script expects file names not to contain spaces. However,
paths with spaces are quite prevalent on Windows. Use shellwords() rather
than split() to parse them correctly.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 11f0e16dda..ad6a82c30c 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -12,6 +12,7 @@
 use File::Spec;
 use Cwd;
 use Generators;
+use Text::ParseWords;
 
 my (%build_structure, %compile_options, @makedry);
 my $out_dir = getcwd();
@@ -231,7 +232,7 @@ sub removeDuplicates
 sub handleCompileLine
 {
     my ($line, $lineno) = @_;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     my $sourcefile;
     shift(@parts); # ignore cmd
     while (my $part = shift @parts) {
@@ -265,7 +266,7 @@ sub handleLibLine
     my (@objfiles, @lflags, $libout, $part);
     # kill cmd and rm 'prefix'
     $line =~ s/^rm -f .* && .* rcs //;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     while ($part = shift @parts) {
         if ($part =~ /^-/) {
             push(@lflags, $part);
@@ -306,7 +307,7 @@ sub handleLinkLine
 {
     my ($line, $lineno) = @_;
     my (@objfiles, @lflags, @libs, $appout, $part);
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     shift(@parts); # ignore cmd
     while ($part = shift @parts) {
         if ($part =~ /^-IGNORE/) {
-- 
gitgitgadget

