Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC4E1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAUJNs (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44504 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfAUJNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so15926556edd.11
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c0HymROOdhLPhJ4ItXr0cvQM8M8lupIo2/ijvNiLxeg=;
        b=jwlMIg6NYr2UjkQCMAzBKIuMD3pLFP3D79XnGWf6bxc8BUuyOJ7mMj+T4wqQAZgsvZ
         XqvWiD42wDPQ9ps8EELX8Zi67X8HH6hiiBnp5/GVsa/o8aOv8464l5K9W6ukxqvqezOz
         uEvq4I6lAzdd8Rb9AZlCELoH6GQOh6GJ9goDoYhge8oWYKTIe8rGidLse1XYrsPzUFsE
         +UnFJ4fn4pMACghLtPJyM6LPyeGcsLQLt9dB6k71KE0ED658R7jsMFReRGypNDHIgsYU
         Ti/3dHWAQIiMXo2pSYzDPqsx9Wk8ZlZZFO8dcpGVEluzB2/Gd3MrvKAALfERvHxm5CkZ
         cvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c0HymROOdhLPhJ4ItXr0cvQM8M8lupIo2/ijvNiLxeg=;
        b=Utm2n05bhi1ij3fl6TUQh/ACKF9i12yWkRZVLo80AKZHXGZFOyc/7POpSkDMwrL5WE
         LuxPpTqnvqfDVt5ZMP1Y6tw1pv3507p4sTHjK/FvJbih9JxpjW0aCmqhj1W1naenWV05
         IRHHhiWmKtyY7WF1YL8ZYgeJtO1Myo+9rL6jy3l8xois0Qx3tfCUaIZbSDfUmKZVv80W
         Dhi0ktQOxrT3z4JulUdo7xNcUw+vsCxIm0n9EbrzmxSa/vHx0henFYtB9JaCYiVFsANY
         Q4csinCSYF6NVAykkhDvoLUatP/VRPHs6bh7rMmkz9PmaNb7DX2Mw7CjkoGi/l+XzBH0
         N91A==
X-Gm-Message-State: AJcUukeFqgShm4iSbkD13K5VLIcj6scXbF5XNmTBv8IZazfNwhg/V7/B
        YJ6sE1rMKITCNbzyFb+JNgRDJV3z
X-Google-Smtp-Source: ALg8bN7UNadCgViF+kTrMlM3iVNBHmVr1b+4B9zCgF+dbrmm4nrHdqpqnzdE6/GefccdcuZUP7EKGA==
X-Received: by 2002:a17:906:c5a:: with SMTP id t26-v6mr23338363ejf.140.1548062025034;
        Mon, 21 Jan 2019 01:13:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h51sm9771473edh.17.2019.01.21.01.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:44 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:44 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:37 GMT
Message-Id: <581b108c9c3a090660ee655263c4639d1bf409d6.1548062019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
        <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/7] add-interactive.c: implement show-help command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Implement show-help command in add-interactive.c and use it in
builtin add--helper.c.

Use command name "show-help" instead of "help": add--helper is
builtin, hence add--helper --help would be intercepted by
handle_builtin and re-routed to the help command, without ever
calling cmd_add__helper().

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c     | 17 +++++++++++++++++
 add-interactive.h     |  4 +++-
 builtin/add--helper.c |  7 ++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c55d934186..d239037bc1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -244,3 +244,20 @@ void add_i_print_modified(void)
 	free(files);
 	hashmap_free(&s.file_map, 1);
 }
+
+void add_i_show_help(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "status        - %s",
+			_("show paths with changes"));
+	color_fprintf_ln(stdout, help_color, "update        - %s",
+			_("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, help_color, "revert        - %s",
+			_("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, help_color, "patch         - %s",
+			_("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, help_color, "diff          - %s",
+			_("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
+			_("add contents of untracked files to the staged set of changes"));
+}
diff --git a/add-interactive.h b/add-interactive.h
index 1f4747553c..46e17c5c71 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
 
 void add_i_print_modified(void);
 
-#endif
\ No newline at end of file
+void add_i_show_help(void);
+
+#endif
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 43545d9af5..a3b3a68b68 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
 
 enum cmd_mode {
 	DEFAULT = 0,
-	STATUS
+	STATUS,
+	HELP
 };
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
@@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "status", &mode,
 			 N_("print status information with diffstat"), STATUS),
+		OPT_CMDMODE(0, "show-help", &mode,
+			 N_("show help"), HELP),
 		OPT_END()
 	};
 
@@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 
 	if (mode == STATUS)
 		add_i_print_modified();
+	else if (mode == HELP)
+		add_i_show_help();
 	else
 		usage_with_options(builtin_add_helper_usage,
 				   options);
-- 
gitgitgadget

