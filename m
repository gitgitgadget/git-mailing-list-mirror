Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDD1643A
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="fr6U1nLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvJ/zux7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 05EE85C0154;
	Sun, 14 Jan 2024 16:44:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 14 Jan 2024 16:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1705268657; x=1705355057; bh=B40a88ix/gHP6N5GaV7MGR4o3NZlLWSB
	w/bHGClsxEQ=; b=fr6U1nLS/U1zp09KEk/cbYXImlwgMUKrxJ+drABrnA1qOHd9
	RfRP1Bl0ksvKH/detyoqn0ON/1fUxnECkRBZWqEcXcxiaPWb+J1VbJ13NTKHB3jJ
	7npyni7rL2VjvbaSzkYMZjUYKoIQcLXlR5wZ5qdMRS2ZwV4xMXSkUe/omqLskK+o
	N/mhV6tIAwwPFWoz28ah4ZjymyrYo+gzrSCdtRr7RH7llFoGiTSq3j1I6I3KRHg3
	DCKdNUap9+hqkIdZncWKOQ1nTkmx4dBr2Trg/1lc825sNhAIziiSgLZ/fei0xmKa
	K0q63EeUMwUm2qGw26BezjzXtnCq2Yvm1J1Sdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705268657; x=
	1705355057; bh=B40a88ix/gHP6N5GaV7MGR4o3NZlLWSBw/bHGClsxEQ=; b=c
	vJ/zux74MZ7J/YbLlizC/roXPyhOsE0+2Q297fngIuJKG5AJPkWGg9cDYy8Ry+U8
	7gleSg2vmpfBjyPU30Oa9VVPzVzbMPwK+7PMHC5T1QgODwnK+VZ5BL4n9awrdrle
	2LWMR0MJaYTA1wAq4IMB6GgJqJbiyXSQ3BV9qaErS9QCQVy9ZZBkia9KApblA6OV
	kXpuBvXs8QwirxvfWfS6TPzuHqTWfdugCSLGhFVVvbvPadRtEV9TkBfZWkael8JV
	pxiYO9FabZojZZ4ECZ1lvusceYJlz5QDzYS8ehSp2jVfHFb/ytdfGHHlUdcNIHSQ
	ERe7DuU13q4V8GpvRdsIQ==
X-ME-Sender: <xms:sFWkZVvRVc313JyVzoaxndeYK-56DDFOqIOc2g0E3-3IXx89yDKtHLk>
    <xme:sFWkZecBfLkzxZ-LKLo54dCV6plRCeg0qeUbVJqqLHnLuelV88fs5-NQj5vHbA675
    q472F0TuTu_BbgC4Q>
X-ME-Received: <xmr:sFWkZYyx1m3PdmjMbagt-DQ0dr8PJerygCtigJmEootuClCSKAQT8tWs-spdK5Fvh2r5w0bOFiPf5-Tzl57VIcKC09D5L1DOo-PMm3AxBhDRuBBrjS3zw2f3VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:sFWkZcPM4AFS5arlgiudynEMK7AzdFNCAHcVXsZ4LBMN9jAMHEa_dw>
    <xmx:sFWkZV8ltt4PSjeZho_sUAUkfSmZJCl6pvfLZYh9iFY304ipzTemNw>
    <xmx:sFWkZcXfm8-lwMhh0ORb4pX-5d9BCC8khlc5K-BTDa5Ig2XiFSJ3Rw>
    <xmx:sVWkZRYr_MTf0DaQbdP_TClYl6n2d9gT932aFioCaPZiD9669EL9wA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 16:44:15 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/4] config: factor out global config file retrieval
Date: Sun, 14 Jan 2024 22:43:18 +0100
Message-ID: <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705267839.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name> <cover.1705267839.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Factor out code that retrieves the global config file so that we can use
it in `gc.c` as well.

Use the old name from the previous commit since this function acts
functionally the same as `git_system_config` but for “global”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Don’t die; return `NULL`

 builtin/config.c | 25 +++----------------------
 config.c         | 20 ++++++++++++++++++++
 config.h         |  4 ++++
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6fff2655816..08fe36d4997 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -708,30 +708,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *user_config, *xdg_config;
-
-		git_global_config_paths(&user_config, &xdg_config);
-		if (!user_config)
-			/*
-			 * It is unknown if HOME/.gitconfig exists, so
-			 * we do not know if we should write to XDG
-			 * location; error out even if XDG_CONFIG_HOME
-			 * is set and points at a sane location.
-			 */
+		given_config_source.file = git_global_config();
+		if (!given_config_source.file)
 			die(_("$HOME not set"));
-
 		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
-
-		if (access_or_warn(user_config, R_OK, 0) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
-			given_config_source.file = xdg_config;
-			free(user_config);
-		} else {
-			given_config_source.file = user_config;
-			free(xdg_config);
-		}
-	}
-	else if (use_system_config) {
+	} else if (use_system_config) {
 		given_config_source.file = git_system_config();
 		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
 	} else if (use_local_config) {
diff --git a/config.c b/config.c
index ebc6a57e1c3..3cfeb3d8bd9 100644
--- a/config.c
+++ b/config.c
@@ -1987,6 +1987,26 @@ char *git_system_config(void)
 	return system_config;
 }
 
+char *git_global_config(void)
+{
+	char *user_config, *xdg_config;
+
+	git_global_config_paths(&user_config, &xdg_config);
+	if (!user_config) {
+		free(xdg_config);
+		return NULL;
+	}
+
+	if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
+	    !access_or_warn(xdg_config, R_OK, 0)) {
+		free(user_config);
+		return xdg_config;
+	} else {
+		free(xdg_config);
+		return user_config;
+	}
+}
+
 void git_global_config_paths(char **user_out, char **xdg_out)
 {
 	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
diff --git a/config.h b/config.h
index e5e523553cc..625e932b993 100644
--- a/config.h
+++ b/config.h
@@ -382,6 +382,10 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
+/**
+ * Returns `NULL` if is uncertain whether or not `HOME/.gitconfig` exists.
+ */
+char *git_global_config(void);
 void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
-- 
2.43.0

