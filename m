Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95111F453
	for <e@80x24.org>; Fri, 26 Apr 2019 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfDZLs3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 07:48:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35385 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZLs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 07:48:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id y67so2936176ede.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=arNfFjYvVaNgon3PnKrJaqDsb21ANtxqyxPwWxXM1QE=;
        b=kqVfPgWKr1daAppTD4K/nMwlGbuJfiUfLAZQ0ONWdVRzhLSW5kakY7UhnAPc3WCEse
         teI76zIefTKOzeu9funVhQwx8N3djUTeTzGNrKflMMpzwtVoGHSYYmgErOs8edrUBLl0
         tjjn4soTwPuLCxdvT+r8N9Exq7/HgzVywjJGC80EyFI4MZY5noMGvo6inQBQs2S6E8rM
         Vo/i073IXq1QqvvqO5+Wq7ktz/nNI6s4pjlpOf3un6uVo9j1Y4rf5GZD9YKrXhuo9/Gc
         FH3zu8ltmEkqxDBmU9FH0aJr55LD9+YquFBFp6n/VgeBSGXC+jp8Jbriz6fROqylxB+M
         d0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=arNfFjYvVaNgon3PnKrJaqDsb21ANtxqyxPwWxXM1QE=;
        b=NHTtdv64Y2+lcFMtdBa2yK3LaRa8eejYUlCIHrz6YwaKNiezjf9IFS5M+ZJ6geWXMx
         FcBUHGCqADxRyqQ6EWBoRFjqW1DQjQAQNDSQHuf8SxUmvN0qrTXcjDHzRFy+gSFGs1D9
         waWg3WlBvMMJ7kKOwA4hTusJYQ4gDiXxWGFSNwa0AVKk6fno+PLV6KurfjMJr6U4FOU8
         MkyjDSY6YLZqctkpWdHHv5hEwti5MbB4htKTe6ZKoGGkVrRUVh+AHwgNIyGoniO3o3/9
         MZy8pz+u0MWjJhQfcewp6UItJTnWU1YkRDNHMwpC4TJYi3tUghPi8NjFXmuUzCSjPiTi
         zilg==
X-Gm-Message-State: APjAAAVkt3+CgcidR8kSXHNBR+68qeaVRT5JW7cDvxCtTrLhGOw4z5jJ
        k1PrSU1NVW7W5B38TFwAqJBX8xOs
X-Google-Smtp-Source: APXvYqyObJSFH3pQeB9kOiQhWk9yJgTpWvC8MLuHWkjPDaY/jSI341dDPL5pF44V1DJItx1dvsXNig==
X-Received: by 2002:a17:906:6548:: with SMTP id u8mr10299556ejn.275.1556279305614;
        Fri, 26 Apr 2019 04:48:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm3451638ede.15.2019.04.26.04.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 04:48:25 -0700 (PDT)
Date:   Fri, 26 Apr 2019 04:48:25 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Apr 2019 11:48:23 GMT
Message-Id: <1751b479e79ba18990e4152ae2acdf60c8713340.1556279303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.181.git.gitgitgadget@gmail.com>
References: <pull.181.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-graph: improve error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The error messages when reading a commit-graph have a few problems:

1. Some values are output in hexadecimal, but that is not made
   clear by the message. Prepend "0x" to these values.

2. The version number does not need to be hexadecimal, and also
   should mention a "maximum supported version". This has one
   possible confusing case: we could have a corrupt commit-graph
   file with version number zero, so the output would be

   "commit-graph has version 0, our maximum supported version is 1"

   This will only happen with corrupt data. This error message is
   designed instead for the case where a client is downgraded after
   writing a newer file version.

Update t5318-commit-graph.sh to watch for these new error messages.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 10 +++++-----
 t/t5318-commit-graph.sh |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 66865acbd7..aba591913e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -167,21 +167,21 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
-		error(_("commit-graph signature %X does not match signature %X"),
+		error(_("commit-graph signature 0x%X does not match signature 0x%X"),
 		      graph_signature, GRAPH_SIGNATURE);
 		return NULL;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
-		error(_("commit-graph version %X does not match version %X"),
+		error(_("commit-graph has version %d, our maximum supported version is %d"),
 		      graph_version, GRAPH_VERSION);
 		return NULL;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != oid_version()) {
-		error(_("commit-graph hash version %X does not match version %X"),
+		error(_("commit-graph has hash version %d, our maximum supported version is %d"),
 		      hash_version, oid_version());
 		return NULL;
 	}
@@ -215,7 +215,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
-			error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
+			error(_("commit-graph improper chunk offset 0x%08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			free(graph);
 			return NULL;
@@ -252,7 +252,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		}
 
 		if (chunk_repeated) {
-			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
+			error(_("commit-graph chunk id 0x%08x appears multiple times"), chunk_id);
 			free(graph);
 			return NULL;
 		}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e80c1cac02..264ebb15b1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -420,17 +420,17 @@ test_expect_success 'detect too small' '
 
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
-		"graph signature"
+		"commit-graph signature"
 '
 
 test_expect_success 'detect bad version' '
 	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
-		"graph version"
+		"commit-graph has version"
 '
 
 test_expect_success 'detect bad hash version' '
 	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
-		"hash version"
+		"commit-graph has hash version"
 '
 
 test_expect_success 'detect low chunk count' '
-- 
gitgitgadget
