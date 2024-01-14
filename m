Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6F156DD
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="gLMLIa7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3uwXpulb"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1BC855C0163;
	Sun, 14 Jan 2024 16:44:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 14 Jan 2024 16:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705268655; x=
	1705355055; bh=TLtZL3NgybPv6rdIHhR1knaHaa+Qi6aI6gTVnGlZrQM=; b=g
	LMLIa7AfyS5mFtCGc0DGOoyxeIrHS0npIfjYLeQAcSb4NhmEClAireEkKcUPbo6r
	BlD2q8F2FoynLTv5DWN55zjXw5DyKyB6rwE2vi+qyTcF72++eXtVfjrvo/YFS8zJ
	4TDmCVWoPBJAB5lPkT2lXXskt5hZQ0rQZd12ht1U0U43MV/j3KfH2rSVcs+bTxwW
	Vlo3+dsSbXn8ae5Wp2kL6Sgz93z/+aWJrDGfMFh8QAxF4NxM70Syf1QSkZzy9fb5
	Rv8IRK9oWRTX8jT/Vd/wlxVgRn0yjhPffyxmvp3X08wI51eMLSG6G8A+jOlTU0BC
	SuoZUlkhtljJwagPH9JIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705268655; x=
	1705355055; bh=TLtZL3NgybPv6rdIHhR1knaHaa+Qi6aI6gTVnGlZrQM=; b=3
	uwXpulbQHXE8Z5CrShnC3qDXDF70B9WoS96GYTRgzmTliw/GJ1U5MddPtuR5jDat
	cMwH46hmLjW2K/Dd3FmxZ1juVzJMbMVEBCpN+hrxgrxgNlc2PrDqf/teHQ6C5njG
	e4AYUKCeLbUtrIxq3n1ACMG2eBEgazhIGXz9fghPcXYAO+3NaA4yuOggA/EvzryM
	M2vkUX2WUBECY1pGPCeI/nFZg2ADc2x13A4i1EWmQIktnGi4cwtnQP5NoznVGTaE
	L+RH9O4+XpwR5rYDp5jlK0iGEz2FV94RHdmk3DUp0K6pTDRMz6YEZocLdDHIDoe/
	YSBkPWITkoKTXI0Grf5yw==
X-ME-Sender: <xms:rlWkZcjgYyojkHvNMXD9cwq6_3f81I-BIMj9oFwWAx71v-77sLTTOe8>
    <xme:rlWkZVCB0LjWgcBFjp95OuomE4MspJTboOptDJpz2mVIl1qBpWWvRDNCSS1PZr1xE
    4K8ltOvHylCRSCTsg>
X-ME-Received: <xmr:rlWkZUFHFZJec87CEWuqqeWcLW3LxWk-RibgC14Aq8wvmZySgF69bFsZJFgLA48IzLqmrCkQqcZMFqVhzsei-YwGJEbetIDbR4wxUhKXN4OqqMGyI7NZBBiCUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteduieehgedutdfgudevkefhveduieeiteej
    hfffteeitdegjeeihedthfejgfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:rlWkZdQo46O7H2HNPzCaTzANC9_O3iiQ6kTewZg70rSmfQm2HqMcCQ>
    <xmx:rlWkZZyeGpZk5wBJPKPGjraUQx4jQg7OhbvIg_OtW-I9YqnioKJ5gQ>
    <xmx:rlWkZb5MjNRSKZCnCkqpq2BVIGT1ST8s9K3CwNdoHKGqPQVrww7FLQ>
    <xmx:r1WkZbviMeZoXHavdGXgg_wbs3-uMaXacIU3s08Vja5U2uQeUKlLjw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 16:44:13 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/4] config: rename global config function
Date: Sun, 14 Jan 2024 22:43:17 +0100
Message-ID: <cbc5fde0094d11ee6c222ad8c88765b4c656301f.1705267839.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705267839.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name> <cover.1705267839.git.code@khaugsbakk.name>
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
index 7c11d5ebef0..c078751824c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1546,7 +1546,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 		char *user_config = NULL, *xdg_config = NULL;
 
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
@@ -1614,7 +1614,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		int rc;
 		char *user_config = NULL, *xdg_config = NULL;
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
diff --git a/builtin/var.c b/builtin/var.c
index 8cf7dd9e2e5..cf5567208a2 100644
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
index d26e16e3ce3..ebc6a57e1c3 100644
--- a/config.c
+++ b/config.c
@@ -1987,7 +1987,7 @@ char *git_system_config(void)
 	return system_config;
 }
 
-void git_global_config(char **user_out, char **xdg_out)
+void git_global_config_paths(char **user_out, char **xdg_out)
 {
 	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
 	char *xdg_config = NULL;
@@ -2040,7 +2040,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 							 data, CONFIG_SCOPE_SYSTEM,
 							 NULL);
 
-	git_global_config(&user_config, &xdg_config);
+	git_global_config_paths(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, xdg_config, data,
diff --git a/config.h b/config.h
index 14f881ecfaf..e5e523553cc 100644
--- a/config.h
+++ b/config.h
@@ -382,7 +382,7 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
-void git_global_config(char **user, char **xdg);
+void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-- 
2.43.0

