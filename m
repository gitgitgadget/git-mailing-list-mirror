Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80674486406
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206918; cv=none; b=bwzEPrEpPEJJVgS10VgSVrXAnQrjaYoWHAAp36ePrIoIFYjFDYy/b7oZUNAQgz7dYhkdLB187PzHk8fN1DatuhIpA5fF1521KczC7AHePxLUKk5zBqsHtKBvxPSw0kLGy3j+3fY2+SMV6FkQTWWSXk8nv12cknD6tpIsvhFhu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206918; c=relaxed/simple;
	bh=GeQWMlhUCIYev/xownz0oeLTixlLqhUfdDBVW7ibiLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6PQ+fTg8b4ww/J/Ju1/Ya4/VBzfgQNxJgYHTi2+GNU4FDkZxcFt6bfeGUBPF4l5Y6M/TK2sxurfekirmlcvHpMiJyx4Wnl6Aj36jjBxTvrUjhyBfM6BM6TAkT8eOsI0UrrQt0DfKwkwwLEkGTX2l3VzB8jTmu1PLIqqct2D6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpS2DbB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpS2DbB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E653F1F00893;
	Mon,  5 Oct 2026 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206908;
	bh=N7zAXDqwWfZkSx8tqw6Rw6QWAanVnBkgHucgyrmzgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EpS2DbB8KP+v6ukAFN+3bb1k9AF9U4LiL+27oGRT+26Q6C78W/BLwI3g/Y3OX3MOv
	 9aqSjV8TSlXSET0GG3joDg/dsxH0D6h79qQ91QT++eZ2FlfaCfvDABC9kldgnYLybe
	 g/uQPTpKQ7rcNmmNXSkWxb9bROmR+qriqdYJUDrRrF+pGQ9FgJuUwj1zrP7uIZNvSV
	 ZQ9pB4/q41VUGpNDzo0KEH5rIWMmrhFOaOaqkjxwCtWH475+7JVtJh2RmvRsReStPa
	 vfORt5W2qU8Lk58bD47Gy8fn46aLxpawJyWiC30OgTUunNPZNtILzyq/lEwbLm8PxB
	 JgEiEj23KEHvw==
Date: Mon, 5 Oct 2026 15:28:21 +0200
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asOaLyiJUmINFFFH@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndydnequjpg3k43h"
Content-Disposition: inline
In-Reply-To: <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>


--ndydnequjpg3k43h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asOaLyiJUmINFFFH@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>

Hi Phillip,

> Date: 2026-10-04 11:03:39+0100
> From: Phillip Wood <phillip.wood123@gmail.com>
>
> On 02/10/2026 07:46, Patrick Steinhardt wrote:
> > On Thu, Oct 01, 2026 at 05:51:58PM +0200, Alejandro Colomar wrote:
> > >=20
> > > My script I use it in shadow-utils and in the Linux man-pages project,
> > > and is in use today.  I was wondering if there was interest in
> > > integrating it to git(1).
> >=20
> > I guess the answer is "maybe". The fact that multiple folks have solved
> > similar issues over the course of many years is an indicator that the
> > funcitonality may be more generally useful. But it probably shouldn't be
> > a separate script, so if we wanted to integrate it I'd think the best
> > way forward would be to integrate it into git-rebase(1) directly.
>=20
> I agree that would be the best way forward. Adding an "--incremental", or
> "--progressive" option to rebase would be useful I think. For ease of use=
, I
> have a strong preference for an implementation where "rebase --continue"
> handles rebasing onto progressively more recent bases, rather than the mu=
lti
> shot approach where the user has to run "git rebase --incremental" multip=
le
> times. Having a multi-shot approach makes it much less clear when we've
> successfully rebased onto the desired base.

For rebasing a single branch, having --continue do what you suggest
wouldn't be too problematic.

However, for when rebasing a tree of branches, I really need a
multi-shot operation, since I want to advance branches in a very
specific order.

Below is a shell session performing such a rebase, which hopefully shows
why I need this to be multi-shot.

On the simpler case of a single branch, I'd still prefer a multi-shot
approach where --continue only advances one rebase operation, because at
the end of it I want to stop, and check git-range-diff(1) to make sure
it all makes sense.

I've indented the output of commands, so that they are easier to
distinguish.

	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* G ada8aff4f08a (r/B, B) foo j
		* G d6163efdc2db bar i
		| * G 450f3a7f4f25 (r/HEAD, r/C, C) bar l
		| * G f7309b21ebfa bar k
		|/ =20
		* G e949e24ba457 (HEAD -> A, r/A) bar h
		*   G 607b450498be bar g
		|\ =20
		| * G b787bcd373d9 bar e
		* | G c496b325576f baz f
		|/ =20
		| * G dfd9156d099a (r/main, main) foo d
		| * G 4940c7d739be bar c
		| * G cebc8fde25bb foo b
		|/ =20
		* G 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
		Rebase: conflict
		Bisecting: 0 revisions left to test after this (roughly 1 step)
		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		Bisecting: 0 revisions left to test after this (roughly 0 steps)
		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: success
		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
		Author: Alejandro Colomar <alx@kernel.org>
		Date:   2026-10-05 14:42:32 +0200

		    bar c

		 bar | 1 +
		 1 file changed, 1 insertion(+)
		 create mode 100644 bar
		bisect found first 'bad' commit
		Auto-merging bar
		CONFLICT (add/add): Merge conflict in bar
		error: could not apply 899eeb5c4e32... bar e
		hint: Resolve all conflicts manually, mark them as resolved with
		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
		hint: You can instead skip this commit: run "git rebase --skip".
		hint: To abort and get back to the state before "git rebase", run "git re=
base --abort".
		hint: Disable this message with "git config set advice.mergeConflict fals=
e"
		Could not apply 899eeb5c4e32... # bar e
	alx@debian:~/tmp/brebase$ git rebase --abort=20
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 655c38e3cee8 (HEAD -> A) bar h
		*   1ababced193d bar g
		|\ =20
		| * 899eeb5c4e32 bar e
		* | 761c9dbcfa5b baz f
		|/ =20
		| * ada8aff4f08a (r/B, B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| * | c496b325576f baz f
		| |/ =20
		| | * dfd9156d099a (r/main, main) foo d
		| | * 4940c7d739be bar c
		| |/ =20
		|/|  =20
		* | cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git switch B=20
		Switched to branch 'B'
		Your branch is up to date with 'r/B'.
	alx@debian:~/tmp/brebase$ git brebase A
		Rebase: conflict
		Bisecting: 2 revisions left to test after this (roughly 1 step)
		[899eeb5c4e32397f0fe138c5b9f486d4682939cb] bar e
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		Bisecting: 0 revisions left to test after this (roughly 0 steps)
		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		cebc8fde25bbe16c0f5f48e39642b3551f4f56e6 is the first 'bad' commit
		commit cebc8fde25bbe16c0f5f48e39642b3551f4f56e6
		Author: Alejandro Colomar <alx@kernel.org>
		Date:   2026-10-05 14:42:04 +0200

		    foo b

		 foo | 2 +-
		 1 file changed, 1 insertion(+), 1 deletion(-)
		bisect found first 'bad' commit
		Auto-merging foo
		CONFLICT (content): Merge conflict in foo
		error: could not apply ada8aff4f08a... foo j
		hint: Resolve all conflicts manually, mark them as resolved with
		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
		hint: You can instead skip this commit: run "git rebase --skip".
		hint: To abort and get back to the state before "git rebase", run "git re=
base --abort".
		hint: Disable this message with "git config set advice.mergeConflict fals=
e"
		Could not apply ada8aff4f08a... # foo j
	alx@debian:~/tmp/brebase$ echo j >foo
	alx@debian:~/tmp/brebase$ git add foo=20
	alx@debian:~/tmp/brebase$ git rebase --continue=20
		[detached HEAD 2e0b72e7440a] foo j
		 1 file changed, 1 insertion(+), 1 deletion(-)
		Successfully rebased and updated refs/heads/B.
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 2e0b72e7440a (HEAD -> B) foo j
		* a1c6c1fb7ca2 bar i
		* d8fa6c4da463 bar h
		* bef9f1c4da4d bar e
		* 0bac26895b94 baz f
		| * 655c38e3cee8 (A) bar h
		| *   1ababced193d bar g
		| |\ =20
		| | * 899eeb5c4e32 bar e
		| |/ =20
		|/|  =20
		| * 761c9dbcfa5b baz f
		|/ =20
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| * | c496b325576f baz f
		| |/ =20
		| | * dfd9156d099a (r/main, main) foo d
		| | * 4940c7d739be bar c
		| |/ =20
		|/|  =20
		* | cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git brebase A
		Rebase: success
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 5ff93a00f9f2 (HEAD -> B) foo j
		* 01522206a7bc bar i
		* 655c38e3cee8 (A) bar h
		*   1ababced193d bar g
		|\ =20
		| * 899eeb5c4e32 bar e
		* | 761c9dbcfa5b baz f
		|/ =20
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| * | c496b325576f baz f
		| |/ =20
		| | * dfd9156d099a (r/main, main) foo d
		| | * 4940c7d739be bar c
		| |/ =20
		|/|  =20
		* | cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git switch C
		Switched to branch 'C'
	alx@debian:~/tmp/brebase$ git brebase A
		Rebase: success
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 06d462903420 (HEAD -> C) bar l
		* 20f0a887b83b bar k
		| * 5ff93a00f9f2 (B) foo j
		| * 01522206a7bc bar i
		|/ =20
		* 655c38e3cee8 (A) bar h
		*   1ababced193d bar g
		|\ =20
		| * 899eeb5c4e32 bar e
		* | 761c9dbcfa5b baz f
		|/ =20
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| * | c496b325576f baz f
		| |/ =20
		| | * dfd9156d099a (r/main, main) foo d
		| | * 4940c7d739be bar c
		| |/ =20
		|/|  =20
		* | cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git switch A
		Switched to branch 'A'
	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
		Rebase: conflict
		Bisecting: 0 revisions left to test after this (roughly 0 steps)
		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
		Author: Alejandro Colomar <alx@kernel.org>
		Date:   2026-10-05 14:42:32 +0200

		    bar c

		 bar | 1 +
		 1 file changed, 1 insertion(+)
		 create mode 100644 bar
		bisect found first 'bad' commit
		Auto-merging bar
		CONFLICT (add/add): Merge conflict in bar
		error: could not apply 899eeb5c4e32... bar e
		hint: Resolve all conflicts manually, mark them as resolved with
		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
		hint: You can instead skip this commit: run "git rebase --skip".
		hint: To abort and get back to the state before "git rebase", run "git re=
base --abort".
		hint: Disable this message with "git config set advice.mergeConflict fals=
e"
		Could not apply 899eeb5c4e32... # bar e
	alx@debian:~/tmp/brebase$ echo e >bar
	alx@debian:~/tmp/brebase$ git add bar=20
	alx@debian:~/tmp/brebase$ git rebase --continue=20
		[detached HEAD 2a4fa7fe2f44] bar e
		 1 file changed, 1 insertion(+), 1 deletion(-)
		Successfully rebased and updated refs/heads/A.
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 0954f3d9b9e1 (HEAD -> A) bar h
		*   4f09c21bf2ca bar g
		|\ =20
		| * 2a4fa7fe2f44 bar e
		* | e42246e75159 baz f
		|/ =20
		| * 06d462903420 (C) bar l
		| * 20f0a887b83b bar k
		| | * 5ff93a00f9f2 (B) foo j
		| | * 01522206a7bc bar i
		| |/ =20
		| * 655c38e3cee8 bar h
		| *   1ababced193d bar g
		| |\ =20
		| | * 899eeb5c4e32 bar e
		| * | 761c9dbcfa5b baz f
		| |/ =20
		| | * ada8aff4f08a (r/B) foo j
		| | * d6163efdc2db bar i
		| | | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | | * f7309b21ebfa bar k
		| | |/ =20
		| | * e949e24ba457 (r/A) bar h
		| | *   607b450498be bar g
		| | |\ =20
		| | | * b787bcd373d9 bar e
		| | * | c496b325576f baz f
		| | |/ =20
		| | | * dfd9156d099a (r/main, main) foo d
		| |_|/ =20
		|/| |  =20
		* | | 4940c7d739be bar c
		|/ / =20
		* / cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 B
		Successfully rebased and updated refs/heads/B.
	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 C
		Successfully rebased and updated refs/heads/C.
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 4a4ba76f55a4 (HEAD -> C) bar l
		* 86350e1490f3 bar k
		| * 4b6b40b14255 (B) foo j
		| * ba5a233ee4bc bar i
		|/ =20
		* 0954f3d9b9e1 (A) bar h
		*   4f09c21bf2ca bar g
		|\ =20
		| * 2a4fa7fe2f44 bar e
		* | e42246e75159 baz f
		|/ =20
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| * | c496b325576f baz f
		| |/ =20
		| | * dfd9156d099a (r/main, main) foo d
		| |/ =20
		|/|  =20
		* | 4940c7d739be bar c
		* | cebc8fde25bb foo b
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git switch A
		Switched to branch 'A'
	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
		Rebase: success
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 30e2d96b3da5 (HEAD -> A) bar h
		*   01702a5b5d6b bar g
		|\ =20
		| * c961883d543a bar e
		* | e17aadb725c4 baz f
		|/ =20
		* dfd9156d099a (r/main, main) foo d
		| * 4a4ba76f55a4 (C) bar l
		| * 86350e1490f3 bar k
		| | * 4b6b40b14255 (B) foo j
		| | * ba5a233ee4bc bar i
		| |/ =20
		| * 0954f3d9b9e1 bar h
		| *   4f09c21bf2ca bar g
		| |\ =20
		| | * 2a4fa7fe2f44 bar e
		| |/ =20
		|/|  =20
		| * e42246e75159 baz f
		|/ =20
		* 4940c7d739be bar c
		* cebc8fde25bb foo b
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| |/ =20
		|/|  =20
		| * c496b325576f baz f
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 C
		Successfully rebased and updated refs/heads/C.
	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 B
		Auto-merging foo
		CONFLICT (content): Merge conflict in foo
		error: could not apply 4b6b40b14255... foo j
		hint: Resolve all conflicts manually, mark them as resolved with
		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
		hint: You can instead skip this commit: run "git rebase --skip".
		hint: To abort and get back to the state before "git rebase", run "git re=
base --abort".
		hint: Disable this message with "git config set advice.mergeConflict fals=
e"
		Could not apply 4b6b40b14255... # foo j
	alx@debian:~/tmp/brebase$ git rebase --abort=20
	alx@debian:~/tmp/brebase$ git switch B
		Already on 'B'
		Your branch and 'r/B' have diverged,
		and have 8 and 6 different commits each, respectively.
		  (use "git pull" if you want to integrate the remote branch with yours)
	alx@debian:~/tmp/brebase$ git brebase A
		Rebase: conflict
		Bisecting: 2 revisions left to test after this (roughly 1 step)
		[c961883d543a2393aacfd6a8345e1d29e6857f7f] bar e
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		Bisecting: 0 revisions left to test after this (roughly 0 steps)
		[dfd9156d099ad3507a2850294c7a584b80712f04] foo d
		running '.git/bisect-rebase/git-bisect-run-callback'
		Rebase: conflict
		dfd9156d099ad3507a2850294c7a584b80712f04 is the first 'bad' commit
		commit dfd9156d099ad3507a2850294c7a584b80712f04
		Author: Alejandro Colomar <alx@kernel.org>
		Date:   2026-10-05 14:42:50 +0200

		    foo d

		 foo | 2 +-
		 1 file changed, 1 insertion(+), 1 deletion(-)
		bisect found first 'bad' commit
		Auto-merging foo
		CONFLICT (content): Merge conflict in foo
		error: could not apply 4b6b40b14255... foo j
		hint: Resolve all conflicts manually, mark them as resolved with
		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
		hint: You can instead skip this commit: run "git rebase --skip".
		hint: To abort and get back to the state before "git rebase", run "git re=
base --abort".
		hint: Disable this message with "git config set advice.mergeConflict fals=
e"
		Could not apply 4b6b40b14255... # foo j
	alx@debian:~/tmp/brebase$ echo j >foo
	alx@debian:~/tmp/brebase$ git add foo=20
	alx@debian:~/tmp/brebase$ git rebase --continue=20
		[detached HEAD e7fdf07fd077] foo j
		 1 file changed, 1 insertion(+), 1 deletion(-)
		Successfully rebased and updated refs/heads/B.
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* e7fdf07fd077 (HEAD -> B) foo j
		* dddf632a735f bar i
		* 7ac284de12ba bar h
		* e4541508ab3e bar e
		* cefec5878c67 baz f
		| * 6c7952d6fec5 (C) bar l
		| * bd43684f73c8 bar k
		| * 30e2d96b3da5 (A) bar h
		| *   01702a5b5d6b bar g
		| |\ =20
		| | * c961883d543a bar e
		| |/ =20
		|/|  =20
		| * e17aadb725c4 baz f
		|/ =20
		* dfd9156d099a (r/main, main) foo d
		* 4940c7d739be bar c
		* cebc8fde25bb foo b
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| |/ =20
		|/|  =20
		| * c496b325576f baz f
		|/ =20
		* 1dcb901ebf60 foo a
	alx@debian:~/tmp/brebase$ git brebase A
		Rebase: success
	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
		* 1201c4f20b19 (HEAD -> B) foo j
		* 44103f51a783 bar i
		| * 6c7952d6fec5 (C) bar l
		| * bd43684f73c8 bar k
		|/ =20
		* 30e2d96b3da5 (A) bar h
		*   01702a5b5d6b bar g
		|\ =20
		| * c961883d543a bar e
		* | e17aadb725c4 baz f
		|/ =20
		* dfd9156d099a (r/main, main) foo d
		* 4940c7d739be bar c
		* cebc8fde25bb foo b
		| * ada8aff4f08a (r/B) foo j
		| * d6163efdc2db bar i
		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
		| | * f7309b21ebfa bar k
		| |/ =20
		| * e949e24ba457 (r/A) bar h
		| *   607b450498be bar g
		| |\ =20
		| | * b787bcd373d9 bar e
		| |/ =20
		|/|  =20
		| * c496b325576f baz f
		|/ =20
		* 1dcb901ebf60 foo a

This would be impossible with an approach that handles all the way until
the end.  I need to be able to stop a bisect-rebase operation on one
branch in the middle, then do a bisect-rebase on its descendants, then
come back to bisect-rebase the parent branch.  Does this make sense?


Have a lovely day!
Alex


>=20
> Thanks
>=20
> Phillip
>=20
>=20
> > That's of course more involved though, so I understand in case you're
> > not interested in doing that.
> >=20
> > > If not, I will likely provide it in the man-pages repository as a help
> > > tool (which might end up packed by distros as part of manpages-utils).
> > > Is that okay to you?  (I ask mainly because it's using the git-
> > > namespace for commands, so you should at lease be aware of it.)
> >=20
> > I mean overall this is our primary way of extension, by picking up
> > utilities that have the "git-" prefix. So arguably you don't have to ask
> > us for permission to do that.
> >=20
> > Whether it makes sense to distribute such a tool as part of
> > manpages-utils is a different question, and one where I myself am of a
> > split mind. But that feels more like a question for distributors rather
> > than for us in the Git project.
> >=20
> > Thanks!
> >=20
> > Patrick
>=20

--=20
<https://www.alejandro-colomar.es>

--ndydnequjpg3k43h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrDpfUACgkQ64mZXMKQ
wqkWjRAAi5moW/PQ31y1/mzwhy6gIXcqTwDpaiiGQHDgiMqlteE/L+1p4XcDVfCy
L2exOu/IZY+aHu0LS08dElUSYojn42jLkGL8rxm3yv5u6G8wHqFlSen1nrORzLgW
0G35di+2zHEbS3VGgBY39x0E2s7xQtO0z0J6Gm4xSqt8Q4rfiv+zHlJbUGeFKavB
kVuuwxNZbd/MUCBbj37aBUyH/sTOIhjJXndZAy5th5eXdnVv7c0RKjVnL+NyTGpP
uv55HXnk2UFCdxmFa11YsCagfgSJ+qpZIXD/wWx7kwptFK7R+2vWO8TVR4Xc9+u7
Ila16GcgVvE1A2MYZ1XSBNtd9gJ0A04G4IC8RWc9ywEbdR/fETtrxKOZxMNzh8Yj
CXyw4xZmM4tKQhaN2bEF8SFC0o8818f5rx7IO4dE4KecNhQpsxfOCAh2FANP6AxM
CW8s9YnxL+uMZNAmhxEYtvEEF2NjpYm6dX+O2MD/7Pknyn4RMsZoqo3Kb9yxY4es
2UxHbabgD003pGZ50ZBTLi/VpXew+jXK8oeCbH/FfoklWXohtwmD4P8V8uddl4ZF
hxOSgusPTCUuIo/fYbv1DHy/xDGcdowLhxHrPXXl5ZEfQbm4COAM7KArHjiAEw5n
5+5rnFfu5TRtoWl+BWkMcySF+p8Yw/70AMHgeSERFoBVMQ9Ll44=
=XqKD
-----END PGP SIGNATURE-----

--ndydnequjpg3k43h--
