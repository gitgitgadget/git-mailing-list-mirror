Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56031F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeDJV0g (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44170 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id p15so9311354pff.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62brWBQzYLN+k0eYzw8GWXo7FUEinq5Kd4hgzt+HX8o=;
        b=cfNBYO9bhCrUITTClMhYpXV+IBWKhLMSgVrbk6cIpbIhNIWRxh/N9QJ0fmXYRWtD40
         NZgTyQqZh094MKxxp2OK1o2zyuHdDHH7NiABIUQvpkHkLDytcwCsn96lCtZdZsGx1NMs
         LI8NgNCTAEEEL2V61lIY9fbt7hZ/lKGWFdneMJCtof88MqXJSAe7h83QEHz8TIhIb1IS
         zXA66jKlAAMB/DQ2lI8SpuYqDL8FWPtKpYkOf1YDtz6lK0bZ9HP+/wKvnM5LS5LR9Y3W
         /zZNo8IZ6AQmNo9pWp4qrZk/RR/feP5JPk0mQrmNApXCZjOS8JqQZwuo6fk4xTSzJCG4
         4lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62brWBQzYLN+k0eYzw8GWXo7FUEinq5Kd4hgzt+HX8o=;
        b=hj8YFtTHtiJXFeGQzy5id+wm4KDdQDdWDJRsMuRaBFx0mWNYkKI7q+cOOPQ67T252r
         7kYec6n4d8LgNTKOnlMTGwADj2uMJNrzenNhF+lBYcspsEZ+ChmmFhRJtZ7zjuzVv7lc
         WDo6fMkgw6PRv9Yrzyjwr6Ctk92zrXmZWoil6fqNNsxH5gUc+pUEUmXwhWG/IWDUkchh
         sm6ORazAQLjH4EVtJmykqfx2t5pY5UMUmLqSs9wCJN8+GbHWDjNO3AQ2GgJnv79rRily
         F/unwloeX0O1KXE4w7lIoPqna/iP3Dpv/vUCFrOxIUc+SNNCGvM7j3FYkozp/0Wvqx5+
         91hw==
X-Gm-Message-State: ALQs6tB16tUmX04NybcqZFfoaGLfi8hiKVAhiEQ2nMW1MAwMkXkxzFZK
        tBDDLWBTItWBu6P12t0b8prDew==
X-Google-Smtp-Source: AIpwx4+LHJg6XxeJ9QIfM2nom6GWldzspx047AhuD5JtKI75IGQbe3rcfJr7yWZKSElJ3I3GZJMD7Q==
X-Received: by 10.98.236.4 with SMTP id k4mr1682569pfh.240.1523395594147;
        Tue, 10 Apr 2018 14:26:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v8sm6372368pff.42.2018.04.10.14.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 2/6] unicode_width.h: rename to use dash in file name
Date:   Tue, 10 Apr 2018 14:26:17 -0700
Message-Id: <20180410212621.259409-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of Git's
source files use dashes in preference to underscores in their file names.

Also adjust contrib/update-unicode as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/update-unicode/README            | 6 +++---
 contrib/update-unicode/update_unicode.sh | 2 +-
 unicode_width.h => unicode-width.h       | 0
 utf8.c                                   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename unicode_width.h => unicode-width.h (100%)

diff --git a/contrib/update-unicode/README b/contrib/update-unicode/README
index b9e2fc8540..151a197041 100644
--- a/contrib/update-unicode/README
+++ b/contrib/update-unicode/README
@@ -1,10 +1,10 @@
 TL;DR: Run update_unicode.sh after the publication of a new Unicode
-standard and commit the resulting unicode_widths.h file.
+standard and commit the resulting unicode-widths.h file.
 
 The long version
 ================
 
-The Git source code ships the file unicode_widths.h which contains
+The Git source code ships the file unicode-widths.h which contains
 tables of zero and double width Unicode code points, respectively.
 These tables are generated using update_unicode.sh in this directory.
 update_unicode.sh itself uses a third-party tool, uniset, to query two
@@ -16,5 +16,5 @@ This requires a current-ish version of autoconf (2.69 works per December
 
 On each run, update_unicode.sh checks whether more recent Unicode data
 files are available from the Unicode consortium, and rebuilds the header
-unicode_widths.h with the new data. The new header can then be
+unicode-widths.h with the new data. The new header can then be
 committed.
diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index e05db92d3f..aa90865bef 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -6,7 +6,7 @@
 #Cf Format          a format control character
 #
 cd "$(dirname "$0")"
-UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode_width.h
+UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode-width.h
 
 wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
 	http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
diff --git a/unicode_width.h b/unicode-width.h
similarity index 100%
rename from unicode_width.h
rename to unicode-width.h
diff --git a/utf8.c b/utf8.c
index 2c27ce0137..4419055b48 100644
--- a/utf8.c
+++ b/utf8.c
@@ -81,7 +81,7 @@ static int git_wcwidth(ucs_char_t ch)
 	/*
 	 * Sorted list of non-overlapping intervals of non-spacing characters,
 	 */
-#include "unicode_width.h"
+#include "unicode-width.h"
 
 	/* test for 8-bit control characters */
 	if (ch == 0)
-- 
2.17.0.484.g0c8726318c-goog

