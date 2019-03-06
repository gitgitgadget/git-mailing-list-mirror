Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56581202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfCFGbY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:31:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42186 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfCFGao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id d14so9821488ljl.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6BnabYJ5H0XQiOM0hdTrA4VRTbHtiYCuvOc1PCnj30o=;
        b=WMh5ij0kIL8uKt8t+/VaXrFUGJOw2Mr6DHnGokw0Gk01dcFdYHnvldNHW3OsbIsPyY
         DSTFJaTsFV8+xKCLB650t7+NqM025wSzzEzdZvfCg5TOXZcoA7gKQ3wQih9HxBEWBAE8
         T5tyi8DSIUCh02911aZ/CXdjD4WIe41mkFz/Q8TPJKXc/qN7x56erX/Nlnd/r52XzZ19
         DAn+e1EpqU5uq0sbVgiUuSB306hndyNcl2+wB3W+qEJFtl7dw5szUUVHAp/5ORtt2Bgd
         S4DWp/RXKD+ODHr+SnGh92TUdLeMuYDI4pU+O6kfNzUry/SSLxbnsIyawISn9ho+3RCY
         t6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BnabYJ5H0XQiOM0hdTrA4VRTbHtiYCuvOc1PCnj30o=;
        b=Y+Zanm3BmPqv07Xxsetofw2BpG+ExAiKe8rgRF2g2YHGTtyj0ZGio+GVPRtD4AKw2i
         737CEsV0Ak2O5fUzeSNpjCwCaNJU7dw6Q653d0HXJNhcXBudhibVaj2LpvSi2QzPyqdh
         R/ahGoVzSt2/ZAyT4Yu9bqpxE1pObBb/kbwAczRiAlFi718XP1xuWkSLfNf4Dz8Sln1a
         1CNc0X5dwB9GctloJ8UrzM8BHowdhN6FXxLNO0Mlug0pkDDLt9ZmTcEih1pUDrAlMlhA
         hNiiOQuRQW2aUOforo712zcb8aSWoROlFKdczNunOBWKTJF5VyIudmKXNZOIgHbr/rZ3
         wW1w==
X-Gm-Message-State: APjAAAW/JWaRnwIcW6R/LL1L7fSw7lkQiXKKTVPYJmfcQl0ykSta0AD/
        2YJ31ueTNdMh6E71ICnxcD2Z91eK
X-Google-Smtp-Source: APXvYqwpBP8YBURXB+akYnzosnOJgiF1i7uyHmstfuyQdmcpB6DfSUJPtckulhJDMpc7TjYYfJz6Wg==
X-Received: by 2002:a2e:9786:: with SMTP id y6mr1223379lji.79.1551853841771;
        Tue, 05 Mar 2019 22:30:41 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:40 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] git-svn.txt: drop escaping '\' that ends up being rendered
Date:   Wed,  6 Mar 2019 07:30:17 +0100
Message-Id: <1864fee16647f526b507dcebca90629b37cc35a1.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551853194.git.martin.agren@gmail.com>
References: <cover.1551853194.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Escaping two *'s as "\*\*" apparently makes Asciidoctor render the
second backslash literally, so we end up with "*\*". So let's not escape
that second asterisk. The result is now "**" as intended, both in
AsciiDoc and Asciidoctor.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-svn.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b99029520d..223788fa3e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -126,7 +126,7 @@ your Perl's Getopt::Long is < v2.37).
 	command-line argument.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
 
 --localtime;;
 	Store Git commit times in the local time zone instead of UTC.  This
@@ -239,7 +239,7 @@ Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
 
 -l;;
 --local;;
@@ -524,7 +524,7 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 	way to repair the repo is to use 'reset'.
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
-'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
+'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
 Follow 'reset' with a 'fetch' and then 'git reset' or 'git rebase' to
 move local branches onto the new tree.
 
@@ -760,7 +760,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as 'git svn'
 will not be able to fetch again without metadata. Additionally,
-if you lose your '$GIT_DIR/svn/\*\*/.rev_map.*' files, 'git svn' will not
+if you lose your '$GIT_DIR/svn/\**/.rev_map.*' files, 'git svn' will not
 be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
@@ -1154,7 +1154,7 @@ fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
 
 FILES
 -----
-$GIT_DIR/svn/\*\*/.rev_map.*::
+$GIT_DIR/svn/\**/.rev_map.*::
 	Mapping between Subversion revision numbers and Git commit
 	names.  In a repository where the noMetadata option is not set,
 	this can be rebuilt from the git-svn-id: lines that are at the
-- 
2.21.0

