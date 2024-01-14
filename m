Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064EA14293
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="kGjR1zKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9N2JUZx"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DCA295C0154;
	Sun, 14 Jan 2024 16:44:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 Jan 2024 16:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705268652; x=
	1705355052; bh=3PMwYZ3TK+aS0letAdpJMqPmC2YZhQB8Jz2gw+rBO/A=; b=k
	GjR1zKkbiKOcmZKryfI3zSGUnBnjkLmKshqDolCuF9nFSKEwZWp4ky8PkkXi4xxI
	WPME9WdxnIQT+6MJFEUPvWQvor8BmJDeEzFtr8cAcSieEn6ZgXT72xZlT7vzlJuV
	7P7/Wu92nEZbKbv+AMGD1lIRfwI5G8K+QfrzvcOGOyVlBgVVoUNO/tnEUyR7JVPz
	rehhEQ3+TdXAjY1gj1gpyA8GD2lbu5zByGFRq6ZOOMsSSSej7FVkKXk7aMCRxXFi
	tutkm4UUSRPUYPGL5Ta5U4VMQ0NNc7k/6Gl9xoh9+cPlPjZLGikLjdfONJrWeyhQ
	qI+YQ4R+VH78CJ3i1N0xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705268652; x=
	1705355052; bh=3PMwYZ3TK+aS0letAdpJMqPmC2YZhQB8Jz2gw+rBO/A=; b=C
	9N2JUZxWa8SGq9hZ7wty7k1YKKGAS34aZUFTWWFiB5YJVWSPGc9jRQ0CEJdmcQ2w
	moO8a2tGgmnI/PdfYwZQDA7H3z70UxtTX0ZoPVDjibAIOsqPh8vk0id4iG1qdK1B
	SZHwKXtLTHE7GFsYv8OcdAd3XGxR0YMz3uYORyYzyHCZG9sP4wRA/aWYEpTe200b
	3jYhD57nP+Kezn/n1tO7KovoXdzpT4tvtd/ObTSzJFeuAi9Y0hum9spRZLonXSK6
	bZBbTVD1Xvmh48Ayn1eAsZ/S2h32ehsuk9pBYcDByBeA10uobanVNnPEVymFmi8v
	q7VwkQMsJQVmV23RHphag==
X-ME-Sender: <xms:rFWkZUOnRi12rN-LClW8mIpD3nJ5y2-yIVHeylsFqsF6Z6hR-KEncqo>
    <xme:rFWkZa-FFVW7qeJtn_ZZFqpbXwNOophhWr2JvlQ9BufMFG2ntwC3QDg1eodNW61fn
    CQRcuYM5vTWO154aA>
X-ME-Received: <xmr:rFWkZbR9-YYxPL0Q0ivXv8y-HD3GaR9AP73UeiepMuZqq8xVhCk1VWZ_5DURhgS7hYB9fvLeZXtBOsI7vp13DtTrzMPSIk_NkKrBujf_VU-ldNcgTTs2ha4bBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteduieehgedutdfgudevkefhveduieeiteej
    hfffteeitdegjeeihedthfejgfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:rFWkZcup_d3C1g12mGvHYJzoA_CC0jL8HCkdlU0AwwJzpwXclUM-iA>
    <xmx:rFWkZcdx9Tg32XK_X7XQrLjfrNYE3qYp9SJOfQhIWJrlMHB97c8fiQ>
    <xmx:rFWkZQ3YFLuYIgwvd4MblMZtS6zebSN7abvYLrsvaUA3QesR2TqTaA>
    <xmx:rFWkZb6-RUO0ZzOHE7EEE-ucOXZ6_xbmXjQUYH_bKMZEzEj6ga_dUQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 16:44:10 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/4] config: format newlines
Date: Sun, 14 Jan 2024 22:43:16 +0100
Message-ID: <d5f6c8d62ecc21859bdfbdfa3a601d7778ed444c.1705267839.git.code@khaugsbakk.name>
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

Remove unneeded newlines according to `clang-format`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Honestly the formatter changing these lines over and over again was just
    annoying. And we're visiting the file anyway.

 builtin/config.c | 1 -
 config.c         | 2 --
 2 files changed, 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 11a4d4ef141..87d0dc92d99 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -760,7 +760,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
-
 	if (respect_includes_opt == -1)
 		config_options.respect_includes = !given_config_source.file;
 	else
diff --git a/config.c b/config.c
index 9ff6ae1cb90..d26e16e3ce3 100644
--- a/config.c
+++ b/config.c
@@ -95,7 +95,6 @@ static long config_file_ftell(struct config_source *conf)
 	return ftell(conf->u.file);
 }
 
-
 static int config_buf_fgetc(struct config_source *conf)
 {
 	if (conf->u.buf.pos < conf->u.buf.len)
@@ -3418,7 +3417,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 write_err_out:
 	ret = write_error(get_lock_file_path(&lock));
 	goto out_free;
-
 }
 
 void git_config_set_multivar_in_file(const char *config_filename,
-- 
2.43.0

