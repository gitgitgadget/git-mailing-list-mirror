Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3654207A
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401450; cv=none; b=NNJrGlLs92NWWYIlVnmSkAPhw1G7JjjbTUVzMBAGv4nunwqaHL5ZPsF8LW0EnzPaHamJSbcRuM7u4+mJNgeBIuAhiMmIodtBA+bTfQFYpMzeXEL+CknQGvPyxVegjT2pL3Z1o0RlnUKkO3SFjAYC6I0lqQYO9gQGFxs4FQa+8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401450; c=relaxed/simple;
	bh=qEsmgJM5oIytBWIXieovXfqhU8XFTIgLhAbJUPUyqgM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jkXP/xZrqmBDBXvX/vBXGNUfy+4g1y4ZE0Qc/3tTjRyruOeyfbVh3HgGrMG5QKNCJQ3/im96MlzlCOcAPykdaX+4pzU7B+NUena1liaQs596d7TCX3l1pb2hLtEI9QJZf03MhObeIvh286nw1pnUsXDS/3kQhmHQQGhrqHNxyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KKJiyRCt; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KKJiyRCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728401447; x=1728660647;
	bh=XkPAgR1iyf03vkhAxG/SQLR407LxpLQFYf3EpgJ4Mpc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KKJiyRCt39AntvUsg3YLcl/C3mvKm+VKZoW5MnGtnGWeYeXlYvSPpKqB2Y/x+FK27
	 qIoIsC0qEdb9m6KG2uNEqxymzeZZNy2pZx1RDymmTB9YsyzEgA/f7iZchUrQ/yiFyl
	 e5HZqniIo4dvH+TAKtHHS+qnmzfWCB13oXunKvUmnlLCJ1f3CiCU7iVO3F/a5WirTp
	 kd9MO/VnwGOytG6ISrPteHzwOYVJCme5UNnCXeajL70wJSwMAnjdw47Tnby4uMSuTW
	 fDStJ+/tl2w17TJlumH05Zeqqu4UfOO1Ju1JHqd8fO0f7T3azc1AOBA4UqJZmgzZWv
	 i23M92wSZsycA==
Date: Tue, 08 Oct 2024 15:30:42 +0000
To: ericsunshine@charter.net
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, russell+git.vger.kernel.org@stuart.id.au, sunshine@sunshineco.com, cdwhite3@pm.me
Subject: Re: [PATCH] worktree: repair copied repository and linked worktrees
Message-ID: <20241008153035.71178-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 5b5ca20afdd535a4d639ef382188c252c83b1fc8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------caf6c92498ed59a493a1ca497a224e898dae2f3c39b94d4ec876c21b2c4b5cb7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------caf6c92498ed59a493a1ca497a224e898dae2f3c39b94d4ec876c21b2c4b5cb7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: ericsunshine@charter.net
Cc: git@vger.kernel.org,
	russell+git.vger.kernel.org@stuart.id.au,
	sunshine@sunshineco.com,
	cdwhite3@pm.me
Subject: Re: [PATCH] worktree: repair copied repository and linked worktrees
Date: Tue,  8 Oct 2024 10:30:35 -0500
Message-ID: <20241008153035.71178-1-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240923075416.54289-1-ericsunshine@charter.net>
References: <20240923075416.54289-1-ericsunshine@charter.net>
MIME-Version: 1.0

Eric Sunshine <ericsunshine@charter.net> writes:

> +	inferred_backlink = infer_backlink(realdotgit.buf);
>  	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
>  	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
>  	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> -		if (!(backlink = infer_backlink(realdotgit.buf))) {
> +		if (inferred_backlink) {
> +			/*
> +			 * Worktree's .git file does not point at a repository
> +			 * but we found a .git/worktrees/<id> in this
> +			 * repository with the same <id> as recorded in the
> +			 * worktree's .git file so make the worktree point at
> +			 * the discovered .git/worktrees/<id>. (Note: backlink
> +			 * is already NULL, so no need to free it first.)
> +			 */
> +			backlink = inferred_backlink;
> +			inferred_backlink = NULL;
> +		} else {
>  			fn(1, realdotgit.buf, _("unable to locate reposito
ry; .git file does not reference a repository"), cb_data);
>  			goto done;
>  		}

Moving the `infer_backlink()` call outside of the error condition caused me to
discover a bug in my own refactor of infer_backlink() on my relative paths series.
Turns out I needed to clear the `inferred` path if an error occurred.
This is OK.

> +	/*
> +	 * If we got this far, either the worktree's .git file pointed at a
> +	 * valid repository (i.e. read_gitfile_gently() returned success) or
> +	 * the .git file did not point at a repository but we were able to
> +	 * infer a suitable new value for the .git file by locating a
> +	 * .git/worktrees/<id> in *this* repository corresponding to the <id>
> +	 * recorded in the worktree's .git file.
> +	 *
> +	 * However, if, at this point, inferred_backlink is non-NULL (i.e. we
> +	 * found a suitable .git/worktrees/<id> in *this* repository) *and* the
> +	 * worktree's .git file points at a valid repository *and* those two
> +	 * paths 
differ, then that indicates that the user probably *copied*
> +	 * the main and linked worktrees to a new location as a unit rather
> +	 * than *moving* them. Thus, the copied worktree's .git file actually
> +	 * points at the .git/worktrees/<id> in the *original* repository, not
> +	 * in the "copy" repository. In this case, point the "copy" worktree's
> +	 * .git file at the "copy" repository.
> +	 */
> +	if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
> +		free(backlink);
> +		backlink = inferred_backlink;
> +		inferred_backlink = NULL;
> +	}

This edge case seems to primarily be an artifact of using absolute paths to link
the worktrees. The test case you provided passes on my relative path series even
with this condition commented out. However, we do still want to support absolute
paths to maintain backwards compatibility so I think we should try to detect
this edge case if we can.

Unfortunately, this change now "repairs" (i.e., breaks) worktr
ees from other
repositories if the worktree_id happens to be identical between the repositories.
For example, the following test passes on `master` (with absolute paths) and on
my relative path series (relative paths without your changes integrated), but it
fails on your patch (and my relative patch series with your changes integrated):

    test_expect_success 'does not repair worktrees from another repo' '
        test_when_finished "rm -rf repo1 repo2" &&
        mkdir -p repo1 &&
        git -C repo1 init main &&
        test_commit -C repo1/main nothing &&
        git -C repo1/main worktree add ../linked &&
        cp repo1/main/.git/worktrees/linked/gitdir repo1/main.expect &&
        cp repo1/linked/.git repo1/linked.expect &&
        mkdir -p repo2 &&
        git -C repo2 init main &&
        test_commit -C repo2/main nothing &&
        git -C repo2/main worktree add ../linked &&
        cp repo2/main/.git/worktrees/linked/gitdir repo2/main.expect &&
        
cp repo2/linked/.git repo2/linked.expect &&
        git -C repo1/main worktree repair ../.. &&
        test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
        test_cmp repo1/linked.expect repo1/linked/.git &&
        test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
        test_cmp repo2/linked.expect repo2/linked/.git &&
        git -C repo2/main worktree repair ../../repo1/linked &&
        test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
        test_cmp repo1/linked.expect repo1/linked/.git &&
        test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
        test_cmp repo2/linked.expect repo2/linked/.git
    '

Granted, this is likely a rare edge case, but I would not expect trying to repair
a valid worktree from another repository to change the pointers. I think a good
solution to this would be to introduce a unique hash on the worktree_id when
creating a worktree to guarantee uniqu
eness across repositories, e.g.,:

    repo1/main/.git/worktrees/linked-6a4b5d/gitdir:
        /path/to/repo1/linked/.git
    repo1/linked/.git:
        gitdir: /path/to/repo1/main/worktrees/linked-6a4b5d

    repo2/main/.git/worktrees/linked-9ab26fe/gitdir:
        /path/to/repo2/linked/.git
    repo2/linked/.git:
        gitdir: /path/to/repo2/main/worktrees/linked-9ab26fe

This would allow us to detect this copied case while not "repairing" valid
worktrees from other repositories with the same linked worktree directory name.


Best,

- Caleb

--------caf6c92498ed59a493a1ca497a224e898dae2f3c39b94d4ec876c21b2c4b5cb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnBVAgCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAATAwf/RbZ1t51if2cXdqW+7IY3AzwVVCVF64zLD6TZqTXdKBeGvqey
8Mrle8JpB1H78Ln7IP/6rsbMM9jArteubavhwFo+3AH43L69noCYcITBtS/Z
iSfcpBEWHhv/SzImBgyOCimmQPgyAdgLb6IxwJ3/fMo4CkPi64nzFnu2olV7
tZ5nAKF84WmpFss/4WSBkWaLp/yj3frsmD7tlrhTkBpJ8PKYfokepUqoD1wr
yQSM+Z/kfoxz9YEUe8locLcoGB5NX4IqTvUqP3mV/E6CcUJUV9SaKTFl/x5Y
dsRA36m5OEAOcQRzDtA3Z4sbChm24b1MvtXjVsg+I4hucLZuKOpFTQ==
=k0WF
-----END PGP SIGNATURE-----


--------caf6c92498ed59a493a1ca497a224e898dae2f3c39b94d4ec876c21b2c4b5cb7--

