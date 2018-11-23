Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2141F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 09:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408782AbeKWTww (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 14:52:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38593 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393714AbeKWTwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 14:52:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so8101534wrw.5
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurrell-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iifv5DWKAvRkMAP81rrNaIkRrSi9avYYUYx3Bat2Xm4=;
        b=stV3dIZdH6afR7rXX8SEicOdxBQxmVY2dwOQ+mMHcU+DJCCzf95Kq5VYwKKbdPIhXl
         YSmghpqI+Ys9fNODZvLmccDqBOd+QWxpVWYbaidwPdsOLrXbJEBwlVLLwBX1cE8Eg7/V
         1NjALRms+lkOZ7s2geBheIz2Wh2Rf22boIhLe3yH0eC/Sl02mPEBtQKHzIy/tYTJ2EdX
         zF4oOsruiQCZ+YzfHN5YH4cVTr5oZqHl0Y02KuIDO9a994rmZXlEp6U+9LvvayxPLaZ0
         U0lzIma0DDB3QTAyiynUfzhSgl4nAOfcfwrint35XQDh5CtOnRvUPvLW0WKv9D/Dv8x6
         PZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iifv5DWKAvRkMAP81rrNaIkRrSi9avYYUYx3Bat2Xm4=;
        b=DhyMAi4zMYCoJ53ti6izzIGISzrK60FZ7E2ufo6BDCstBGz1Mr9my4I4R/VXMKKXYz
         RtCNSHU0bFuMZ14VvECmiLVr69fEWK9fiDMNgMATlJbG7XduAv2rGgqQQGRHczyq5kc5
         47itU5IoR7nC6QfZk1b8VEuX7SP56CooEk4fAjfJwLzjbE8EUAXHTMHCAe/EnD1iHm1g
         GfI44TYmQkV0o+tloIHOPJSJ7DfJy/UhEEkPJ07Qpy9bEcOwbzoWJB9IRPzZS3reFRdr
         Bn06AJYsO2ljVXtBsP8Vd/l8KGGuva2Jf2tZMQmS4uM+/dWU5ydO5UsmA9D2ZlaRdzFR
         xcFg==
X-Gm-Message-State: AA+aEWZz7VMnR4YsXdNvXhWjZRG1u2SJyuwSZLLElkpf/xXUdFz9/mah
        tBh673bpoF7E5dNw9NQbFzS41eHaJT8=
X-Google-Smtp-Source: AFSGD/VFxTJsEwuPly7eqn2tGDp+ITxZyEmL4WKXbNvyzo0CoBqY9njscAGBX0DJC1KaQlsuGhFKVw==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr13627625wro.246.1542964167787;
        Fri, 23 Nov 2018 01:09:27 -0800 (PST)
Received: from localhost.localdomain ([194.224.154.179])
        by smtp.gmail.com with ESMTPSA id s8sm9805585wrn.44.2018.11.23.01.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 01:09:27 -0800 (PST)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: [PATCH] doc: update diff-format.txt for removed ellipses
Date:   Fri, 23 Nov 2018 10:09:08 +0100
Message-Id: <20181123090908.43445-2-greg@hurrell.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181123090908.43445-1-greg@hurrell.net>
References: <20181122160154.GA28192@sigill.intra.peff.net>
 <20181123090908.43445-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7cb6ac1e4b made the diff format omit ellipses by default, but
there is still this place in the documentation where we show examples of
output with ellipses.

The GIT_PRINT_SHA1_ELLIPSIS environment variable can be used, for now,
to bring back the old output format, but that is already documented in
git.txt, so I am not mentioning it here.
---
 Documentation/diff-format.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 706916c94c..cdcc17f0ad 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -26,12 +26,12 @@ line per changed file.
 An output line is formatted this way:
 
 ------------------------------------------------
-in-place edit  :100644 100644 bcd1234... 0123456... M file0
-copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
-rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
-create         :000000 100644 0000000... 1234567... A file4
-delete         :100644 000000 1234567... 0000000... D file5
-unmerged       :000000 000000 0000000... 0000000... U file6
+in-place edit  :100644 100644 bcd1234 0123456 M file0
+copy-edit      :100644 100644 abcd123 1234567 C68 file1 file2
+rename-edit    :100644 100644 abcd123 1234567 R86 file1 file3
+create         :000000 100644 0000000 1234567 A file4
+delete         :100644 000000 1234567 0000000 D file5
+unmerged       :000000 000000 0000000 0000000 U file6
 ------------------------------------------------
 
 That is, from the left to the right:
@@ -75,7 +75,7 @@ and it is out of sync with the index.
 Example:
 
 ------------------------------------------------
-:100644 100644 5be4a4...... 000000...... M file.c
+:100644 100644 5be4a4a 0000000 M file.c
 ------------------------------------------------
 
 Without the `-z` option, pathnames with "unusual" characters are
@@ -100,7 +100,7 @@ from the format described above in the following way:
 Example:
 
 ------------------------------------------------
-::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM	describe.c
+::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
 ------------------------------------------------
 
 Note that 'combined diff' lists only files which were modified from
-- 
2.19.0

