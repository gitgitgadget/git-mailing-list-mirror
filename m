Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4122C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeIEC1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so2346079pfi.10
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zRwMmA9rj8lZ+ScV4Qj5oVZnBqFQtSbFDl2+Hb1+VXU=;
        b=M6S1G8MGGihUSJVuUl3+9LvMkN+zSF2kPqcYVWhBJor+T0/p4rsmN11Oz3NpjGzlsT
         fXdV0z7nIxYjOGrbYh0J9V442PyHHcgvcyngQeV6+7mtNyxYnq5eZS642UXO+u2VKj82
         SmdircCx0RKsYGqSiDUlmY8VlovilAKYxQcnNMMqMicOm3XTHGEPTAit1mqWMAb3zoxD
         FP+oGl9inC3OEa6zyHMmtR3DsFnqUXT78+HVwykEq5PSMNRFGps912o5PfcLz9JEhgf4
         3pzgQ6oSZW2wTPouK6HPdtmPvf4jaQv6/cmePEFLPouZmK9AGM/mS/dQFHMZWNy57FTs
         kPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zRwMmA9rj8lZ+ScV4Qj5oVZnBqFQtSbFDl2+Hb1+VXU=;
        b=ODppp7ZbjRN3XTRcbKhYXPUjDXGkQxxYOM3gF0Yll+yZ2+TDsXsmEA6HnF1LE0OhTN
         RAUUHYEzisV486mD7AtyG/Webnu45u/6UyUxoZdDZMzqymUONT1TFiAJUFak02eSVxkx
         8MwenyRQScEYUwr9T9VcgAkXYLUE3tJ8bNS+vD7CxoUiGnl4824ehy06ckv70oDfOtB9
         +o45N7LJ5Mv6wiIddqO3pdBh3NMRiqQBuGDncuG6H1xEghNmKfB1WNFu3kkLz8P+7JAQ
         VjgyaZJ85LMZvu60fiPjWxNQNyxNWvCvhOIAw0tPspAjx39y9GBICPL+zz23bI5ZfKiv
         5O5g==
X-Gm-Message-State: APzg51By+Jhpo03VQadaqkLrdKEfRcak3fQaMYwU1OZzxBVP/bXEkSHU
        vIQMxp9LjN/Wk70SACDbIDThBXX/
X-Google-Smtp-Source: ANB0VdYv+/G/60ucy/InGVL5wR3OwZKe5YduO3WfTbi+CbXSZzNJBYQ39XAJ1tT9TOnQKA3OyaB9Wg==
X-Received: by 2002:a62:9042:: with SMTP id a63-v6mr36836804pfe.52.1536098398148;
        Tue, 04 Sep 2018 14:59:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p19-v6sm30830862pgh.60.2018.09.04.14.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:57 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:57 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:34 GMT
Message-Id: <a8f12bf01ffb5411374843083cb18a7fa84a4935.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/18] builtin rebase: support `keep-empty` option
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

The `--keep-empty` option can be used to keep the commits that do not
change anything from its parents in the result.

While the scripted version uses `interactive_rebase=implied` to indicate
that the rebase needs to use the `git-rebase--interactive` backend in
non-interactive mode as fallback when figuring out which backend to use,
the C version needs to use a different route because the backend will
already be chosen during the `parse_options()` call.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 42ee040da3..9c00f3568f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -95,6 +95,7 @@ struct rebase_options {
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
+	int keep_empty;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -103,6 +104,23 @@ static int is_interactive(struct rebase_options *opts)
 		opts->type == REBASE_PRESERVE_MERGES;
 }
 
+static void imply_interactive(struct rebase_options *opts, const char *option)
+{
+	switch (opts->type) {
+	case REBASE_AM:
+		die(_("%s requires an interactive rebase"), option);
+		break;
+	case REBASE_INTERACTIVE:
+	case REBASE_PRESERVE_MERGES:
+		break;
+	case REBASE_MERGE:
+		/* we silently *upgrade* --merge to --interactive if needed */
+	default:
+		opts->type = REBASE_INTERACTIVE; /* implied */
+		break;
+	}
+}
+
 /* Returns the filename prefixed by the state_dir */
 static const char *state_dir_path(const char *filename, struct rebase_options *opts)
 {
@@ -276,6 +294,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->allow_rerere_autoupdate < 0 ? "" :
 		opts->allow_rerere_autoupdate ?
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
+	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -588,6 +607,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index  with resolved "
 			    "conflict")),
+		OPT_BOOL('k', "keep-empty", &options.keep_empty,
+			 N_("preserve empty commits during rebase")),
 		OPT_END(),
 	};
 
@@ -787,6 +808,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	if (options.keep_empty)
+		imply_interactive(&options, "--keep-empty");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

