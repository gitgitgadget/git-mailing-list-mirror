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
	by dcvr.yhbt.net (Postfix) with ESMTP id 844911F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbfGRNTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42076 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390445AbfGRNTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so13672589wrr.9
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78g8+gaDXo8uS1s5S5WVm7dLUprygkhQyQhnC+pZgoE=;
        b=fN47fop3fMrRmgQKWYFxls5BaU1bTINa1gLrgAVqJ8iu+ZSKqjXcXqBGfrFk1c4KX5
         J+6ZnYuQXx/TyTpKIMs+gs895QIZemSU3Tpvq7Rm21y3uRn3a6vc9yCCZnD78xf95l7W
         YNuJ8yLu7XalfqJ36Hx2AKp16YgKSsMr0/Kv0LlDhUZowalLyhJV6FNA5kof81m7FYPC
         VhEAINPu6/Q5ve11P/CkRAMT50eqJOJ+ZfI3D7ob5XyQxCa7VWqB4oKWZ24tc/8r6bB0
         Vm7esRhD3RmluXjFi4KiM6kG5/LAtmLHcOTmtReZC/2EhbN9l52a6qTT4AYKmsztRgj9
         emqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78g8+gaDXo8uS1s5S5WVm7dLUprygkhQyQhnC+pZgoE=;
        b=IaOzX3Njq72QgO/R9JCARvjOozLmoAD8lf5hTEN3gLp1gje8xFDjbEQeIRavmT233f
         SSgyvopFckJeNxqpkMdNpTJmC0P9ckzT6S3RT/ucBZ826kE2QOjX06ipTkA9d661WVo7
         anCxX9uQsrGZQQd101bIMGREfiXChMK0n+qt7EHethD5PWYz5nrt2WZfPmyoaisldrfB
         BrH9NdXRtsplSpReWL0RXfdLZ6Fk+zuYnh4c+vXhBwBa3hf8RZmub+3AHGkqrlYTWyha
         hQ+wTZheZIa70Cv5JgINCdMzXzeH3Ug6YT9sqSZecgH22qYfR8aMrc+KTt+MDjK5rthr
         Ac9w==
X-Gm-Message-State: APjAAAW6TAPm7PaUEDrdM9WyQ5en3W9SxZgMxPfGq1lFvU14C5hBPdQ4
        A5aj5fO6PvZ7wWlqvyNxNWPLrtn+
X-Google-Smtp-Source: APXvYqzCBa1onqGoyFpG02vPX/diFiIhhLhNMUEBYwJi5Av/ssMSB4chA2Cj7G3TvnoaXWfdcfVPmQ==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr49725276wrt.253.1563455946630;
        Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm23564375wml.41.2019.07.18.06.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:43 GMT
Message-Id: <c10fd668ef943c2bfc0cfb909e5807ee87d65e23.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/24] contrib/buildsystems: handle quoted spaces in filenames
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

