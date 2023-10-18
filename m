Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FD3DFF6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="OzmRJK1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vIWQbOHR"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC21BF
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:29:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 3DF715C01A0;
	Wed, 18 Oct 2023 16:29:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 18 Oct 2023 16:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697660960; x=
	1697747360; bh=IVZe7LcBH7kIXFvwUiHdiyKp3CvN+hIRwcElAV/sG3k=; b=O
	zmRJK1FgGzMtVgbSnh7LC1ek7A0gd09sZwrmZTCj85J4OrJQVGE/YKtB6bfswNCe
	7rifAPlV7rEwMwGh3XF6qcPLziGlxDyWlpqZhZaUoYXI3ZEpYUM6gRDi0DZHqDdg
	3YDTaBDuihQD5WeTKH31ONQcRf5oaJQs2zLo+luL32FvvEPUpV0KN5xK56UdSisz
	0RjlBYhYhgr+lkMxKStpdKHLjC726f0yuP7Cxb97AzwtCq37qPJR9VBY6AguOX2x
	UabbXNcmr8sLv4lgh5cuIv2sA7yHVb4lAG0C/0RNfWyXacHhYW6G0bDF9ViT0F+Z
	TiEo/WW7XPb5nkRMDAprQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697660960; x=
	1697747360; bh=IVZe7LcBH7kIXFvwUiHdiyKp3CvN+hIRwcElAV/sG3k=; b=v
	IWQbOHRLlpb9Tbyzd1l6C1mofzd95XvcpxMLgo4c3wD0eqJpRpzyWTXJwuLL0MPt
	Wj8VdbFgXCkDV7Qgj5IM7PTt+WSEvxD96tYD4qBmkxOf4MomE4Hw5NqF60kfVPaI
	B6teDniO9Y0w8Mv+/nVJoQGIqJx0YLsOpGk3vHAKODn7kgMnCuYlOYkiL5oX15NM
	R19Jezko2Lt/qTAKCBOlIDmuhxxbGmRhxkzVUr5hSf7M+oL+W0EhMTiHkj7rE12y
	+xIOqmGFZwFOFvaHgRyad0XeCoKYWZ8wYd+gQ7P0A6KMKoWzi/PNI0GAbCVva04a
	yVXI3Zfm5EUavNyrDXDlg==
X-ME-Sender: <xms:IEAwZbVc1oYdmPeX3SnOJmyLKxRBCGUpCONGAr82Kc0iLRrTUEREKAI>
    <xme:IEAwZTkzYrUByeoA_uktiMdKNTKh4RJtP9ENTnxW5AijX0eYxBtQdeHnVQ_dBzdki
    JCRbd2cEj_dknwejw>
X-ME-Received: <xmr:IEAwZXZdwRKKUHJTNt-eTiBPuAOG3mWnphaZ7mB9vz8eh-SqzRxBvPVC0hdAGjkN95C_zvPdzuuxSVi4QVTSpz9BM-LCtS0QRT81fS6IjEbAvdqpOuTzzefr_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:IEAwZWU7-Hc4ouOuTUWPBVQPUP8CfB1pgYq5kzCiKzZfMYPzIJlpLQ>
    <xmx:IEAwZVnMba2IFroZrFMGKjEufy-Tv4PEd4FWfqeXQlD6v0CwQ2ETqw>
    <xmx:IEAwZTeUSo5nLOPrweM--GeImCzZZG5yb2uAj0FfUGyDzWmp_1Z1cw>
    <xmx:IEAwZayruhn7RDb2vBUqzZLl8dF2Ra4qTyOUK4o48mFQZrcpMeNlWQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 16:29:19 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v1 2/4] config: rename global config function
Date: Wed, 18 Oct 2023 22:28:39 +0200
Message-ID: <48a5357f97cec2c5babc6512e0b30bcb8f7d201f.1697660181.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Rename this function to a more descriptive name since we want to use the
existing name for a new function.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/config.c | 2 +-
 builtin/gc.c     | 4 ++--
 builtin/var.c    | 2 +-
 config.c         | 4 ++--
 config.h         | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 87d0dc92d99..6fff2655816 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -710,7 +710,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config) {
 		char *user_config, *xdg_config;
 
-		git_global_config(&user_config, &xdg_config);
+		git_global_config_paths(&user_config, &xdg_config);
 		if (!user_config)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
diff --git a/builtin/gc.c b/builtin/gc.c
index 5c4315f0d81..17fc031f63a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1529,7 +1529,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 		char *user_config = NULL, *xdg_config = NULL;
 
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
@@ -1597,7 +1597,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		int rc;
 		char *user_config = NULL, *xdg_config = NULL;
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
diff --git a/builtin/var.c b/builtin/var.c
index 74161bdf1c6..8e18b50b1e5 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -90,7 +90,7 @@ static char *git_config_val_global(int ident_flag UNUSED)
 	char *user, *xdg;
 	size_t unused;
 
-	git_global_config(&user, &xdg);
+	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
 		strbuf_addf(&buf, "%s\n", xdg);
diff --git a/config.c b/config.c
index 19f832818f1..d2cdda96edd 100644
--- a/config.c
+++ b/config.c
@@ -2111,7 +2111,7 @@ char *git_system_config(void)
 	return system_config;
 }
 
-void git_global_config(char **user_out, char **xdg_out)
+void git_global_config_paths(char **user_out, char **xdg_out)
 {
 	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
 	char *xdg_config = NULL;
@@ -2186,7 +2186,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 							 data, CONFIG_SCOPE_SYSTEM,
 							 NULL);
 
-	git_global_config(&user_config, &xdg_config);
+	git_global_config_paths(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, xdg_config, data,
diff --git a/config.h b/config.h
index 6332d749047..9f04de8ee3e 100644
--- a/config.h
+++ b/config.h
@@ -394,7 +394,7 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
-void git_global_config(char **user, char **xdg);
+void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-- 
2.42.0.2.g879ad04204

