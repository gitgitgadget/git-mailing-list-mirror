From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix spelling mistakes
Date: Sun, 03 Apr 2016 11:16:35 -0700
Message-ID: <xmqqbn5qfth8.fsf@gitster.mtv.corp.google.com>
References: <1459688165-8720-1-git-send-email-eric@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
X-From: git-owner@vger.kernel.org Sun Apr 03 20:16:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ammZm-0004QH-Rq
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 20:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbcDCSQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 14:16:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753862AbcDCSQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 14:16:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16ECE526C6;
	Sun,  3 Apr 2016 14:16:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fcyrfG053UGw/DcMvtdoUeaLH08=; b=PTPdeh
	wD8PEx6wxHnCqMpDw+2uFO1hhB/PSaj7VzyiLpD9OTB/pF5bf9vIVz7vbI9s/SHG
	pZni0GYEKbmhUvJH9fP55+ZNkJh0dIAUSyqG3/1M4EN6BZAAv7J6ElEanOMbQ99T
	KOclhkjfDnl7d97yK0gKBUJtI29BJhvM87p3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJzqWzSI81kMvyG0qQBPRO+6t/na7N7N
	hSmfpmSjbjvXw2RggHObuYX4X0Tn7liYdXZLvJ7KSJqg5Lzr9W6XTeav6vBy2NHN
	+kaf/90214BqtdI5VHSDHR38HaWC7Rdmyoot9I5/5MHrqUW6soxTbXQORi5Ccujh
	xt9ESVNN7cg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DFD2526C5;
	Sun,  3 Apr 2016 14:16:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D528526C4;
	Sun,  3 Apr 2016 14:16:36 -0400 (EDT)
In-Reply-To: <1459688165-8720-1-git-send-email-eric@engestrom.ch> (Eric
	Engestrom's message of "Sun, 3 Apr 2016 13:56:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33ECE082-F9C8-11E5-A728-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290644>

Eric Engestrom <eric@engestrom.ch> writes:

> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---

While I think "through" is not wrong, I do not think it is worth the
patch churn to do s/thru/through/;

If the original author wants to spell the word "thru", we are in no
position to say it must be spelled "through" [*1*].  It's a bit
different from correcting a non-word "usefull" to "useful".  The
only "Huh?"  I saw around "thru" in this patch was that these said
"fall thru" while I am fairly sure there are many places that say
"fallthru", which is fairly common way to say that word in comments.

Other changes looked all sensible.

Thanks for going through the codebase with a fine-toothed comb.

[Footnote]

*1* http://www.merriam-webster.com/words-at-play/how-thru-turned-into-through
and http://grammarist.com/spelling/through-thru/ were amusing reads.

>  builtin/apply.c                    | 2 +-
>  builtin/clean.c                    | 2 +-
>  config.c                           | 2 +-
>  contrib/examples/git-am.sh         | 2 +-
>  contrib/hooks/multimail/README     | 2 +-
>  contrib/subtree/t/t7900-subtree.sh | 2 +-
>  diff.c                             | 2 +-
>  dir.c                              | 2 +-
>  git-p4.py                          | 2 +-
>  refs.h                             | 2 +-
>  sha1-lookup.c                      | 2 +-
>  t/t5535-fetch-push-symref.sh       | 2 +-
>  t/t6030-bisect-porcelain.sh        | 2 +-
>  worktree.c                         | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index deb05d0..02a0259 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3980,7 +3980,7 @@ static void show_rename_copy(struct patch *p)
>  		old = slash_old + 1;
>  		new = slash_new + 1;
>  	}
> -	/* p->old_name thru old is the common prefix, and old and new
> +	/* p->old_name through old is the common prefix, and old and new
>  	 * through the end of names are renames
>  	 */
>  	if (old != p->old_name)
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 0371010..5426f9f 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -192,7 +192,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  		strbuf_setlen(path, len);
>  		strbuf_addstr(path, e->d_name);
>  		if (lstat(path->buf, &st))
> -			; /* fall thru */
> +			; /* fall through */
>  		else if (S_ISDIR(st.st_mode)) {
>  			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
>  				ret = 1;
> diff --git a/config.c b/config.c
> index 9ba40bc..482ef2e 100644
> --- a/config.c
> +++ b/config.c
> @@ -1278,7 +1278,7 @@ static void git_config_raw(config_fn_t fn, void *data)
>  		 * something went really wrong and we should stop
>  		 * immediately.
>  		 */
> -		die(_("unknown error occured while reading the configuration files"));
> +		die(_("unknown error occurred while reading the configuration files"));
>  }
>  
>  static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
> diff --git a/contrib/examples/git-am.sh b/contrib/examples/git-am.sh
> index dd539f1..b3d30b7 100755
> --- a/contrib/examples/git-am.sh
> +++ b/contrib/examples/git-am.sh
> @@ -542,7 +542,7 @@ then
>  	rm -f "$dotest/dirtyindex"
>  else
>  	# Possible stray $dotest directory in the independent-run
> -	# case; in the --rebasing case, it is upto the caller
> +	# case; in the --rebasing case, it is up to the caller
>  	# (git-rebase--am) to take care of stray directories.
>  	if test -d "$dotest" && test -z "$rebasing"
>  	then
> diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
> index 5512068..80df811 100644
> --- a/contrib/hooks/multimail/README
> +++ b/contrib/hooks/multimail/README
> @@ -489,7 +489,7 @@ multimailhook.commitLogOpts
>  multimailhook.dateSubstitute
>  
>      String to use as a substitute for ``Date:`` in the output of ``git
> -    log`` while formatting commit messages. This is usefull to avoid
> +    log`` while formatting commit messages. This is useful to avoid
>      emitting a line that can be interpreted by mailers as the start of
>      a cited message (Zimbra webmail in particular). Defaults to
>      ``CommitDate: ``. Set to an empty string or ``none`` to deactivate
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 3bf96a9..0cf044c 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -932,7 +932,7 @@ test_expect_success 'split a new subtree without --onto option' '
>  
>  		# also test that we still can split out an entirely new subtree
>  		# if the parent of the first commit in the tree is not empty,
> -		# then the new subtree has accidently been attached to something
> +		# then the new subtree has accidentally been attached to something
>  		git subtree split --prefix="sub dir2" --branch subproj2-br &&
>  		check_equal "$(git log --pretty=format:%P -1 subproj2-br)" ""
>  	)
> diff --git a/diff.c b/diff.c
> index 059123c..3d8b3e5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2084,7 +2084,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
>  	for (cnt = 1; cnt < marker_size; cnt++)
>  		if (line[cnt] != firstchar)
>  			return 0;
> -	/* line[1] thru line[marker_size-1] are same as firstchar */
> +	/* line[1] through line[marker_size-1] are same as firstchar */
>  	if (len < marker_size + 1 || !isspace(line[marker_size]))
>  		return 0;
>  	return 1;
> diff --git a/dir.c b/dir.c
> index a4a9d9f..57892a5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2166,7 +2166,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  				 * wanted anyway
>  				 */
>  				continue;
> -			/* fall thru */
> +			/* fall through */
>  		} else if (S_ISDIR(st.st_mode)) {
>  			if (!remove_dir_recurse(path, flag, &kept_down))
>  				continue; /* happy */
> diff --git a/git-p4.py b/git-p4.py
> index 825b9f3..4f577e2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1918,7 +1918,7 @@ def run(self, args):
>          if self.useClientSpec:
>              self.clientSpecDirs = getClientSpec()
>  
> -        # Check for the existance of P4 branches
> +        # Check for the existence of P4 branches
>          branchesDetected = (len(p4BranchesInGit().keys()) > 1)
>  
>          if self.useClientSpec and not branchesDetected:
> diff --git a/refs.h b/refs.h
> index 2f3decb..fad6281 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -336,7 +336,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   *     msg -- a message describing the change (for the reflog).
>   *
>   *     err -- a strbuf for receiving a description of any error that
> - *         might have occured.
> + *         might have occurred.
>   *
>   * The functions make internal copies of refname and msg, so the
>   * caller retains ownership of these parameters.
> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index 5f06921..552582f 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -199,7 +199,7 @@ int sha1_entry_pos(const void *table,
>  					break;
>  			ofs_0 = ofs;
>  			/*
> -			 * byte 0 thru (ofs-1) are the same between
> +			 * byte 0 through (ofs-1) are the same between
>  			 * lo and hi; ofs is the first byte that is
>  			 * different.
>  			 *
> diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
> index 8ed58d2..e8f6d23 100755
> --- a/t/t5535-fetch-push-symref.sh
> +++ b/t/t5535-fetch-push-symref.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='avoiding conflicting update thru symref aliasing'
> +test_description='avoiding conflicting update through symref aliasing'
>  
>  . ./test-lib.sh
>  
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index e74662b..a1b02b3 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -721,7 +721,7 @@ git bisect good 3de952f2416b6084f557ec417709eac740c6818c
>  # first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
>  EOF
>  
> -test_expect_success 'bisect log: successfull result' '
> +test_expect_success 'bisect log: successful result' '
>  	git bisect reset &&
>  	git bisect start $HASH4 $HASH2 &&
>  	git bisect good &&
> diff --git a/worktree.c b/worktree.c
> index 6181a66..89ebe67 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -18,7 +18,7 @@ void free_worktrees(struct worktree **worktrees)
>  
>  /*
>   * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
> - * set is_detached to 1 (0) if the ref is detatched (is not detached).
> + * set is_detached to 1 (0) if the ref is detached (is not detached).
>   *
>   * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
>   * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
