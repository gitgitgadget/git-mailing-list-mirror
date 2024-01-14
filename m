Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC57168BD
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="GkBKecqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGdx24gT"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AB38A5C015A;
	Sun, 14 Jan 2024 16:44:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 Jan 2024 16:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1705268658; x=1705355058; bh=DW7CRPU9dPo0SDRpw3mxElfp0Xq0I0hG
	ctA/vo834Tk=; b=GkBKecqCShQrqBgkvC8VdcArnefLNS88tZ831rkikVi74eDm
	EdC9CPPdJn3Lc6OQyVStFbYNCbz4fknwvNDUcUZERBCuHCSa54QsB5fGWrZ5OXBO
	Q0Ppp5r9ETozAzMOZevHWulUProTLAMbPqAUiR/Z+wi4ltCq2Vix1kdEM2t06i+n
	KMyB+Shv4seU9xaszmD5KcJnQ01CmIvOkwODAnkP0eQTO9I4JRFUVp+dW5ZJcOvq
	TwECNJviJRW97ddNhQzsMx46M0Yw+9NwimRserwwlrd5fuFCEur7YKZKw/PVMPqx
	l+K4Y3k6f6feBUDSKWB7sd8QfOtF2r4FrJW/KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705268658; x=
	1705355058; bh=DW7CRPU9dPo0SDRpw3mxElfp0Xq0I0hGctA/vo834Tk=; b=m
	Gdx24gToGOYmU9D2MbssC5V5ZmL6XQvxWg7nxAZDXxZiVLBIirRNTGXGtX/axIBI
	7TdCQl4HKVVYBcECPdmeaULuxo6SlFPOqtUsXD9bgvZJwoYWtSeLisl0r3PyDrsv
	7yaSsXesog85TgJ2fjzavVMWzlZHUQQnnIj0pBwUSF3dQFZKn961bE5ixWSyopwE
	4vHpHbedJhyQxtC+LPKlGEKYkuOP5knWg2IIImRHZHCFFZZn5T59JafKm3JtRnAD
	4uliBB657VoupCeDkJeV9kUo4PttsGPT1b17/WtAwYewvtmBFZZs8jmPkk7QBLJJ
	A4lhfTrKbz8f5o9ZwKTsQ==
X-ME-Sender: <xms:slWkZc-vccu8ff6Xq7KO2_xqfVDBWyccV-Q3X4ZxVQezNaE6j1htFAQ>
    <xme:slWkZUvxJaC56mSyhRgz8jfQF9_nFWRr2lfqb41rK_J6mD6mVoZwKH_K2pmiBIl99
    1tNkUyReT_ZVZNa2w>
X-ME-Received: <xmr:slWkZSB3dbmqNCaP5GUlHPoksR9S_b6JLf1cLlKPs6GQ9v1gkVyWS0L8-J3MiqF0-8oGY_a13i0sufJnBqnYIT4y6JtN8LMlUGtOgRWyAOjO73uyHePhwxSZvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:slWkZcfkbVbabw2jXN5ff-dkV3cYkNYHPe-mXGqRWYwPrSOJP886aA>
    <xmx:slWkZRP3DD4jXHeqEMxwXtu5Dg73NvjUvlTL8W7qjaBvnWTQFvCZxw>
    <xmx:slWkZWnh6tHHxUq1DJWQJtFTExjIReZYnPbLWWfqYRnRr0Kx7dOXHQ>
    <xmx:slWkZWo8SNduTTwVdbewdLX-5zm6R0MZJtNWY5Lh7do8znMyWIHNyg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 16:44:17 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/4] maintenance: use XDG config if it exists
Date: Sun, 14 Jan 2024 22:43:19 +0100
Message-ID: <8bd67c5bf01ca10fbf575dfa2cf88f8c88b48276.1705267839.git.code@khaugsbakk.name>
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

`git maintenance register` registers the repository in the user's global
config. `$XDG_CONFIG_HOME/git/config` is supposed to be used if
`~/.gitconfig` does not exist. However, this command creates a
`~/.gitconfig` file and writes to that one even though the XDG variant
exists.

This used to work correctly until 50a044f1e4 (gc: replace config
subprocesses with API calls, 2022-09-27), when the command started calling
the config API instead of git-config(1).

Also change `unregister` accordingly.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Add `unregister` tests
    • Use subshell when exporting an env. variable
    • Style in tests
    • Free variables properly

 builtin/gc.c           | 27 ++++++++++++-------------
 t/t7900-maintenance.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c078751824c..cb80ced6cb5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1543,19 +1543,18 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 
 	if (!found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
+		char *global_config_file = NULL;
 
 		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
+			global_config_file = git_global_config();
+			config_file = global_config_file;
 		}
+		if (!config_file)
+			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, 0);
-		free(user_config);
-		free(xdg_config);
+		free(global_config_file);
 
 		if (rc)
 			die(_("unable to add '%s' value of '%s'"),
@@ -1612,18 +1611,18 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 
 	if (found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
+		char *global_config_file = NULL;
+
 		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
+			global_config_file = git_global_config();
+			config_file = global_config_file;
 		}
+		if (!config_file)
+			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, key, NULL, maintpath,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
-		free(user_config);
-		free(xdg_config);
+		free(global_config_file);
 
 		if (rc &&
 		    (!force || rc == CONFIG_NOTHING_SET))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 00d29871e65..0943dfa18a3 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -67,6 +67,51 @@ test_expect_success 'maintenance.auto config option' '
 	test_subcommand ! git maintenance run --auto --quiet  <false
 '
 
+test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
+	test_when_finished rm -r .config/git/config &&
+	(
+		XDG_CONFIG_HOME=.config &&
+		export XDG_CONFIG_HOME &&
+		mkdir -p $XDG_CONFIG_HOME/git &&
+		>$XDG_CONFIG_HOME/git/config &&
+		git maintenance register &&
+		git config --file=$XDG_CONFIG_HOME/git/config --get maintenance.repo >actual &&
+		pwd >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'register does not need XDG_CONFIG_HOME config to exist' '
+	test_when_finished git maintenance unregister &&
+	test_path_is_missing $XDG_CONFIG_HOME/git/config &&
+	git maintenance register &&
+	git config --global --get maintenance.repo >actual &&
+	pwd >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unregister uses XDG_CONFIG_HOME config if it exists' '
+	test_when_finished rm -r .config/git/config &&
+	(
+		XDG_CONFIG_HOME=.config &&
+		export XDG_CONFIG_HOME &&
+		mkdir -p $XDG_CONFIG_HOME/git &&
+		>$XDG_CONFIG_HOME/git/config &&
+		git maintenance register &&
+		git maintenance unregister &&
+		test_must_fail git config --file=$XDG_CONFIG_HOME/git/config --get maintenance.repo >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'unregister does not need XDG_CONFIG_HOME config to exist' '
+	test_path_is_missing $XDG_CONFIG_HOME/git/config &&
+	git maintenance register &&
+	git maintenance unregister &&
+	test_must_fail git config --global --get maintenance.repo >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-- 
2.43.0

