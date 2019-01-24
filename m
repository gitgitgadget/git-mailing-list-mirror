Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AB11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAXVwD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:52:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42628 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfAXVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:51:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so5814307edw.9
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p/NfXfCR9Biih22TQ/5cUFRPA5OpU1lVTtKAGfgg+IE=;
        b=Abqvzrc7BqV+elLUVnQuUcaEvsE7b15npA0whwbAJt9v2n/h8aTwRwjZ5qmks4CCXk
         14YWNQmqumFMtGLwWkTC6xWjExvv+u25Ep5iAJzqSyF7cTf184S1PNzqJtC9cxvmMyvI
         fGTZoeIk4IoncIrXwq+C2ZemdOk7DadEKj9xfCpjAKICvWnTNgguS1Wajf2e52Yu8bxM
         gX1cRAeVldmqbUXarKxp0KveauxZD6cbg4ZQ4vVLSEbRdgcPaJvidGoepM1XHREMuRlC
         QsXyht7nshm1ikr3rfxCyUY2GF2kAPhHCCIsKiwjarM7Osi3ZbVgw07KUFfwoqMn5GKc
         4lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p/NfXfCR9Biih22TQ/5cUFRPA5OpU1lVTtKAGfgg+IE=;
        b=EldobB9FVCkxkLghPpSzTkKiu/axyDiZEZEmk7o843j/jskik8rBqn/pVrZ33V9otS
         8CLanfpfv8pjzL1tp98MJZkR+Lt5aYdq2QoUKI/vv1HB79H/6kKQQqRHr80OHHh+Jxye
         Hum6ry6jr/axWiMRO7COPuaeaqtBwjZ542Crm8bXfQl0GJm9hDnRZdK71MAWVdOMf2wR
         ZwgYNfionnOa1R3Mfs0zpy6EbCqi/2QNx4q56N18PYsyZDaELQf0iFxMhMfwosOurX2S
         WwDfD4QadzAo1QDhMYMwDOseVn2MGoNRCNdx3jwTRxiG/cHbk89FF4um0hf9KD/xTmog
         jwdQ==
X-Gm-Message-State: AJcUukdSm4g74IIQKX6p0v616VM9fMZoFTDmOVVGmNk8xT0tNUpFWYM/
        DKUrnq15uVF2Li6ovnIZOJaUfjxM
X-Google-Smtp-Source: ALg8bN4SuRJD1EQPJG8WVBd5wtBqJmH6T8XHigyCVebIDHEfpW+r/6CqF8YYwT50PQmsDO5wSH0bkg==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr7806823edi.246.1548366716924;
        Thu, 24 Jan 2019 13:51:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l41sm11791962eda.83.2019.01.24.13.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:56 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:51:56 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:46 GMT
Message-Id: <628ca4603690b1239d722df8560dcd0b3790738d.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 03/10] multi-pack-index: prepare for 'expire' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
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
should not be removed during an 'expire' operation. The packs are
created carefully to ensure they have a specific order when sorted
by size. This will be important in a later test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  5 +++
 builtin/multi-pack-index.c             |  4 ++-
 midx.c                                 |  5 +++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 49 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

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
index 70926b5bc0..a8528f7da0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -348,4 +348,53 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'setup expire tests' '
+	mkdir dup &&
+	(
+		cd dup &&
+		git init &&
+		test-tool genrandom "data" 4096 >large_file.txt &&
+		git update-index --add large_file.txt &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit $i
+		done &&
+		git branch A HEAD &&
+		git branch B HEAD~8 &&
+		git branch C HEAD~13 &&
+		git branch D HEAD~16 &&
+		git branch E HEAD~18 &&
+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
+		refs/heads/E
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

