Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B27211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfAIPVT (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfAIPVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so8079711wrt.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iSf21XI43AhzflhPFTBEH9nJsZa3a4RTA6xFfK4DrLE=;
        b=rVP7YsXg5L3gWfAo2ceAdTCPdsvXj/R7dCqFNz4yeN8kLI6zGa1pMHXLg5M8CIUREc
         7PCYQkNh5Zk/mFWmEmIv8pBLjMHKUgHAcu6JEY8vEGLET+TfTkto+pUdk/jQTpyyiA6g
         pBKL1p/jHDdziACE3vV4jnQct9Q7/BMM8ZLSR4evsrmLc08Xm+t209gMvp2LhgWwplxE
         uSLouw4T4kKTG/zX/8d/M7WLvqAuTAhyROwABdpiYiNmEktlSWtBiqAZZEYma1TH/QHS
         B1lIIkPq7//0Og4Mk7PxSebHKQeQ3/oZXVDRTazQYqVn/5AtNVKJ2Yf6959gqNxlf8O6
         gGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iSf21XI43AhzflhPFTBEH9nJsZa3a4RTA6xFfK4DrLE=;
        b=iDasf+/Gg3yDjl22Zs/VGreTPhrpgmHBLsoc1lpHaudfVv8XskJIurP+m5VihKiBGl
         vIhgdqee3SDfvL0Zcg8b5A//nqLCLEJ8TNYj3WSL23TcSdMYVG8sxwMf3JtGVrYoyp2b
         P8RqUpksWTn/w8SBsR9+X/8ofIZAhQ018JoVTIQFK0RnRwlTz2ux6JIb6xzciNXo0p5o
         GTjc9xPVwkcmqj2VY9aiuqofayaymsSlbZ+mf8LyewecNfLuah5QZPLT7cZnO8KdaHax
         A2Gd3QzYFckhokHAUoaUzWp2nqw88nD4s2Rw0AhqAkH37WgJ3m7DZ3eO5pKTBydPlkx/
         xXMg==
X-Gm-Message-State: AJcUukcjpXagDqvh2llDeXtsnGKHGiPWlfRXLenfyyHZ4/81qMnmO4c/
        v/VL7DqwHtQ2G0u8nhVcxDd1mwKc
X-Google-Smtp-Source: ALg8bN4GlLkF1jgQZnk7+mIlu/YgUSg3h8bS62RXHUFlP4LPJWzISBLTcBGjito5Mdzbu9rr+AToBw==
X-Received: by 2002:adf:8001:: with SMTP id 1mr5246508wrk.23.1547047274614;
        Wed, 09 Jan 2019 07:21:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm70935751wrn.44.2019.01.09.07.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:14 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:14 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:03 GMT
Message-Id: <f06382b4aece30a3fdcd0823e870ee1a49ca34f6.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/9] multi-pack-index: prepare for 'expire' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The multi-pack-index tracks objects in a collection of pack-files.
Only one copy of each object is indexed, using the modified time
of the pack-files to determine tie-breakers. It is possible to
have a pack-file with no referenced objects because all objects
have a duplicate in a newer pack-file.

Introduce a new 'expire' subcommand to the multi-pack-index builtin.
This subcommand will delete these unused pack-files and rewrite the
multi-pack-index to no longer refer to those files. More details
about the specifics will follow as the method is implemented.

Add a test that verifies the 'expire' subcommand is correctly wired,
but will still be valid when the verb is implemented. Specifically,
create a set of packs that should all have referenced objects and
should not be removed during an 'expire' operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  5 +++
 builtin/multi-pack-index.c             |  4 ++-
 midx.c                                 |  5 +++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 47 ++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 1af406aca2..6186c4c936 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -31,6 +31,11 @@ write::
 verify::
 	Verify the contents of the MIDX file.
 
+expire::
+	Delete the pack-files that are tracked 	by the MIDX file, but
+	have no objects referenced by the MIDX. Rewrite the MIDX file
+	afterward to remove all references to these pack-files.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index fca70f8e4f..145de3a46c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
 	NULL
 };
 
@@ -44,6 +44,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(opts.object_dir);
+	if (!strcmp(argv[0], "expire"))
+		return expire_midx_packs(opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 730ff84dff..bb825ef816 100644
--- a/midx.c
+++ b/midx.c
@@ -1025,3 +1025,8 @@ int verify_midx_file(const char *object_dir)
 
 	return verify_midx_error;
 }
+
+int expire_midx_packs(const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 774f652530..e3a2b740b5 100644
--- a/midx.h
+++ b/midx.h
@@ -49,6 +49,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
+int expire_midx_packs(const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 70926b5bc0..948effc1ee 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -348,4 +348,51 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'setup expire tests' '
+	mkdir dup &&
+	(
+		cd dup &&
+		git init &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit $i
+		done &&
+		git branch A HEAD &&
+		git branch B HEAD~8 &&
+		git branch C HEAD~13 &&
+		git branch D HEAD~16 &&
+		git branch E HEAD~18 &&
+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
+		refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git multi-pack-index write
+	)
+'
+
+test_expect_success 'expire does not remove any packs' '
+	(
+		cd dup &&
+		ls .git/objects/pack >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

