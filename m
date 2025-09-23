Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78504309F12
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662295; cv=none; b=nakwXnCuGvdSUIHO4gy5kOuCqlRD78x3s6jj1l/cTlsBVa4S4nNX5UgN1r5GtMx61CKlNbHfsze6ktQ/Mjp32QhS62PoYwDQU+DrDmE5W+QEkbv6O2P++WXl9GNp8AuAGgZJWrqWLe7lAspY6rCiPLxubfoK3tUqpoH9C20A/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662295; c=relaxed/simple;
	bh=vTjqp9j+6eL/xlw58MLD0ZaXNwjcmEhaWRTAczLd+tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOnx831RGt1w9u6vZb8gpDJ5f96EekJnR0w0uaYbv3TmfmBSiHWkVi3a88O5psskpi+uCweKZaPWYsOGtSeeQzBEfjvrFpIQ7xEStey28xGVgQO11O5I9w2RODTHmwGAO4sgWElGEWOevy129sC2j/cBe0IElOmBSVkiESwLZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=SuueWvDU; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="SuueWvDU"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id BE16F4C544
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 23:08:19 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:2e73:8277:125a:43a4])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 27117B0056A;
	Tue, 23 Sep 2025 23:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758661692;
	bh=vTjqp9j+6eL/xlw58MLD0ZaXNwjcmEhaWRTAczLd+tg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SuueWvDUhovO2hMS6QBWq4PnxqnAOaW0z38Xkz6eyHurVB5FDL0zXYBNcIjQHnWZ4
	 Hiq4SMag6GvAK4X9EaOp903y3seLzcC7xWN4zC+flxBfMMn1SJf393l+/6X0eXk5c2
	 rrVqNAztfFroZBPaKHqSHSDCnVgxUBymw+IOM7wEG9z0iLevsOhLqxVR0J8l2Ni/ZK
	 dbuStcHqf/ygGBlk6dNR3yLlJexuQAMAqOCQc1KtIGeVVer836TAG1z7iwxl4LiFvW
	 vRr2FXauhXXtFy9Wh7225hEEMbXiKrTcakYepnFwDIysUe8uIbSc/f1awacPuPdkt9
	 FbWwwcstCU3Gw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: doc: config/extensions.adoc: line continuation syntax error
Date: Tue, 23 Sep 2025 23:08:10 +0200
Message-ID: <6196161.lOV4Wx5bFT@cayenne>
In-Reply-To: <a6e4e995-fc19-465d-bd7a-c002bc0db31f@app.fastmail.com>
References: <a6e4e995-fc19-465d-bd7a-c002bc0db31f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 23 September 2025 20:34:00 CEST Kristoffer Haugsbakk wrote:
> Hi
>=20
> See the HTML output on e.g. latest `master` (ca2559c1 (The tenth batch,
> 2025-09-18)) for `git-config.adoc`:
>=20
>     + For historical reasons, this extension is respected regardless of t=
he
> core.repositoryFormatVersion setting.
>=20

At first, I could not see the same output. It seems to be again a discrepan=
cy=20
between asciidoc.py and asciidoctor. Only asciidoctor is producing this=20
output, and for me, it looks like a bug in asciidoctor.


> The context is a definition item `worktreeConfig` where this is the
> second paragraph following a bullet list.  So I thought maybe you can
> use:
>=20
>     --
>     <bullets>
>     --
>=20
> Here.  But we=E2=80=99re already inside a `--` block.  So apparently we c=
an=E2=80=99t do
> that.  I also tried a fair amount of permutations of using or not using
> line continuation in this context.
>=20
> This particular level of nesting seems tricky to resolve with Asciidoc.
> Maybe someone can figure it out.  So before I forget...
>=20
> Thanks
>=20
> (The Cc is because he is one of the Asciidoc experts as a FYI only)

Indeed, open blocks cannot be nested [1]. But, the first open block is not=
=20
necessary as it is a workaround for the missing knowledge of multi-level=20
definition lists.

[1]: https://docs.asciidoctor.org/asciidoc/latest/blocks/open-blocks/
#:~:text=3DIt%20allows%20you%20to%20apply,inside%20of%20another%20open%20bl=
ock.

Something along the following lines seems to work with asciidoctor while=20
preserving the original paragraph nesting:

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/
extensions.adoc
index 829f2523fc..556eda5d12 100644
=2D-- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -3,8 +3,7 @@ extensions.*::
 	`core.repositoryFormatVersion` is not `1`. See
 	linkgit:gitrepository-layout[5].
 +
=2D--
=2DcompatObjectFormat::
+compatObjectFormat:::
 	Specify a compatibility hash algorithm to use.  The acceptable=20
values
 	are `sha1` and `sha256`.  The value specified must be different from=20
the
 	value of `extensions.objectFormat`.  This allows client level
@@ -19,18 +18,18 @@ Note that the functionality enabled by this extension i=
s=20
incomplete and subject
 to change.  It currently exists only to allow development and testing of
 the underlying feature and is not designed to be enabled by end users.
=20
=2Dnoop::
+noop:::
 	This extension does not change git's behavior at all. It is useful=20
only
 	for testing format-1 compatibility.
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
=20
=2Dnoop-v1::
+noop-v1:::
 	This extension does not change git's behavior at all. It is useful=20
only
 	for testing format-1 compatibility.
=20
=2DobjectFormat::
+objectFormat:::
 	Specify the hash algorithm to use.  The acceptable values are=20
`sha1` and
 	`sha256`.  If not specified, `sha1` is assumed.
 +
@@ -38,7 +37,7 @@ Note that this setting should only be set by linkgit:git-
init[1] or
 linkgit:git-clone[1].  Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
=2DpartialClone::
+partialClone:::
 	When enabled, indicates that the repo was created with a partial=20
clone
 	(or later performed a partial fetch) and that the remote may have
 	omitted sending certain unwanted objects.  Such a remote is called=20
a
@@ -50,14 +49,14 @@ The value of this key is the name of the promisor remot=
e.
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
=20
=2DpreciousObjects::
+preciousObjects:::
 	If enabled, indicates that objects in the repository MUST NOT be=20
deleted
 	(e.g., by `git-prune` or `git repack -d`).
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
=20
=2DrefStorage::
+refStorage:::
 	Specify the ref storage format to use. The acceptable values are:
 +
 include::../ref-storage-format.adoc[]
@@ -67,13 +66,13 @@ Note that this setting should only be set by linkgit:gi=
t-
init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
=2DrelativeWorktrees::
+relativeWorktrees:::
 	If enabled, indicates at least one worktree has been linked with
 	relative paths. Automatically set if a worktree has been created or
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
=20
=2DworktreeConfig::
+worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
 	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
@@ -87,11 +86,12 @@ When enabling this extension, you must be careful to mo=
ve
 certain values from the common config file to the main working tree's
 `config.worktree` file, if present:
 +
+--
 * `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
   `$GIT_COMMON_DIR/config.worktree`.
 * If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/conf=
ig`
   to `$GIT_COMMON_DIR/config.worktree`.
=2D
+--
 +
 It may also be beneficial to adjust the locations of `core.sparseCheckout`
 and `core.sparseCheckoutCone` depending on your desire for customizable
@@ -104,4 +104,3 @@ details.
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
=2D--



