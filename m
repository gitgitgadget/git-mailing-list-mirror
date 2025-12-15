Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AA2750E6
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802019; cv=none; b=CQn+ciVOPNe8WYOALMwjnKkTkMI515JeHpZz6PxWzz5p1KOFdFXQ4ew2vgtMEYTLQGpXBpgpqm6Ou+MVKOlYnJqkpDTIuymce3w29ne50ySkkxlJVGMeZGnueF2N94suziOofJc/Lbw1dsAXSUqLzkmvXyJ9O9+HRVFgaj2E0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802019; c=relaxed/simple;
	bh=Zmq7/4BMKkJ1Cre6nj9uN/3cvLvCWIxhiu88oDelXO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DK7uUhkYxmTZn4GTWlukflY25b2z8vQlcjmQYhCLx0yT6KeelJRWmhPQEGoHY0dQp27g8TZLs3dIvR29jWlE+/6nEROvt4VY+nNAd6PYggjF7TGOsguuuI4b4/L8M5g+Kr+UwHGAnHTnWlzCrJ4yQ9Jpu3rl3hFpAtvr5bYsl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dvaraLDu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dvaraLDu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=udao/aueEFy6xPgOdFNPlw/fNhBPGkQmTNuoJImzNSA=; b=dvaraLDu4MbAK0N/L1QcexQ9dl
	eSzMrX72BubRXGxEz8i5+KbOmnXGzdz9KnHwPZ/ZLb0RHemAGXeRKt4naTH1WU70G4QQNSX8kY1zu
	si4V9NWQ9ExpjsNUyv8cFv9B4UieIGYrSkCMoEGOuJEHSh7Xglq7lmSip7geNb4VJEPsxYkCO5K/9
	lubZ43NHc14BMRyvnIuxxstcwPSjgbEW60MxF+v3sgBK5+OlT0wrxaA45JI66ZW4TIWwaOBfwF7pj
	V84+OlERmt+cbgC1sbgdsfs3uN9AOdy85mrQIrnmUmM1t6+0z3LXaLIAB+pmwHJ8kYTQ9nprondby
	PTfn6lIg==;
Received: from [91.117.33.88] (helo=[192.168.1.137])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vV7le-00CwCV-93; Mon, 15 Dec 2025 13:33:34 +0100
Message-ID: <9b770540-6791-41e2-9548-48b42c7f644b@igalia.com>
Date: Mon, 15 Dec 2025 13:33:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] scalar: document config settings
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, johannes.schindelin@gmx.de,
 Matthew Hughes <matthewhughes934@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
 <f062b0e0773b9d168c031bb1f35538665394a077.1765552528.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Henrique Ferreiro <hferreiro@igalia.com>
In-Reply-To: <f062b0e0773b9d168c031bb1f35538665394a077.1765552528.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/25 4:15 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Add user-facing documentation that justifies the values being set by
> 'scalar clone', 'scalar register', and 'scalar reconfigure'.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/scalar.adoc | 164 ++++++++++++++++++++++++++++++++++++++
>   scalar.c                  |   4 +
>   2 files changed, 168 insertions(+)
> 
> diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
> index f81b2832f8..ee9fc0ac0c 100644
> --- a/Documentation/scalar.adoc
> +++ b/Documentation/scalar.adoc
> @@ -197,6 +197,170 @@ delete <enlistment>::
>   	This subcommand lets you delete an existing Scalar enlistment from your
>   	local file system, unregistering the repository.
>   
> +RECOMMENDED CONFIG VALUES
> +-------------------------
> +
> +As part of both `scalar clone` and `scalar register`, certain Git config
> +values are set to optimize for large repositories or cross-platform support.
> +These options are updated in new Git versions according to the best known
> +advice for large repositories, and users can get the latest recommendations
> +by running `scalar reconfigure [--all]`.
> +
> +This section lists justifications for the config values that are set in the
> +latest version.
> +
> +am.keepCR=true::
> +	This setting is important for cross-platform development across Windows
> +	and non-Windows platforms and keeping carriage return (`\r`) characters
> +	in certain workflows.
> +
> +commitGraph.changedPaths=true::
> +	This setting helps the background maintenance steps that compute the
> +	serialized commit-graph to also store changed-path Bloom filters. This
> +	accelerates file history commands and allows users to automatically
> +	benefit without running a foreground command.
> +
> +commitGraph.generationVersion=1::
> +	While the preferred version is 2 for performance reasons, existing users
> +	that had version 1 by default will need special care in upgrading to
> +	version 2. This is likely to change in the future as the upgrade story
> +	solidifies.

I missed this in a previous email. Given the above reasoning, wouldn't
it make more sense to check for a previous value of 1, instead of
forcing 1 also on new enlistments?

> +core.autoCRLF=false::
> +	This removes the transformation of worktree files to add CRLF line
> +	endings when only LF line endings exist. This is removed for performance
> +	reasons. Repositories that use tools that care about CRLF line endings
> +	should commit the necessary files with those line endings instead.
> +
> +core.logAllRefUpdates=true::
> +	This enables the reflog on all branches. While this is a performance
> +	cost for large repositories, it is frequently an important data source
> +	for users to get out of bad situations or to seek support from experts.
> +
> +core.safeCRLF=false::
> +	Similar to `core.autoCRLF=false`, this disables checks around whether
> +	the CRLF conversion is reversible. This is a performance improvement,
> +	but can be dangerous if `core.autoCRLF` is reenabled by the user.
> +
> +credential.https://dev.azure.com.useHttpPath=true::
> +	This setting enables the `credential.useHttpPath` feature only for web
> +	URLs for Azure DevOps. This is important for users interacting with that
> +	service using multiple organizations and thus multiple credential
> +	tokens.
> +
> +feature.experimental=false::
> +	This disables the "experimental" optimizations grouped under this
> +	feature config. The expectation is that all valuable optimizations are
> +	also set explicitly by Scalar config, and any differences are
> +	intentional. Notable differences include several bitmap-related config
> +	options which are disabled for client-focused Scalar repos.
> +
> +feature.manyFiles=false::
> +	This disables the "many files" optimizations grouped under this feature
> +	config. The expectation is that all valuable optimizations are also set
> +	explicitly by Scalar config, and any differences are intentional.
> +
> +fetch.showForcedUpdates=false::
> +	This disables the check at the end of `git fetch` that notifies the user
> +	if the ref update was a forced update (one where the previous position
> +	is not reachable from the latest position). This check can be very
> +	expensive in large repositories, so is disabled and replaced with an
> +	advice message. Set `advice.fetchShowForcedUpdates=false` to disable
> +	this advice message.
> +
> +fetch.unpackLimit=1::
> +	This setting prevents Git from unpacking packfiles into loose objects
> +	as they are downloaded from the server. The default limit of 100 was
> +	intended as a way to prevent performance issues from too many packfiles,
> +	but Scalar uses background maintenance to group packfiles and cover them
> +	with a multi-pack-index, removing this issue.
> +
> +fetch.writeCommitGraph=false::
> +	This config setting was created to help users automatically update their
> +	commit-graph files as they perform fetches. However, this takes time
> +	from foreground fetches and pulls and Scalar uses background maintenance
> +	for this function instead.
> +
> +gc.auto=0::
> +	This disables automatic garbage collection, since Scalar uses background
> +	maintenance to keep the repository data in good shape.
> +
> +gui.GCWarning=false::
> +	Since Scalar disables garbage collection by setting `gc.auto=0`, the
> +	`git-gui` tool may start to warn about this setting. Disable this
> +	warning as Scalar's background maintenance configuration makes the
> +	warning irrelevant.
> +
> +index.skipHash=true::
> +	Disable computing the hash of the index contents as it is being written.
> +	This assists with performance, especially for large index files.
> +
> +index.threads=true::
> +	This tells Git to automatically detect how many threads it should use
> +	when reading the index due the default value of	`core.preloadIndex`,
> +	which enables parallel index reads. This explicit setting also enables
> +	`index.recordOffsetTable=true` to speed up parallel index reads.

A quick look at preload-index.c doesn't show any references to reading 
index.threads but I might have missed it. On the other hand, it looks 
like index.recordEndOfIndexEntries is also affected by index.threads, so 
it might be worth explicitly mentioning it.

> +index.version=4::
> +	This index version adds compression to the path names, reducing the size
> +	of the index in a significant way for large repos. This is an important
> +	performance boost.
> +
> +log.excludeDecoration=refs/prefetch/*::
> +	Since Scalar enables background maintenance with the `incremental`
> +	strategy, this setting avoids polluting `git log` output with refs
> +	stored by the background prefetch operations.
> +
> +merge.renames=true::
> +	When computing merges in large repos, it is particularly important to
> +	detect renames to maximize the potential for a result that will validate
> +	correctly. Users performing merges locally are more likely to be doing
> +	so because a server-side merge (via pull request or similar) resulted in
> +	conflicts. While this is the default setting, it is set specifically to
> +	override a potential change to `diff.renames` which a user may set for
> +	performance reasons.
> +
> +merge.stat=false::
> +	This disables a diff output after computing a merge. This improves
> +	performance of `git merge` for large repos while reducing noisy output.
> +
> +pack.useBitmaps=false::
> +	This disables the use of `.bitmap` files attached to packfiles. Bitmap
> +	files are optimized for server-side use, not client-side use. Scalar
> +	disables this to avoid some performance issues that can occur if a user
> +	accidentally creates `.bitmap` files.
> +
> +pack.usePathWalk=true::
> +	This enables the `--path-walk` option to `git pack-objects` by default.
> +	This can accelerate the computation and compression of packfiles created
> +	by `git push` and other repack operations.
> +
> +receive.autoGC=false::
> +	Similar to `gc.auto`, this setting is disabled in preference of
> +	background maintenance.
> +
> +status.aheadBehind=false::
> +	This disables the ahead/behind calculation that would normally happen
> +	during a `git status` command. This information is frequently ignored by
> +	users but can be expensive to calculate in large repos that receive
> +	thousands of commits per day. The calculation is replaced with an advice
> +	message that can be disabled by disabling the `advice.statusAheadBehind`
> +	config.
> +
> +The following settings are different based on which platform is in use:
> +
> +core.untrackedCache=(true|false)::
> +	The untracked cache feature is important for performance benefits on
> +	large repositories, but has demonstrated some bugs on Windows
> +	filesystems. Thus, this is set for other platforms but disabled on
> +	Windows.
> +
> +http.sslBackend=schannel::
> +	On Windows, the `openssl` backend has some issues with certain types of
> +	remote providers and certificate types. Override the default setting to
> +	avoid these common problems.
> +
> +
>   SEE ALSO
>   --------
>   linkgit:git-clone[1], linkgit:git-maintenance[1].
> diff --git a/scalar.c b/scalar.c
> index 3b25fd3f35..21ab1dba89 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -132,6 +132,10 @@ static int have_fsmonitor_support(void)
>   
>   static int set_recommended_config(int reconfigure)
>   {
> +	/*
> +	 * Be sure to update Documentation/scalar.adoc if you add, update,
> +	 * or remove any of these recommended settings.
> +	 */
>   	struct scalar_config config[] = {
>   		{ "am.keepCR", "true" },
>   		{ "commitGraph.changedPaths", "true" },

