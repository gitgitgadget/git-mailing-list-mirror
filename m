Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B293DDAED
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497253; cv=none; b=uWTlQS4OBoxGjffihN4OOMvuJW97XcNPCyK/iMxChmYmKH5Fck0Hx9O4UVUMJoMqjXcHVNQ8+1kB4yXBcP6A85zRVnDl7Kl/kG9eYZBcE1fUBib+KVqLDZrl7Qbb5mcfBDIbGZ1HeYqqyAOfTn7SLxGkJcUdSubptHH5ZB1en4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497253; c=relaxed/simple;
	bh=bmRQ406eEEfI0hmRZvp2t1X4C2WfVApDUyuAk1JmvFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0ES2wpD9ij9jKqzjb9qv0rtxdBTdCW7j+UnMeSXUZm4SL2wvCsI0jC63w0CZBI8zO2Hy+nwyZNgDMqmzfeCNX5WQYP1DQRLo0nneEHxXJQez7ysmraNBTCHpj6BbM+ozAeN4Q5fU539AhufwXhh+iclwvKPlF5SIi7p+3zOcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmqVX11K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmqVX11K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741A91F000FF;
	Thu,  8 Oct 2026 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497251;
	bh=XRgLCeqxnUns/zaSK/4pzHz6lWr9UJ3slKfHJO6oky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PmqVX11K9m1dsg0zs7mvxfpbTlux2TlyICJA5+7zsg3JYUD3litXrRsPu67Kc9IEP
	 pwOYW9cLD6abqoBAQ1Fzl5A2KTWvwLfkhukT5CkCsmlo3cM4iazXRVPkevxlVH0JPI
	 rY1Ch/IZps+RRQaWqgNzl8XoXb4OnQy9PXGVbTdXz6rjo+IswU2/nhVsgZz3T6y7q/
	 l1/9T6qTpYeRkNtHV2Q4b5A1tCmB5w1NO0TIgzk02lAOUHuoQ15sjCMGYk2UW+zde0
	 3df7DJz/xORUNO5VTIE9Y618jxI/1mXbB/7AGgQTz/LU0aLnYWVDhrm9jfrDC0TSph
	 jjAjHjTty2QlA==
Date: Fri, 9 Oct 2026 00:07:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asgUCgp0nGrEK37o@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
 <asgRKoeuFyFoAp6Q@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24ye3rxxisyzhlji"
Content-Disposition: inline
In-Reply-To: <asgRKoeuFyFoAp6Q@debian>


--24ye3rxxisyzhlji
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asgUCgp0nGrEK37o@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
 <asgRKoeuFyFoAp6Q@debian>
MIME-Version: 1.0
In-Reply-To: <asgRKoeuFyFoAp6Q@debian>

> Date: 2026-10-09 00:05:47+0200
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi Philipp,
>=20
> > Date: 2026-10-06 15:01:29+0100
> > From: Phillip Wood <phillip.wood123@gmail.com>
> >
> > Hi Alejandro
> >=20
> > On 05/10/2026 14:37, Alejandro Colomar wrote:
> > > > Date: 2026-10-05 15:28:28+0200
> > > > From: Alejandro Colomar <alx@kernel.org>
> > > > > Date: 2026-10-04 11:03:39+0100
> > > > > From: Phillip Wood <phillip.wood123@gmail.com>
> > > > >=20
> > > > > I agree that would be the best way forward. Adding an "--incremen=
tal", or
> > > > > "--progressive" option to rebase would be useful I think. For eas=
e of use, I
> > > > > have a strong preference for an implementation where "rebase --co=
ntinue"
> > > > > handles rebasing onto progressively more recent bases, rather tha=
n the multi
> > > > > shot approach where the user has to run "git rebase --incremental=
" multiple
> > > > > times. Having a multi-shot approach makes it much less clear when=
 we've
> > > > > successfully rebased onto the desired base.
> > > >=20
> > > > For rebasing a single branch, having --continue do what you suggest
> > > > wouldn't be too problematic.
> > > >=20
> > > > However, for when rebasing a tree of branches, I really need a
> > > > multi-shot operation, since I want to advance branches in a very
> > > > specific order.
> > > >=20
> > > > Below is a shell session performing such a rebase, which hopefully =
shows
> > > > why I need this to be multi-shot.
> >=20
> > To me it shows that we need to improve "git rebase --update-refs" so th=
at it
> > can rebase a tree of branches automatically. Doing it manually is labor
> > intensive and error-prone (your example output shows it is easy to forg=
et
> > when you're meant to be resolving a conflict instead aborting the rebas=
e and
> > checking out another branch). In the example below
> >=20
> >     git rebase --update-refs --rebase-merges main B
> >=20
> > will rebase A and B, but we don't have a way of including C.
> > > > On the simpler case of a single branch, I'd still prefer a multi-sh=
ot
> > > > approach where --continue only advances one rebase operation, becau=
se at
> > > > the end of it I want to stop, and check git-range-diff(1) to make s=
ure
> > > > it all makes sense.
> >=20
> > Perhaps we could insert "break" commands after each branch is rebased s=
o the
> > user can check the range-diff.
>=20
> I've done something different:
>=20
> I've implemented --abort/--continue/--quit in git-bisect-rebase, which
> do something different than in git-rebase(1).
>=20
> 'git bisect-rebase --abort' returns to the original HEAD, and cleans up
> any temporary stuff.  It can be run at any time.
>=20
> 'git bisect-rebase --continue' restarts the whole bisect-rebase process.
> The current (conflicting) rebase must be resolved before (or it fails,
> and prints an error message).
>=20
> 'git bisect-rebase --quit' exist the bisect-rebase session, without
> moving the HEAD nor the branch from their last position.  I can use this
> to quit a bisect-rebase operation with one branch right before solving
> a conflict, then move all descentands into it, then come back to moving
> the original branch.
>=20
>=20
> So, the usual algorithm for moving a tree would be:
>=20
> 	$ git bisect-rebase master A;
> 	$ git rebase --abort;
> 	$ git bisect-rebase --quit;
> 	$ git bisect-rebase A B;
> 	## ... until success
> 	$ git bisect-rebase A C;
> 	## ... until success
> 	$ git tag tmpA;
> 	$ git bisect-rebase master A;
> 	## resolve conflicts here
> 	$ git rebase --continue;
> 	$ git bisect-rebase --quit;
> 	$ git rebase --onto A tmpA B;
> 	$ git rebase --onto A tmpA B;

This one meant to use C instead of B.


Cheers,
Alex

> 	$ git tag -d tmpA;
> 	## ... rinse and repeat (goto first command, until no conflicts)
>=20
> And the algorithm for moving a single branch would be simpler:
>=20
> 	$ git bisect-rebase master X;
> 	## resolve conflicts here
> 	$ git rebase --continue;
> 	$ git bisect-rebase --continue;
> 	## ... rinse and repeat (goto first command, until no conflicts)
>=20
> I've been trying both, and they both seem nice.
>=20
>=20
> Have a lovely night!
> Alex
>=20
> >=20
> > Thanks
> >=20
> > Phillip
> >=20
> >=20
> > > > I've indented the output of commands, so that they are easier to
> > > > distinguish.
> > > >=20
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* G ada8aff4f08a (r/B, B) foo j
> > > > 		* G d6163efdc2db bar i
> > > > 		| * G 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > > 		| * G f7309b21ebfa bar k
> > > > 		|/
> > > > 		* G e949e24ba457 (HEAD -> A, r/A) bar h
> > > > 		*   G 607b450498be bar g
> > > > 		|\
> > > > 		| * G b787bcd373d9 bar e
> > > > 		* | G c496b325576f baz f
> > > > 		|/
> > > > 		| * G dfd9156d099a (r/main, main) foo d
> > > > 		| * G 4940c7d739be bar c
> > > > 		| * G cebc8fde25bb foo b
> > > > 		|/
> > > > 		* G 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > > 		Rebase: conflict
> > > > 		Bisecting: 0 revisions left to test after this (roughly 1 step)
> > > > 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > > 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: success
> > > > 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
> > > > 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
> > > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > > 		Date:   2026-10-05 14:42:32 +0200
> > > >=20
> > > > 		    bar c
> > > >=20
> > > > 		 bar | 1 +
> > > > 		 1 file changed, 1 insertion(+)
> > > > 		 create mode 100644 bar
> > > > 		bisect found first 'bad' commit
> > > > 		Auto-merging bar
> > > > 		CONFLICT (add/add): Merge conflict in bar
> > > > 		error: could not apply 899eeb5c4e32... bar e
> > > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --con=
tinue".
> > > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > > 		hint: To abort and get back to the state before "git rebase", run=
 "git rebase --abort".
> > > > 		hint: Disable this message with "git config set advice.mergeConfl=
ict false"
> > > > 		Could not apply 899eeb5c4e32... # bar e
> > > > 	alx@debian:~/tmp/brebase$ git rebase --abort
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 655c38e3cee8 (HEAD -> A) bar h
> > > > 		*   1ababced193d bar g
> > > > 		|\
> > > > 		| * 899eeb5c4e32 bar e
> > > > 		* | 761c9dbcfa5b baz f
> > > > 		|/
> > > > 		| * ada8aff4f08a (r/B, B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| * | c496b325576f baz f
> > > > 		| |/
> > > > 		| | * dfd9156d099a (r/main, main) foo d
> > > > 		| | * 4940c7d739be bar c
> > > > 		| |/
> > > > 		|/|
> > > > 		* | cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git switch B
> > > > 		Switched to branch 'B'
> > > > 		Your branch is up to date with 'r/B'.
> > > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > > 		Rebase: conflict
> > > > 		Bisecting: 2 revisions left to test after this (roughly 1 step)
> > > > 		[899eeb5c4e32397f0fe138c5b9f486d4682939cb] bar e
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > > 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		cebc8fde25bbe16c0f5f48e39642b3551f4f56e6 is the first 'bad' commit
> > > > 		commit cebc8fde25bbe16c0f5f48e39642b3551f4f56e6
> > > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > > 		Date:   2026-10-05 14:42:04 +0200
> > > >=20
> > > > 		    foo b
> > > >=20
> > > > 		 foo | 2 +-
> > > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 		bisect found first 'bad' commit
> > > > 		Auto-merging foo
> > > > 		CONFLICT (content): Merge conflict in foo
> > > > 		error: could not apply ada8aff4f08a... foo j
> > > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --con=
tinue".
> > > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > > 		hint: To abort and get back to the state before "git rebase", run=
 "git rebase --abort".
> > > > 		hint: Disable this message with "git config set advice.mergeConfl=
ict false"
> > > > 		Could not apply ada8aff4f08a... # foo j
> > > > 	alx@debian:~/tmp/brebase$ echo j >foo
> > > > 	alx@debian:~/tmp/brebase$ git add foo
> > > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > > 		[detached HEAD 2e0b72e7440a] foo j
> > > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 		Successfully rebased and updated refs/heads/B.
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 2e0b72e7440a (HEAD -> B) foo j
> > > > 		* a1c6c1fb7ca2 bar i
> > > > 		* d8fa6c4da463 bar h
> > > > 		* bef9f1c4da4d bar e
> > > > 		* 0bac26895b94 baz f
> > > > 		| * 655c38e3cee8 (A) bar h
> > > > 		| *   1ababced193d bar g
> > > > 		| |\
> > > > 		| | * 899eeb5c4e32 bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * 761c9dbcfa5b baz f
> > > > 		|/
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| * | c496b325576f baz f
> > > > 		| |/
> > > > 		| | * dfd9156d099a (r/main, main) foo d
> > > > 		| | * 4940c7d739be bar c
> > > > 		| |/
> > > > 		|/|
> > > > 		* | cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > > 		Rebase: success
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 5ff93a00f9f2 (HEAD -> B) foo j
> > > > 		* 01522206a7bc bar i
> > > > 		* 655c38e3cee8 (A) bar h
> > > > 		*   1ababced193d bar g
> > > > 		|\
> > > > 		| * 899eeb5c4e32 bar e
> > > > 		* | 761c9dbcfa5b baz f
> > > > 		|/
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| * | c496b325576f baz f
> > > > 		| |/
> > > > 		| | * dfd9156d099a (r/main, main) foo d
> > > > 		| | * 4940c7d739be bar c
> > > > 		| |/
> > > > 		|/|
> > > > 		* | cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git switch C
> > > > 		Switched to branch 'C'
> > > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > > 		Rebase: success
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 06d462903420 (HEAD -> C) bar l
> > > > 		* 20f0a887b83b bar k
> > > > 		| * 5ff93a00f9f2 (B) foo j
> > > > 		| * 01522206a7bc bar i
> > > > 		|/
> > > > 		* 655c38e3cee8 (A) bar h
> > > > 		*   1ababced193d bar g
> > > > 		|\
> > > > 		| * 899eeb5c4e32 bar e
> > > > 		* | 761c9dbcfa5b baz f
> > > > 		|/
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| * | c496b325576f baz f
> > > > 		| |/
> > > > 		| | * dfd9156d099a (r/main, main) foo d
> > > > 		| | * 4940c7d739be bar c
> > > > 		| |/
> > > > 		|/|
> > > > 		* | cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git switch A
> > > > 		Switched to branch 'A'
> > > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > > 		Rebase: conflict
> > > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > > 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
> > > > 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
> > > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > > 		Date:   2026-10-05 14:42:32 +0200
> > > >=20
> > > > 		    bar c
> > > >=20
> > > > 		 bar | 1 +
> > > > 		 1 file changed, 1 insertion(+)
> > > > 		 create mode 100644 bar
> > > > 		bisect found first 'bad' commit
> > > > 		Auto-merging bar
> > > > 		CONFLICT (add/add): Merge conflict in bar
> > > > 		error: could not apply 899eeb5c4e32... bar e
> > > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --con=
tinue".
> > > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > > 		hint: To abort and get back to the state before "git rebase", run=
 "git rebase --abort".
> > > > 		hint: Disable this message with "git config set advice.mergeConfl=
ict false"
> > > > 		Could not apply 899eeb5c4e32... # bar e
> > > > 	alx@debian:~/tmp/brebase$ echo e >bar
> > > > 	alx@debian:~/tmp/brebase$ git add bar
> > > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > > 		[detached HEAD 2a4fa7fe2f44] bar e
> > > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 		Successfully rebased and updated refs/heads/A.
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 0954f3d9b9e1 (HEAD -> A) bar h
> > > > 		*   4f09c21bf2ca bar g
> > > > 		|\
> > > > 		| * 2a4fa7fe2f44 bar e
> > > > 		* | e42246e75159 baz f
> > > > 		|/
> > > > 		| * 06d462903420 (C) bar l
> > > > 		| * 20f0a887b83b bar k
> > > > 		| | * 5ff93a00f9f2 (B) foo j
> > > > 		| | * 01522206a7bc bar i
> > > > 		| |/
> > > > 		| * 655c38e3cee8 bar h
> > > > 		| *   1ababced193d bar g
> > > > 		| |\
> > > > 		| | * 899eeb5c4e32 bar e
> > > > 		| * | 761c9dbcfa5b baz f
> > > > 		| |/
> > > > 		| | * ada8aff4f08a (r/B) foo j
> > > > 		| | * d6163efdc2db bar i
> > > > 		| | | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | | * f7309b21ebfa bar k
> > > > 		| | |/
> > > > 		| | * e949e24ba457 (r/A) bar h
> > > > 		| | *   607b450498be bar g
> > > > 		| | |\
> > > > 		| | | * b787bcd373d9 bar e
> > > > 		| | * | c496b325576f baz f
> > > > 		| | |/
> > > > 		| | | * dfd9156d099a (r/main, main) foo d
> > > > 		| |_|/
> > > > 		|/| |
> > > > 		* | | 4940c7d739be bar c
> > > > 		|/ /
> > > > 		* / cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 B
> > > > 		Successfully rebased and updated refs/heads/B.
> > > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 C
> > > > 		Successfully rebased and updated refs/heads/C.
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 4a4ba76f55a4 (HEAD -> C) bar l
> > > > 		* 86350e1490f3 bar k
> > > > 		| * 4b6b40b14255 (B) foo j
> > > > 		| * ba5a233ee4bc bar i
> > > > 		|/
> > > > 		* 0954f3d9b9e1 (A) bar h
> > > > 		*   4f09c21bf2ca bar g
> > > > 		|\
> > > > 		| * 2a4fa7fe2f44 bar e
> > > > 		* | e42246e75159 baz f
> > > > 		|/
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| * | c496b325576f baz f
> > > > 		| |/
> > > > 		| | * dfd9156d099a (r/main, main) foo d
> > > > 		| |/
> > > > 		|/|
> > > > 		* | 4940c7d739be bar c
> > > > 		* | cebc8fde25bb foo b
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git switch A
> > > > 		Switched to branch 'A'
> > > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > > 		Rebase: success
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 30e2d96b3da5 (HEAD -> A) bar h
> > > > 		*   01702a5b5d6b bar g
> > > > 		|\
> > > > 		| * c961883d543a bar e
> > > > 		* | e17aadb725c4 baz f
> > > > 		|/
> > > > 		* dfd9156d099a (r/main, main) foo d
> > > > 		| * 4a4ba76f55a4 (C) bar l
> > > > 		| * 86350e1490f3 bar k
> > > > 		| | * 4b6b40b14255 (B) foo j
> > > > 		| | * ba5a233ee4bc bar i
> > > > 		| |/
> > > > 		| * 0954f3d9b9e1 bar h
> > > > 		| *   4f09c21bf2ca bar g
> > > > 		| |\
> > > > 		| | * 2a4fa7fe2f44 bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * e42246e75159 baz f
> > > > 		|/
> > > > 		* 4940c7d739be bar c
> > > > 		* cebc8fde25bb foo b
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * c496b325576f baz f
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 C
> > > > 		Successfully rebased and updated refs/heads/C.
> > > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 B
> > > > 		Auto-merging foo
> > > > 		CONFLICT (content): Merge conflict in foo
> > > > 		error: could not apply 4b6b40b14255... foo j
> > > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --con=
tinue".
> > > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > > 		hint: To abort and get back to the state before "git rebase", run=
 "git rebase --abort".
> > > > 		hint: Disable this message with "git config set advice.mergeConfl=
ict false"
> > > > 		Could not apply 4b6b40b14255... # foo j
> > > > 	alx@debian:~/tmp/brebase$ git rebase --abort
> > >=20
> > > Oh, this was a mistake;  I should have resolved the conflict here
> > > instead of using brebase below.  (brebase produced the same exact
> > > conflict).  :)
> > >=20
> > >=20
> > > Cheers,
> > > Alex
> > >=20
> > > > 	alx@debian:~/tmp/brebase$ git switch B
> > > > 		Already on 'B'
> > > > 		Your branch and 'r/B' have diverged,
> > > > 		and have 8 and 6 different commits each, respectively.
> > > > 		  (use "git pull" if you want to integrate the remote branch with=
 yours)
> > > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > > 		Rebase: conflict
> > > > 		Bisecting: 2 revisions left to test after this (roughly 1 step)
> > > > 		[c961883d543a2393aacfd6a8345e1d29e6857f7f] bar e
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > > 		[dfd9156d099ad3507a2850294c7a584b80712f04] foo d
> > > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > > 		Rebase: conflict
> > > > 		dfd9156d099ad3507a2850294c7a584b80712f04 is the first 'bad' commit
> > > > 		commit dfd9156d099ad3507a2850294c7a584b80712f04
> > > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > > 		Date:   2026-10-05 14:42:50 +0200
> > > >=20
> > > > 		    foo d
> > > >=20
> > > > 		 foo | 2 +-
> > > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 		bisect found first 'bad' commit
> > > > 		Auto-merging foo
> > > > 		CONFLICT (content): Merge conflict in foo
> > > > 		error: could not apply 4b6b40b14255... foo j
> > > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --con=
tinue".
> > > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > > 		hint: To abort and get back to the state before "git rebase", run=
 "git rebase --abort".
> > > > 		hint: Disable this message with "git config set advice.mergeConfl=
ict false"
> > > > 		Could not apply 4b6b40b14255... # foo j
> > > > 	alx@debian:~/tmp/brebase$ echo j >foo
> > > > 	alx@debian:~/tmp/brebase$ git add foo
> > > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > > 		[detached HEAD e7fdf07fd077] foo j
> > > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 		Successfully rebased and updated refs/heads/B.
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* e7fdf07fd077 (HEAD -> B) foo j
> > > > 		* dddf632a735f bar i
> > > > 		* 7ac284de12ba bar h
> > > > 		* e4541508ab3e bar e
> > > > 		* cefec5878c67 baz f
> > > > 		| * 6c7952d6fec5 (C) bar l
> > > > 		| * bd43684f73c8 bar k
> > > > 		| * 30e2d96b3da5 (A) bar h
> > > > 		| *   01702a5b5d6b bar g
> > > > 		| |\
> > > > 		| | * c961883d543a bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * e17aadb725c4 baz f
> > > > 		|/
> > > > 		* dfd9156d099a (r/main, main) foo d
> > > > 		* 4940c7d739be bar c
> > > > 		* cebc8fde25bb foo b
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * c496b325576f baz f
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > > 		Rebase: success
> > > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > > 		* 1201c4f20b19 (HEAD -> B) foo j
> > > > 		* 44103f51a783 bar i
> > > > 		| * 6c7952d6fec5 (C) bar l
> > > > 		| * bd43684f73c8 bar k
> > > > 		|/
> > > > 		* 30e2d96b3da5 (A) bar h
> > > > 		*   01702a5b5d6b bar g
> > > > 		|\
> > > > 		| * c961883d543a bar e
> > > > 		* | e17aadb725c4 baz f
> > > > 		|/
> > > > 		* dfd9156d099a (r/main, main) foo d
> > > > 		* 4940c7d739be bar c
> > > > 		* cebc8fde25bb foo b
> > > > 		| * ada8aff4f08a (r/B) foo j
> > > > 		| * d6163efdc2db bar i
> > > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > > 		| | * f7309b21ebfa bar k
> > > > 		| |/
> > > > 		| * e949e24ba457 (r/A) bar h
> > > > 		| *   607b450498be bar g
> > > > 		| |\
> > > > 		| | * b787bcd373d9 bar e
> > > > 		| |/
> > > > 		|/|
> > > > 		| * c496b325576f baz f
> > > > 		|/
> > > > 		* 1dcb901ebf60 foo a
> > > >=20
> > > > This would be impossible with an approach that handles all the way =
until
> > > > the end.  I need to be able to stop a bisect-rebase operation on one
> > > > branch in the middle, then do a bisect-rebase on its descendants, t=
hen
> > > > come back to bisect-rebase the parent branch.  Does this make sense?
> > > >=20
> > > >=20
> > > > Have a lovely day!
> > > > Alex
> > > >=20
> > > >=20
> > > > >=20
> > > > > Thanks
> > > > >=20
> > > > > Phillip
> > > > >=20
> > > > >=20
> > > > > > That's of course more involved though, so I understand in case =
you're
> > > > > > not interested in doing that.
> > > > > >=20
> > > > > > > If not, I will likely provide it in the man-pages repository =
as a help
> > > > > > > tool (which might end up packed by distros as part of manpage=
s-utils).
> > > > > > > Is that okay to you?  (I ask mainly because it's using the gi=
t-
> > > > > > > namespace for commands, so you should at lease be aware of it=
=2E)
> > > > > >=20
> > > > > > I mean overall this is our primary way of extension, by picking=
 up
> > > > > > utilities that have the "git-" prefix. So arguably you don't ha=
ve to ask
> > > > > > us for permission to do that.
> > > > > >=20
> > > > > > Whether it makes sense to distribute such a tool as part of
> > > > > > manpages-utils is a different question, and one where I myself =
am of a
> > > > > > split mind. But that feels more like a question for distributor=
s rather
> > > > > > than for us in the Git project.
> > > > > >=20
> > > > > > Thanks!
> > > > > >=20
> > > > > > Patrick
> > > > >=20
> > > >=20
> > > > --=20
> > > > <https://www.alejandro-colomar.es>
> > >=20
> > >=20
> > >=20
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--24ye3rxxisyzhlji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrIFB4ACgkQ64mZXMKQ
wqlsBhAAiy8yfei5kNc4nrAEKvzfztvO2aC3QEQlZ9gdV26I1PJ4vMM+d8PwylIM
9QJd9obEZLlZAHu9GG+6+iBZOdv/SPUX5oRGIgWoNoZQQK05uLZVaWiYFYprhFBZ
+aR47tepkZYO2epCQ9ZZw+IvQ2qpBekj96ii7QMYMdFRHCQlsMcfftuuoLFKw2nE
mt+J9+aISAB8OMlBc55R9Tggu/7BRgRFUGAqmWpus0wJWD8GcNaoZLKh0kXdCG89
c9aGCSRbL52fAn346ptMAy7SSTiPtwwGoCX7HbL0t8f+kHCI3S3EDC8CRKsbboJZ
6tIDekDIm0b8VgyGQ8qLr80+XBq5Zsh3RWNfgdFrRqv172WL0S+YPagu8dyLzuWK
aLEk/Z6ttNNtIUzLYMYG+7bKb4FEbRjJ/Z18PyPna28KcAz98qCxt7GgJ1KsPNC3
oIldW+2mF6IObygI7zKCegyGmpExcLLVg/whOeMWHcCQ/oei7U2YYutIfkGkaSn0
JE7bCo2BbxGPVQX87IoEWIO6MM2JFjLVb/ylVEUBvpTU4kOJtYkf6YkpA7V6SER0
JSd2Q2iTOhBwmbwXJYte/+/zqc5NFh9Wj5Dz4dcd0FYVoH6eiKfa2dBe11y1xOlm
gfleL3s5jG+GyD5p9oLJXw9wtLy5HWyP2vx9LX0YKIwTlRyJWl4=
=2OaM
-----END PGP SIGNATURE-----

--24ye3rxxisyzhlji--
