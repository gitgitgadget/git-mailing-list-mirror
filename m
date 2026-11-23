Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396454;
	b=pCb4JxAkyS08OGzcmsP1Cp+WeOclLdXTtJJJNaW4CCYtSgrOSQ20F6+wHoWyhxExWVrr
	 8NboDAUKJiu7VQJ8rD//VMBFyBYt+AlvSvHfL9GhDurBvVkGL/u4DuR9oKIw8QJNMdl8r
	 cnw9t1Y4RBL8V8v0ScqomXIuJz6SSQZoNNjHy4+y8csbm1oIS1PpzbA+MF0fRqrVDx+2P
	 4Doh1VDzo3bxw5l4+B0UAO8BZWpP/nPsJic/a2dHtO0l2S5Oi1/9OwyHXGZQQfBwBR5/a
	 WvanEKOObbuAp3zcwbVhLE1AShcNmSPXOuA+Kgcb6Fi/SARfv1MGdy3LzhXiDqwZ6YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396454;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0GJ83d/5kXGO1iYiWC01Ys3i4WqduYOCOM1uCbrHlvY=;
	b=jiZU0tAPhy6VpFIBmktwQCTkqM0I60jc6k3GAR5qcbsobLknD7FApFz332NKRU0kd+9p
	 SCyoXmjE+3HueJqK9sZg3MpKcT5ngJVLXBHlSPyz3uyy3jGmuM/9EAI6fvmzOv3v9YplG
	 A6Wc3eboeJSSMZDZcQdKNb2zaAjbEpuCT9jXYTqVwklmMLf3kRAHZdKfNCneQV+V2ZPCz
	 TLCxSKQ4JKSonvXdj1YrkUEsZl4ENKYj728/5UAVBxdViSl1ZVZCKvE4+7ekWw7ZGypM7
	 f1Wpm5aakJCCRp9C95zyOvTmyxFhEjv3Al68TmNgo1B9K/Kxfb6ljghG9N2nBHSPUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=Kf2iveUK;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22983606A331
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22983606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=Kf2iveUK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795396447;
	bh=u2qh7mojGwxH6KjdBJ8mwYNqq57rYzmAladd0U3D6a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Kf2iveUKv+Au9Z4Bbd71u0XvkOg5n8OLxM9dS9Hgx9iiW9E8CZymVpWAIvQfxxrYO
	 a5HB27BhaZdb8/9SLsmSdyGbuAcpjy+s4f6Oi2ql+sEMDg8Fafsz9mTZE60DZWnXEI
	 A9Osj4vy9L6og13kshnOSq7OH3K6/K5rIqKchIZk8lazmoqhgJpGsmvCcliVd4MGDY
	 S+tGVQuOjzzPxNCOAmPlWFdfz9ZpwdjkhtS4imfaTZYc5jeeULgkx3SJWtiCHb66mg
	 RW8Kv8OFojKdBj4yYAeQ7VDjXQpttWa8X8YGsAls3hEYFhyTAYiwTLe6Ct4ISww9eg
	 YC9jvRHh1mPbFxE24btmAa1XxzXLr7r/R7nyurYhbBjade5YNcNb0aYxK3fC/fephp
	 KNfv81Z/r9LuLZQwDBIMLoDbrx99KxnuANVQqgyoloypvUpcfZ343v0Vw6GwTKpmtJ
	 4iXv9fYlRJITsMAD/PaR7KAxdLo85UkKmjLGCjOmtLPeVkfxwdj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d948:43c9:4db6:a02a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 00EF5200AA;
	Mon, 23 Nov 2026 01:14:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH v4] setup: fix hash algorithm detection
Date: Mon, 23 Nov 2026 01:14:03 +0000
Message-ID: <20261123011403.720209-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our current hash algorithm selection code has a few different problems.
First, we do not actually default to GIT_HASH_DEFAULT because, due to a
bug, our code has never considered GIT_HASH_DEFAULT as a default for git
init and if an algorithm is not specified in the config file, we assume
that the repository is SHA-1.

Second, if we have an algorithm chosen by init.defaultObjectFormat and
we re-init a repository, we will change the hash algorithm, which is
very much not desired.

To fix this, let's restructure this code slightly.  First, if an
algorithm was selected on the command line, assume that's what the user
wanted. Otherwise, the other options should only be chosen if our
repository doesn't exist (that is, repo_fmt->version is -1) or it's
specifically detected as having no hash algorithm.  This latter case
should not occur, but we preserve it just in case.  In those cases,
first use the environment, then the config, and finally, the default
algorithm.

Then, if the algorithm does not match the repository, complain loudly
and refuse to reinitialize the repository with a different hash
algorithm.

With this change, we will choose SHA-256 in breaking changes mode and in
Git 3.0, which is what we want.  Add several tests to cover this case
and several others discovered along the way.  Update the comment to
better describe the situation.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v3:
* Update commit message.
* Update comment.
* Place `sane_unset` in subshells.

 setup.c         | 32 ++++++++++++++++-----------
 t/t0001-init.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index cedc031c54..c2a56b997a 100644
--- a/setup.c
+++ b/setup.c
@@ -2888,24 +2888,29 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
 
 	/*
-	 * If we already have an initialized repo, don't allow the user to
-	 * specify a different algorithm, as that could cause corruption.
-	 * Otherwise, if the user has specified one on the command line, use it.
+	 * If the user specified a hash algorithm on the command line, then use
+	 * that.  Otherwise, if the repository exists, use that algorithm; if
+	 * not, choose the environment variable or config option in that order,
+	 * and then fall back to the default.
+	 *
+	 * If the repository is already initialized and we pick a different
+	 * algorithm than the current one, we will reject that below.
 	 */
 	env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
-	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
-		die(_("attempt to reinitialize repository with different hash"));
-	else if (hash != GIT_HASH_UNKNOWN)
-		repo_fmt->hash_algo = hash;
-	else if (env) {
+	if (hash != GIT_HASH_UNKNOWN) {
+		/* nothing to do */
+	} else if (repo_fmt->version >= 0 &&
+		   repo_fmt->hash_algo != GIT_HASH_UNKNOWN) {
+		hash = repo_fmt->hash_algo;
+	} else if (env) {
 		int env_algo = hash_algo_by_name(env);
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
-		if (repo_fmt->version < 0 ||
-		    repo_fmt->hash_algo == GIT_HASH_UNKNOWN)
-			repo_fmt->hash_algo = env_algo;
+		hash = env_algo;
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
-		repo_fmt->hash_algo = cfg.hash;
+		hash = cfg.hash;
+	} else {
+		hash = GIT_HASH_DEFAULT;
 	}
 
 	/*
@@ -3022,6 +3027,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * current storage formats do not change.
 	 */
 	if (repo_fmt->version >= 0) {
+		if (hash != repo_fmt->hash_algo)
+			die(_("attempt to reinitialize repository with different hash"));
 		if (ref_storage_format != repo_fmt->ref_storage_format)
 			die(_("attempt to reinitialize repository with different reference storage format"));
 		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
@@ -3038,6 +3045,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 
 	free(cfg.ref_storage_payload);
 	free(repo_fmt->ref_storage_payload);
+	repo_fmt->hash_algo = hash;
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9e57a06cea..d4bbe72db3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -516,6 +516,17 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success 'git init uses default object format' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init repo &&
+		echo "$GIT_TEST_BUILTIN_HASH" >expect &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
 	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
@@ -602,6 +613,52 @@ do
 	'
 done
 
+test_expect_success 'init refuses to reinitialize with different hash' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		for algo in sha1 sha256
+		do
+			if test "$algo" = sha1
+			then
+				other=sha256
+			else
+				other=sha1
+			fi &&
+			git init --object-format="$algo" repo &&
+			cat >expect <<-EOF &&
+			fatal: attempt to reinitialize repository with different hash
+			EOF
+			test_must_fail git init --object-format="$other" repo 2>err &&
+			test_cmp expect err &&
+			rm -fr repo || exit 1
+		done
+	)
+'
+
+test_expect_success 're-init does not modify hash from config' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		for algo in sha1 sha256
+		do
+			if test "$algo" = sha1
+			then
+				other=sha256
+			else
+				other=sha1
+			fi &&
+			git init --object-format="$algo" repo &&
+			test_config_global init.defaultObjectFormat "$other" &&
+			git init repo &&
+			echo "$algo" >expect &&
+			git -C repo rev-parse --show-object-format >actual &&
+			test_cmp expect actual &&
+			rm -fr repo || exit 1
+		done
+	)
+'
+
 test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
 	test_when_finished "rm -rf explicit-v0" &&
 	git init --object-format=sha256 explicit-v0 &&
