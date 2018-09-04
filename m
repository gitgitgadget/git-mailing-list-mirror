Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721F71F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeIEC1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:09 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42016 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:06 -0400
Received: by mail-pl1-f170.google.com with SMTP id g23-v6so2247248plq.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J7ixAvPFfJ5mhFwUld32wlpBq2HkCx+EcupUyPk8ZMg=;
        b=TLDLs9dm80ZdjOFmUVuFLhHTt8qBGOHBrZwXYnM2xh/jqZQ2ONuGNKVmZeTrJ6DalD
         kn4fouUa50kMEttKTxFLBeYPc4tLJjj/GzeEaZAdEihfwDtRqTKkW4wF82csK8WHMhSV
         14/Zwh1F715RxnxEdeWxsVyQoVLk6aXOSMaFN5adhGekkDIbkGblBUln/630qL74grzL
         lYdCU8yJccgtpbwSt0o4mt3vuwKmXRxJoLP8rhlS3b2HCBJQsEppgGjqog9PCXaDUhDO
         eA21S8NOYOfUZxlmUhWEBdyvfWT4lzYlMO7BpiUaq0fJ4j71zj54vL7PGwRxJzE8Tjka
         noNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J7ixAvPFfJ5mhFwUld32wlpBq2HkCx+EcupUyPk8ZMg=;
        b=DpHxf4BGBjH+A/KVyjFf+IcgoMc3LE65CGuIl48GcqNtqBxcRydX0YodAuN09GuGpb
         p7UoLVufskCNsWghr59IW/eeW1y155ZIWQzWcfxOIFVtVfBd4KSXwxma5xWMIIuF/qmO
         dLyWGh786YsSKltbFYxumwETdqG9epkokePbdTAUAxIbMZi+7EjuioRGRxAgx9tXvhQO
         I4lLnRsjLfCEMsvsyTuPFH4Cn5CzhRnoNKSSVqAK7vppdBcBh9VkbqcfzI6+pH9gCFeI
         nKHuoqewrgCT5unrHrRzAetkgzCfTr644xxvtKi3xCwjx4gzpQf0YVkkeIzJX5sLCXRy
         KOCw==
X-Gm-Message-State: APzg51CsljZqruUuJTp7wvcDWAujcqNpU/XTVqxDyV7awRsvuz7Bv3EA
        kGoM7+HD9RJSGh3liupc4GetU/Qm
X-Google-Smtp-Source: ANB0VdYnoHzzMrKjq/6BQtwOUSK/veMTVsyrkZD6F3MlSSPpABpSNIbV9H88f9CbqZ68ftvCrKmQZw==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1-v6mr35647218plb.86.1536098402304;
        Tue, 04 Sep 2018 15:00:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id u184-v6sm31032666pgd.46.2018.09.04.15.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:01 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:01 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:37 GMT
Message-Id: <98908573ce37abb3026061a8700dc74c23056955.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/18] builtin rebase: support `-C` and
 `--whitespace=<type>`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit converts more code from the shell script version to the
builtin rebase. In this instance, we just have to be careful to
keep support for passing multiple `--whitespace` options, as the
shell script version does so, too.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ab86b7c4c..63ffe5e1ff 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -574,6 +574,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ignore_date = 0;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
+	int opt_c = -1;
+	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -640,6 +642,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    "squash!/fixup! under -i")),
 		OPT_STRING('S', "gpg-sign", &gpg_sign,
 			   N_("gpg-sign?"), N_("GPG-sign commits")),
+		OPT_STRING_LIST(0, "whitespace", &whitespace,
+				N_("whitespace"), N_("passed to 'git apply'")),
+		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
+			    REBASE_AM),
 		OPT_END(),
 	};
 
@@ -847,6 +853,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 	}
 
+	if (opt_c >= 0)
+		strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
+
+	if (whitespace.nr) {
+		int i;
+
+		for (i = 0; i < whitespace.nr; i++) {
+			const char *item = whitespace.items[i].string;
+
+			strbuf_addf(&options.git_am_opt, " --whitespace=%s",
+				    item);
+
+			if ((!strcmp(item, "fix")) || (!strcmp(item, "strip")))
+				options.flags |= REBASE_FORCE;
+		}
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

