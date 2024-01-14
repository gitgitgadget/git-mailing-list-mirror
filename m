Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7813ACC
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="A9FwL8MX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmiDd6SO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B39FC5C00D9;
	Sun, 14 Jan 2024 16:44:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 14 Jan 2024 16:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1705268650; x=1705355050; bh=zdSnn5z3YMR3vu61CYa9E/zqR4eyt8Sy
	+BJaOJOFdtM=; b=A9FwL8MXHTHyPszWXzEqr/wcCYwN6bY+JV4GLignd2BpXVJU
	CuEynSiRfK4yRzQF2wapvSYpsZTDrZrGJLeVSqiRPng+PAhZN0uqxDvBlCXrLF63
	kDWAP/RF8Qbi8Ja6+iBioelmEnBpIJF6VlMfBR+iAY5d4WLRiTa6JbomYf2NR9za
	BtZEoND7pQZUSx20f2ffZOn3aY0ivtvXMj0/GIFQR9zngjfRcQvAEEUFXel5M00t
	7Ol2ndII+iGQNv1EEDf7WDpR2BxZWvTkbubVHPg7xLTqS+DSOqibdD/RcEDxBAVU
	6SDOl9uBAZ4C2NHjKUZWLnlfCO9YEDBduKQh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705268650; x=
	1705355050; bh=zdSnn5z3YMR3vu61CYa9E/zqR4eyt8Sy+BJaOJOFdtM=; b=q
	miDd6SOlcfZFZLK5W2H4j9/dI//pO/GzF//BGs7i40NyWcn9m8f/hOai+KOMh26i
	TFisK049tCbuUJpqjXgVuiVMQE5fHv2t8Wgu/81CJ/nH1K7S9o8OQSVjxp1s5SsI
	uhRwPPEP4KDSBiNoT/PlU+ZtvCL+tQIjY2HH2S94M3XY9uj4vzaH9vACBnsLRHNs
	zWIclbfv4ryjF+kzGJ13GH4DjNkiY5oSaxSqGgtsXcGumdHzPGyu3Sf0nis10YHO
	Gqg0XjHgLOGJ/S43Rh6nmpeeHPVY37l/PBtb2ybntG+cgY2onRMYsbyHgWF23DYQ
	Yv9uUdzJgVBpURJPJAnzA==
X-ME-Sender: <xms:qlWkZV9GzQm23MV4Q0yhY9ByIE05noPxceXF7nKn0f2BUmCqQFl20TM>
    <xme:qlWkZZtsKiNA7L3RpdndEqxJJswdm73s2ExJDfdLWlIJqjqFyg6QeifQ-4g0uTAcX
    9Oi5H27eoVvBOutdg>
X-ME-Received: <xmr:qlWkZTDY55Z3BBEycklSU6vc_KuCaQsKbw8EnU1-NGO-0Tz3NsadQk2GcnBxuq7sEGx4fKhXE29mqK2_jcRcJoBAUhlk0nVX-z0W8O0Med165WFtbbRaIn83xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuieeuffeuffethffhfeellefhueehteet
    tdehveegjeethefgveffuefggfelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:qlWkZZeYFb4nG5FoLPV2mnkey2B-eLQKemTjC-VFpJJweSosdaDD8Q>
    <xmx:qlWkZaNmwS-JeTG6_h_iKkIE-wE7SuZ_1JLUPBymXTi8kmZ1oMQ7zQ>
    <xmx:qlWkZbnBuZD0BvTubXN7E01C9yzCScZI49cAC-NXvdrtN524SxfnAQ>
    <xmx:qlWkZXrQieQTZIJZca5oCi426RiVULGnH5HGPktyXQqZZcMEmfs5ig>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 16:44:08 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/4] maintenance: use XDG config if it exists
Date: Sun, 14 Jan 2024 22:43:15 +0100
Message-ID: <cover.1705267839.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I use the conventional XDG config path for the global configuration. This
path is always used except for `git maintenance register` and
`unregister`.

§ Changes since v1

• Free `config_file`
  • https://lore.kernel.org/git/ZTZDsIcrB0zwHlFR@tanuki/
• Return `NULL` instead of dying
  • https://lore.kernel.org/git/ZTZDqToqcsDiS5AP@tanuki/
• Tests
  • Test unregister
  • Use subshells
  • Style

§ Patches

• 1–3: Preparatory
• 4: The desired change

§ CC

• Patrick Steinhardt: `config` changes; v1 feedback
• Derrick Stolee: `maintenance` changes
• Eric Sunshine: v1 feedback
• Taylor Blau: v1 feedback

Kristoffer Haugsbakk (4):
  config: format newlines
  config: rename global config function
  config: factor out global config file retrieval
  maintenance: use XDG config if it exists

 builtin/config.c       | 26 +++---------------------
 builtin/gc.c           | 27 ++++++++++++-------------
 builtin/var.c          |  2 +-
 config.c               | 26 ++++++++++++++++++++----
 config.h               |  6 +++++-
 t/t7900-maintenance.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 43 deletions(-)

Range-diff against v1:
1:  39934cb7e50 = 1:  d5f6c8d62ec config: format newlines
2:  48a5357f97c = 2:  cbc5fde0094 config: rename global config function
3:  147c767443c ! 3:  32e5ec7d866 config: factor out global config file retrieval
    @@ Commit message

         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    +
    + ## Notes (series) ##
    +    v2:
    +    • Don’t die; return `NULL`
    +
      ## builtin/config.c ##
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
      	}
    @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
     -			 * location; error out even if XDG_CONFIG_HOME
     -			 * is set and points at a sane location.
     -			 */
    --			die(_("$HOME not set"));
    --
     +		given_config_source.file = git_global_config();
    ++		if (!given_config_source.file)
    + 			die(_("$HOME not set"));
    +-
      		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
     -
     -		if (access_or_warn(user_config, R_OK, 0) &&
    @@ config.c: char *git_system_config(void)
     +	char *user_config, *xdg_config;
     +
     +	git_global_config_paths(&user_config, &xdg_config);
    -+	if (!user_config)
    -+		/*
    -+		 * It is unknown if HOME/.gitconfig exists, so
    -+		 * we do not know if we should write to XDG
    -+		 * location; error out even if XDG_CONFIG_HOME
    -+		 * is set and points at a sane location.
    -+		 */
    -+		die(_("$HOME not set"));
    ++	if (!user_config) {
    ++		free(xdg_config);
    ++		return NULL;
    ++	}
     +
     +	if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
     +	    !access_or_warn(xdg_config, R_OK, 0)) {
    @@ config.h: int config_error_nonbool(const char *);
      #endif

      char *git_system_config(void);
    ++/**
    ++ * Returns `NULL` if is uncertain whether or not `HOME/.gitconfig` exists.
    ++ */
     +char *git_global_config(void);
      void git_global_config_paths(char **user, char **xdg);

4:  1e2376a4b99 < -:  ----------- maintenance: use XDG config if it exists
-:  ----------- > 4:  8bd67c5bf01 maintenance: use XDG config if it exists
--
2.43.0
