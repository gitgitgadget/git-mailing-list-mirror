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
	by dcvr.yhbt.net (Postfix) with ESMTP id 517F31F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfKDUDv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:03:51 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37155 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDUDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:03:50 -0500
Received: by mail-pg1-f176.google.com with SMTP id z24so7581191pgu.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoMo9fR9bHK2xS8ar6rwuXwfMe7x/xt+BpMvl3iJGNM=;
        b=qG7IDU004BV8/QT/utrgjy6e0/grk3YlvqgSKcvHprfrNb1woeT4hg9SbIduDf0Ff9
         RFfrprWQXaberGTlxw3HfOWRCPSJs+Ly8s3u3wHbvWbqs4k2aA+Re8CRGgeyzZwniPft
         1MRhs04QP3ZpYTdqC+68znMfg6kp7w/rpyA8ad/GqMRqBVL3yiPFYYPwkZWqID7A/ofL
         k03KpiMQXGr80YGbsb1kcu14IGYKqhARZIx+Lg7jPd7oIxZV9pFjMjjwjsYVwb+uD9Cl
         h4t37sGXGMwm2cuQ9nwVlCQCj3K6c50FsCwXtSD3EGCj3CC8dN2xGLNopPWneQJyasSw
         Vxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoMo9fR9bHK2xS8ar6rwuXwfMe7x/xt+BpMvl3iJGNM=;
        b=aHiqvNFLiAwBC6+JXin5D4pTq6/9KUE1o0nwEs4RJaDoJcgvGL90T87fbq2VzHpGpp
         Aa9EEkvT1ff5sxU4SSek3QsbvEhHb4+7RBB6YK3sCu2RjgPJajde9KZ2arxazqvkNEFe
         0AQ+XevQ1vZpSfiQ/oxTZZMkHim5Fs3ZtnfbYf+RSsAEWAySbxkhahTXjVRgT2axh/Ol
         U8csgPnRt/rhvKPnDC7xJkkuLepceXM9FxRsk2g+0vsmquHgbKyWu3RjOTrNalHeZHAQ
         bBdZlFR4XOKcgqMj9U23ulxkkg/6VcFVv+cN3RALE3lQp8lzQCoI85xxjSP5q+HOGNZJ
         iHqQ==
X-Gm-Message-State: APjAAAUFJsMD6dEvCmNyHHoGXbMJk4hEYPWInYaf8IWWkPGth0iCDV/9
        ZMShrBLTsU3Mc23Byt1nifnYcYKL
X-Google-Smtp-Source: APXvYqxZwzrF6Qjg6J1LxrLOM/+LMtxugPHbROWoF0t0UW1iVttS2xcbm5xqZ1WZIfPF5HiinJ/gnQ==
X-Received: by 2002:a63:4553:: with SMTP id u19mr31540027pgk.436.1572897829712;
        Mon, 04 Nov 2019 12:03:49 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id a145sm9615440pfa.7.2019.11.04.12.03.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:03:48 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:46 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/8] pretty-formats.txt: use generic terms for hash
Message-ID: <09ab0c587b93ddce25888f5676e9d6ca0ac16fe4.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index b87e2e83e6..71eef684d0 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -4,7 +4,7 @@ PRETTY FORMATS
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
-"Merge: " and the sha1s of ancestral commits are printed,
+"Merge: " and the hashes of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
 necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
@@ -20,20 +20,20 @@ built-in formats:
 
 * 'oneline'
 
-	  <sha1> <title line>
+	  <hash> <title line>
 +
 This is designed to be as compact as possible.
 
 * 'short'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 
 	      <title line>
 
 * 'medium'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Date:   <author date>
 
@@ -43,7 +43,7 @@ This is designed to be as compact as possible.
 
 * 'full'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Commit: <committer>
 
@@ -53,7 +53,7 @@ This is designed to be as compact as possible.
 
 * 'fuller'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author:     <author>
 	  AuthorDate: <author date>
 	  Commit:     <committer>
@@ -65,7 +65,7 @@ This is designed to be as compact as possible.
 
 * 'email'
 
-	  From <sha1> <date>
+	  From <hash> <date>
 	  From: <author>
 	  Date: <author date>
 	  Subject: [PATCH] <title line>
@@ -75,7 +75,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA-1s are
+stored in the commit object.  Notably, the hashes are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts or history
-- 
2.24.0.rc2.262.g2d07a97ef5

