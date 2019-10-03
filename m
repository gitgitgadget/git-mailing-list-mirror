Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7B41F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfJCTuB (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 15:50:01 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:55709 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfJCTuB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 15:50:01 -0400
Received: by mail-wm1-f52.google.com with SMTP id a6so3220298wma.5
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SraHsXEogT5ADBmGVdtU1sqqoEN7q2s1UDHcllx9xlA=;
        b=iwMt3EAkGuz4FaBoipP2bJMN3lq4j3tnMe3cNxTINThIrpVmugpPYWGmerwe8aYKvB
         oKQoZuaLpdTpInBcH5qvhz1WNjIxzmEvhgfS+VsM0fpTc91GQWuerBPzYbQaXHWIuUam
         /NuEtAEIVu+yfihJrMqwwrxYAlLIq4DCestEby5aUeu7zfvk9w+H3HvA06wtR+G7Zqp2
         Hrw+r37umzPSaV10oURtFVKZku2kTS8AI/Fdc8Oxo+pfNZJ74JQ/o3NxEgZCLABcayNE
         dDFcObsQHPcdOrJGhf7fu/4FtH3Rd4elQAvJqyovM9EHQ2sEqo3k9J8QmlGm2OsS4c4U
         8v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SraHsXEogT5ADBmGVdtU1sqqoEN7q2s1UDHcllx9xlA=;
        b=EyraQ6Iy4lau7us4ujwz2pYyIlBegRNMLiG6yW14vvKosvXYdUS53SurMs6wcgAOZw
         n6UYqe/qeflGHIsZxXDlEty7T/MS2ZQbrVtYXd+ZkEfXZPNZBY4ArE6mQ/7x1K/tynWK
         9zi+yIpRuta9bRtFlkJ7mhVmMdzbp6hU3Pp+SLu3bWEJfRhU51RPi0VXeCNFFHUZEyOD
         PW9zPfpb8DiNY3JCe3zNkjZ9EJTH2/1qogZyuk+HQ7elpYaShvkt/NO2uiacbitUvxE6
         sG4Ywoz0KaBeIfMbjc8DaCSPgGyfjvX4INbh1vk8tIhptvx6O1JLCdOrYh4ug5wRT2cR
         Ctvg==
X-Gm-Message-State: APjAAAWDllIGYvPLnLGAydAQvqq8nVKKJG2uB7KPF5FJHPOPyLx1AfLA
        WZgTxJBSUS6VTMg7MRRChytVZ4f/
X-Google-Smtp-Source: APXvYqweq44BAcWB0dUiLCg81teySm5ZbSUzGhTYry81OIgFK1IwB2y4TqOHPP3oOhhUuyxsYSLnaA==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr8522501wmh.114.1570132196675;
        Thu, 03 Oct 2019 12:49:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm13993586wme.3.2019.10.03.12.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 12:49:56 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:49:56 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 19:49:54 GMT
Message-Id: <ce9bf4237e69fcaf2b3e8b50bb88ff61c3b0f710.1570132194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.372.git.gitgitgadget@gmail.com>
References: <pull.372.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] fsmonitor: don't fill bitmap with entries to be removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

While doing some testing with fsmonitor enabled I found
that git commands would segfault after staging and
unstaging an untracked file.  Looking at the crash it
appeared that fsmonitor_ewah_callback was attempting to
adjust bits beyond the bounds of the index cache.

Digging into how this could happen it became clear that
the fsmonitor extension must have been written with
more bits than there were entries in the index.  The
root cause ended up being that fill_fsmonitor_bitmap was
populating fsmonitor_dirty with bits for all entries in
the index, even those that had been marked for removal.

To solve this problem fill_fsmonitor_bitmap has been
updated to skip entries with the the CE_REMOVE flag set.
With this change the bits written for the fsmonitor
extension will be consistent with the index entries
written by do_write_index.  Additionally, BUG checks
have been added to detect if the number of bits in
fsmonitor_dirty should ever exceed the number of
entries in the index again.

Another option that was considered was moving the call
to fill_fsmonitor_bitmap closer to where the index is
written (and where the fsmonitor extension itself is
written).  However, that did not work as the
fsmonitor_dirty bitmap must be filled before the index
is split during writing.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
 t/t7519-status-fsmonitor.sh | 12 ++++++++++++
 t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)
 create mode 100755 t/t7519/fsmonitor-env

diff --git a/fsmonitor.c b/fsmonitor.c
index 231e83a94d..fa0b96d84e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -14,8 +14,13 @@ struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
 static void fsmonitor_ewah_callback(size_t pos, void *is)
 {
 	struct index_state *istate = (struct index_state *)is;
-	struct cache_entry *ce = istate->cache[pos];
+	struct cache_entry *ce;
+	
+	if (pos >= istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %"PRIuMAX")",
+		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);
 
+	ce = istate->cache[pos];
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
 }
 
@@ -50,17 +55,24 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
+	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
+
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
 }
 
 void fill_fsmonitor_bitmap(struct index_state *istate)
 {
-	unsigned int i;
+	unsigned int i, skipped = 0;
 	istate->fsmonitor_dirty = ewah_new();
-	for (i = 0; i < istate->cache_nr; i++)
-		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
-			ewah_set(istate->fsmonitor_dirty, i);
+	for (i = 0; i < istate->cache_nr; i++) {
+		if (istate->cache[i]->ce_flags & CE_REMOVE)
+			skipped++;
+		else if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
+			ewah_set(istate->fsmonitor_dirty, i - skipped);
+	}
 }
 
 void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
@@ -71,6 +83,10 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
+	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
+
 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
 
@@ -236,6 +252,9 @@ void tweak_fsmonitor(struct index_state *istate)
 			}
 
 			/* Mark all previously saved entries as dirty */
+			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+				    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
 			/* Now mark the untracked cache for fsmonitor usage */
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 81a375fa0f..85df54f07c 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -354,4 +354,16 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_cmp expect actual
 '
 
+# Use test files that start with 'z' so that the entries being added
+# and removed appear at the end of the index.
+test_expect_success 'status succeeds after staging/unstaging ' '
+	test_commit initial &&
+	removed=$(test_seq 1 100 | sed "s/^/z/") &&
+	touch $removed &&
+	git add $removed &&
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
+	FSMONITOR_LIST="$removed" git restore -S $removed &&
+	FSMONITOR_LIST="$removed" git status
+'
+
 test_done
diff --git a/t/t7519/fsmonitor-env b/t/t7519/fsmonitor-env
new file mode 100755
index 0000000000..8f1f7ab164
--- /dev/null
+++ b/t/t7519/fsmonitor-env
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.fsmonitor hook version." >&2
+	exit 1
+fi
+
+printf '%s\n' $FSMONITOR_LIST
-- 
gitgitgadget
