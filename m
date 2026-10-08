Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E38437107
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497149; cv=none; b=qps0XmGuuza9MQ2MC5QidH0U566KdpSxyUafRdurNysCA0c97vfA+QeKDClpYtKLOze7bNRSW5V5rM9X0RPq6Df4Y9w1PDEhRQ5nkomjXdny5Kc35WKJrkeZGBv4XZCCFJwjDecllRJk49mSKnR0XrWS31f5y5eoFJsP3NCKTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497149; c=relaxed/simple;
	bh=CumOp9ipSuUkLrF1SA8lxAcS/JnXs1kSZUuC2myW92o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXYi7HZe5RSmOuv9KQ6GBl587y3IGRHkEx7KBbaFA+w45ohU/AqkTGNLZrGWy+yalm2IK27prA1lumvUOClmkTojUsvuJIoRdxFuKUSH46aqLjv/ENpr/OjKFQbIj5DU9rWGRheB4Z5o/mNfRaQu2Dk8pTMryigJ8Je1eJFTOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1PvQgaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1PvQgaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512EB1F000FF;
	Thu,  8 Oct 2026 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497147;
	bh=kl0ePcBM0miye0X1U4YLDn+rBNrKEAeWQF+Fwzij+ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M1PvQgaq3tLYOTNqX03pgmWqVUREiP63PJuUbPfIszILIxwjryQDRJ6UV80aspJoV
	 +Bw65Z2U/sb1QF4HGa/eG/MeEInzIehQCXUjWjCuvbjnVYLo8vxcaIomvX8uRz6fJ6
	 cleoCIDBgv/MUc8UHF7B4VY61pRBPoxXIjzyELKnN0KjOYNMCtqd/6orPKeYSkkkF7
	 yzmFtZEiyyJO/8cMwEpsN7uUAyJtMKstH6NgnHtH2Aspn837r0tAcSmD2HwYhvPrzs
	 yDkV/5uJmBL0qYFu8X+ngoSty5g/shUymok6pMvaoosxPMFwKI8EcGTar0p+xnUXTW
	 eykLK25jArrIA==
Date: Fri, 9 Oct 2026 00:05:40 +0200
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asgRKoeuFyFoAp6Q@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7oe3kubrmby3et2e"
Content-Disposition: inline
In-Reply-To: <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>


--7oe3kubrmby3et2e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Nico Williams <nico@cryptonector.com>
Subject: Re: git-rebase-walk
Message-ID: <asgRKoeuFyFoAp6Q@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
MIME-Version: 1.0
In-Reply-To: <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>

Hi Philipp,

> Date: 2026-10-06 15:01:29+0100
> From: Phillip Wood <phillip.wood123@gmail.com>
>
> Hi Alejandro
>=20
> On 05/10/2026 14:37, Alejandro Colomar wrote:
> > > Date: 2026-10-05 15:28:28+0200
> > > From: Alejandro Colomar <alx@kernel.org>
> > > > Date: 2026-10-04 11:03:39+0100
> > > > From: Phillip Wood <phillip.wood123@gmail.com>
> > > >=20
> > > > I agree that would be the best way forward. Adding an "--incrementa=
l", or
> > > > "--progressive" option to rebase would be useful I think. For ease =
of use, I
> > > > have a strong preference for an implementation where "rebase --cont=
inue"
> > > > handles rebasing onto progressively more recent bases, rather than =
the multi
> > > > shot approach where the user has to run "git rebase --incremental" =
multiple
> > > > times. Having a multi-shot approach makes it much less clear when w=
e've
> > > > successfully rebased onto the desired base.
> > >=20
> > > For rebasing a single branch, having --continue do what you suggest
> > > wouldn't be too problematic.
> > >=20
> > > However, for when rebasing a tree of branches, I really need a
> > > multi-shot operation, since I want to advance branches in a very
> > > specific order.
> > >=20
> > > Below is a shell session performing such a rebase, which hopefully sh=
ows
> > > why I need this to be multi-shot.
>=20
> To me it shows that we need to improve "git rebase --update-refs" so that=
 it
> can rebase a tree of branches automatically. Doing it manually is labor
> intensive and error-prone (your example output shows it is easy to forget
> when you're meant to be resolving a conflict instead aborting the rebase =
and
> checking out another branch). In the example below
>=20
>     git rebase --update-refs --rebase-merges main B
>=20
> will rebase A and B, but we don't have a way of including C.
> > > On the simpler case of a single branch, I'd still prefer a multi-shot
> > > approach where --continue only advances one rebase operation, because=
 at
> > > the end of it I want to stop, and check git-range-diff(1) to make sure
> > > it all makes sense.
>=20
> Perhaps we could insert "break" commands after each branch is rebased so =
the
> user can check the range-diff.

I've done something different:

I've implemented --abort/--continue/--quit in git-bisect-rebase, which
do something different than in git-rebase(1).

'git bisect-rebase --abort' returns to the original HEAD, and cleans up
any temporary stuff.  It can be run at any time.

'git bisect-rebase --continue' restarts the whole bisect-rebase process.
The current (conflicting) rebase must be resolved before (or it fails,
and prints an error message).

'git bisect-rebase --quit' exist the bisect-rebase session, without
moving the HEAD nor the branch from their last position.  I can use this
to quit a bisect-rebase operation with one branch right before solving
a conflict, then move all descentands into it, then come back to moving
the original branch.


So, the usual algorithm for moving a tree would be:

	$ git bisect-rebase master A;
	$ git rebase --abort;
	$ git bisect-rebase --quit;
	$ git bisect-rebase A B;
	## ... until success
	$ git bisect-rebase A C;
	## ... until success
	$ git tag tmpA;
	$ git bisect-rebase master A;
	## resolve conflicts here
	$ git rebase --continue;
	$ git bisect-rebase --quit;
	$ git rebase --onto A tmpA B;
	$ git rebase --onto A tmpA B;
	$ git tag -d tmpA;
	## ... rinse and repeat (goto first command, until no conflicts)

And the algorithm for moving a single branch would be simpler:

	$ git bisect-rebase master X;
	## resolve conflicts here
	$ git rebase --continue;
	$ git bisect-rebase --continue;
	## ... rinse and repeat (goto first command, until no conflicts)

I've been trying both, and they both seem nice.


Have a lovely night!
Alex

>=20
> Thanks
>=20
> Phillip
>=20
>=20
> > > I've indented the output of commands, so that they are easier to
> > > distinguish.
> > >=20
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* G ada8aff4f08a (r/B, B) foo j
> > > 		* G d6163efdc2db bar i
> > > 		| * G 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > 		| * G f7309b21ebfa bar k
> > > 		|/
> > > 		* G e949e24ba457 (HEAD -> A, r/A) bar h
> > > 		*   G 607b450498be bar g
> > > 		|\
> > > 		| * G b787bcd373d9 bar e
> > > 		* | G c496b325576f baz f
> > > 		|/
> > > 		| * G dfd9156d099a (r/main, main) foo d
> > > 		| * G 4940c7d739be bar c
> > > 		| * G cebc8fde25bb foo b
> > > 		|/
> > > 		* G 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > 		Rebase: conflict
> > > 		Bisecting: 0 revisions left to test after this (roughly 1 step)
> > > 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: success
> > > 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
> > > 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
> > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > 		Date:   2026-10-05 14:42:32 +0200
> > >=20
> > > 		    bar c
> > >=20
> > > 		 bar | 1 +
> > > 		 1 file changed, 1 insertion(+)
> > > 		 create mode 100644 bar
> > > 		bisect found first 'bad' commit
> > > 		Auto-merging bar
> > > 		CONFLICT (add/add): Merge conflict in bar
> > > 		error: could not apply 899eeb5c4e32... bar e
> > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --conti=
nue".
> > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > 		hint: To abort and get back to the state before "git rebase", run "=
git rebase --abort".
> > > 		hint: Disable this message with "git config set advice.mergeConflic=
t false"
> > > 		Could not apply 899eeb5c4e32... # bar e
> > > 	alx@debian:~/tmp/brebase$ git rebase --abort
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 655c38e3cee8 (HEAD -> A) bar h
> > > 		*   1ababced193d bar g
> > > 		|\
> > > 		| * 899eeb5c4e32 bar e
> > > 		* | 761c9dbcfa5b baz f
> > > 		|/
> > > 		| * ada8aff4f08a (r/B, B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| * | c496b325576f baz f
> > > 		| |/
> > > 		| | * dfd9156d099a (r/main, main) foo d
> > > 		| | * 4940c7d739be bar c
> > > 		| |/
> > > 		|/|
> > > 		* | cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git switch B
> > > 		Switched to branch 'B'
> > > 		Your branch is up to date with 'r/B'.
> > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > 		Rebase: conflict
> > > 		Bisecting: 2 revisions left to test after this (roughly 1 step)
> > > 		[899eeb5c4e32397f0fe138c5b9f486d4682939cb] bar e
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		cebc8fde25bbe16c0f5f48e39642b3551f4f56e6 is the first 'bad' commit
> > > 		commit cebc8fde25bbe16c0f5f48e39642b3551f4f56e6
> > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > 		Date:   2026-10-05 14:42:04 +0200
> > >=20
> > > 		    foo b
> > >=20
> > > 		 foo | 2 +-
> > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 		bisect found first 'bad' commit
> > > 		Auto-merging foo
> > > 		CONFLICT (content): Merge conflict in foo
> > > 		error: could not apply ada8aff4f08a... foo j
> > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --conti=
nue".
> > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > 		hint: To abort and get back to the state before "git rebase", run "=
git rebase --abort".
> > > 		hint: Disable this message with "git config set advice.mergeConflic=
t false"
> > > 		Could not apply ada8aff4f08a... # foo j
> > > 	alx@debian:~/tmp/brebase$ echo j >foo
> > > 	alx@debian:~/tmp/brebase$ git add foo
> > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > 		[detached HEAD 2e0b72e7440a] foo j
> > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 		Successfully rebased and updated refs/heads/B.
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 2e0b72e7440a (HEAD -> B) foo j
> > > 		* a1c6c1fb7ca2 bar i
> > > 		* d8fa6c4da463 bar h
> > > 		* bef9f1c4da4d bar e
> > > 		* 0bac26895b94 baz f
> > > 		| * 655c38e3cee8 (A) bar h
> > > 		| *   1ababced193d bar g
> > > 		| |\
> > > 		| | * 899eeb5c4e32 bar e
> > > 		| |/
> > > 		|/|
> > > 		| * 761c9dbcfa5b baz f
> > > 		|/
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| * | c496b325576f baz f
> > > 		| |/
> > > 		| | * dfd9156d099a (r/main, main) foo d
> > > 		| | * 4940c7d739be bar c
> > > 		| |/
> > > 		|/|
> > > 		* | cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > 		Rebase: success
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 5ff93a00f9f2 (HEAD -> B) foo j
> > > 		* 01522206a7bc bar i
> > > 		* 655c38e3cee8 (A) bar h
> > > 		*   1ababced193d bar g
> > > 		|\
> > > 		| * 899eeb5c4e32 bar e
> > > 		* | 761c9dbcfa5b baz f
> > > 		|/
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| * | c496b325576f baz f
> > > 		| |/
> > > 		| | * dfd9156d099a (r/main, main) foo d
> > > 		| | * 4940c7d739be bar c
> > > 		| |/
> > > 		|/|
> > > 		* | cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git switch C
> > > 		Switched to branch 'C'
> > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > 		Rebase: success
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 06d462903420 (HEAD -> C) bar l
> > > 		* 20f0a887b83b bar k
> > > 		| * 5ff93a00f9f2 (B) foo j
> > > 		| * 01522206a7bc bar i
> > > 		|/
> > > 		* 655c38e3cee8 (A) bar h
> > > 		*   1ababced193d bar g
> > > 		|\
> > > 		| * 899eeb5c4e32 bar e
> > > 		* | 761c9dbcfa5b baz f
> > > 		|/
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| * | c496b325576f baz f
> > > 		| |/
> > > 		| | * dfd9156d099a (r/main, main) foo d
> > > 		| | * 4940c7d739be bar c
> > > 		| |/
> > > 		|/|
> > > 		* | cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git switch A
> > > 		Switched to branch 'A'
> > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > 		Rebase: conflict
> > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
> > > 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
> > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > 		Date:   2026-10-05 14:42:32 +0200
> > >=20
> > > 		    bar c
> > >=20
> > > 		 bar | 1 +
> > > 		 1 file changed, 1 insertion(+)
> > > 		 create mode 100644 bar
> > > 		bisect found first 'bad' commit
> > > 		Auto-merging bar
> > > 		CONFLICT (add/add): Merge conflict in bar
> > > 		error: could not apply 899eeb5c4e32... bar e
> > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --conti=
nue".
> > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > 		hint: To abort and get back to the state before "git rebase", run "=
git rebase --abort".
> > > 		hint: Disable this message with "git config set advice.mergeConflic=
t false"
> > > 		Could not apply 899eeb5c4e32... # bar e
> > > 	alx@debian:~/tmp/brebase$ echo e >bar
> > > 	alx@debian:~/tmp/brebase$ git add bar
> > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > 		[detached HEAD 2a4fa7fe2f44] bar e
> > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 		Successfully rebased and updated refs/heads/A.
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 0954f3d9b9e1 (HEAD -> A) bar h
> > > 		*   4f09c21bf2ca bar g
> > > 		|\
> > > 		| * 2a4fa7fe2f44 bar e
> > > 		* | e42246e75159 baz f
> > > 		|/
> > > 		| * 06d462903420 (C) bar l
> > > 		| * 20f0a887b83b bar k
> > > 		| | * 5ff93a00f9f2 (B) foo j
> > > 		| | * 01522206a7bc bar i
> > > 		| |/
> > > 		| * 655c38e3cee8 bar h
> > > 		| *   1ababced193d bar g
> > > 		| |\
> > > 		| | * 899eeb5c4e32 bar e
> > > 		| * | 761c9dbcfa5b baz f
> > > 		| |/
> > > 		| | * ada8aff4f08a (r/B) foo j
> > > 		| | * d6163efdc2db bar i
> > > 		| | | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | | * f7309b21ebfa bar k
> > > 		| | |/
> > > 		| | * e949e24ba457 (r/A) bar h
> > > 		| | *   607b450498be bar g
> > > 		| | |\
> > > 		| | | * b787bcd373d9 bar e
> > > 		| | * | c496b325576f baz f
> > > 		| | |/
> > > 		| | | * dfd9156d099a (r/main, main) foo d
> > > 		| |_|/
> > > 		|/| |
> > > 		* | | 4940c7d739be bar c
> > > 		|/ /
> > > 		* / cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 B
> > > 		Successfully rebased and updated refs/heads/B.
> > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 C
> > > 		Successfully rebased and updated refs/heads/C.
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 4a4ba76f55a4 (HEAD -> C) bar l
> > > 		* 86350e1490f3 bar k
> > > 		| * 4b6b40b14255 (B) foo j
> > > 		| * ba5a233ee4bc bar i
> > > 		|/
> > > 		* 0954f3d9b9e1 (A) bar h
> > > 		*   4f09c21bf2ca bar g
> > > 		|\
> > > 		| * 2a4fa7fe2f44 bar e
> > > 		* | e42246e75159 baz f
> > > 		|/
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| * | c496b325576f baz f
> > > 		| |/
> > > 		| | * dfd9156d099a (r/main, main) foo d
> > > 		| |/
> > > 		|/|
> > > 		* | 4940c7d739be bar c
> > > 		* | cebc8fde25bb foo b
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git switch A
> > > 		Switched to branch 'A'
> > > 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
> > > 		Rebase: success
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 30e2d96b3da5 (HEAD -> A) bar h
> > > 		*   01702a5b5d6b bar g
> > > 		|\
> > > 		| * c961883d543a bar e
> > > 		* | e17aadb725c4 baz f
> > > 		|/
> > > 		* dfd9156d099a (r/main, main) foo d
> > > 		| * 4a4ba76f55a4 (C) bar l
> > > 		| * 86350e1490f3 bar k
> > > 		| | * 4b6b40b14255 (B) foo j
> > > 		| | * ba5a233ee4bc bar i
> > > 		| |/
> > > 		| * 0954f3d9b9e1 bar h
> > > 		| *   4f09c21bf2ca bar g
> > > 		| |\
> > > 		| | * 2a4fa7fe2f44 bar e
> > > 		| |/
> > > 		|/|
> > > 		| * e42246e75159 baz f
> > > 		|/
> > > 		* 4940c7d739be bar c
> > > 		* cebc8fde25bb foo b
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| |/
> > > 		|/|
> > > 		| * c496b325576f baz f
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 C
> > > 		Successfully rebased and updated refs/heads/C.
> > > 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 B
> > > 		Auto-merging foo
> > > 		CONFLICT (content): Merge conflict in foo
> > > 		error: could not apply 4b6b40b14255... foo j
> > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --conti=
nue".
> > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > 		hint: To abort and get back to the state before "git rebase", run "=
git rebase --abort".
> > > 		hint: Disable this message with "git config set advice.mergeConflic=
t false"
> > > 		Could not apply 4b6b40b14255... # foo j
> > > 	alx@debian:~/tmp/brebase$ git rebase --abort
> >=20
> > Oh, this was a mistake;  I should have resolved the conflict here
> > instead of using brebase below.  (brebase produced the same exact
> > conflict).  :)
> >=20
> >=20
> > Cheers,
> > Alex
> >=20
> > > 	alx@debian:~/tmp/brebase$ git switch B
> > > 		Already on 'B'
> > > 		Your branch and 'r/B' have diverged,
> > > 		and have 8 and 6 different commits each, respectively.
> > > 		  (use "git pull" if you want to integrate the remote branch with y=
ours)
> > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > 		Rebase: conflict
> > > 		Bisecting: 2 revisions left to test after this (roughly 1 step)
> > > 		[c961883d543a2393aacfd6a8345e1d29e6857f7f] bar e
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > 		[dfd9156d099ad3507a2850294c7a584b80712f04] foo d
> > > 		running '.git/bisect-rebase/git-bisect-run-callback'
> > > 		Rebase: conflict
> > > 		dfd9156d099ad3507a2850294c7a584b80712f04 is the first 'bad' commit
> > > 		commit dfd9156d099ad3507a2850294c7a584b80712f04
> > > 		Author: Alejandro Colomar <alx@kernel.org>
> > > 		Date:   2026-10-05 14:42:50 +0200
> > >=20
> > > 		    foo d
> > >=20
> > > 		 foo | 2 +-
> > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 		bisect found first 'bad' commit
> > > 		Auto-merging foo
> > > 		CONFLICT (content): Merge conflict in foo
> > > 		error: could not apply 4b6b40b14255... foo j
> > > 		hint: Resolve all conflicts manually, mark them as resolved with
> > > 		hint: "git add/rm <conflicted_files>", then run "git rebase --conti=
nue".
> > > 		hint: You can instead skip this commit: run "git rebase --skip".
> > > 		hint: To abort and get back to the state before "git rebase", run "=
git rebase --abort".
> > > 		hint: Disable this message with "git config set advice.mergeConflic=
t false"
> > > 		Could not apply 4b6b40b14255... # foo j
> > > 	alx@debian:~/tmp/brebase$ echo j >foo
> > > 	alx@debian:~/tmp/brebase$ git add foo
> > > 	alx@debian:~/tmp/brebase$ git rebase --continue
> > > 		[detached HEAD e7fdf07fd077] foo j
> > > 		 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 		Successfully rebased and updated refs/heads/B.
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* e7fdf07fd077 (HEAD -> B) foo j
> > > 		* dddf632a735f bar i
> > > 		* 7ac284de12ba bar h
> > > 		* e4541508ab3e bar e
> > > 		* cefec5878c67 baz f
> > > 		| * 6c7952d6fec5 (C) bar l
> > > 		| * bd43684f73c8 bar k
> > > 		| * 30e2d96b3da5 (A) bar h
> > > 		| *   01702a5b5d6b bar g
> > > 		| |\
> > > 		| | * c961883d543a bar e
> > > 		| |/
> > > 		|/|
> > > 		| * e17aadb725c4 baz f
> > > 		|/
> > > 		* dfd9156d099a (r/main, main) foo d
> > > 		* 4940c7d739be bar c
> > > 		* cebc8fde25bb foo b
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| |/
> > > 		|/|
> > > 		| * c496b325576f baz f
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > > 	alx@debian:~/tmp/brebase$ git brebase A
> > > 		Rebase: success
> > > 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
> > > 		* 1201c4f20b19 (HEAD -> B) foo j
> > > 		* 44103f51a783 bar i
> > > 		| * 6c7952d6fec5 (C) bar l
> > > 		| * bd43684f73c8 bar k
> > > 		|/
> > > 		* 30e2d96b3da5 (A) bar h
> > > 		*   01702a5b5d6b bar g
> > > 		|\
> > > 		| * c961883d543a bar e
> > > 		* | e17aadb725c4 baz f
> > > 		|/
> > > 		* dfd9156d099a (r/main, main) foo d
> > > 		* 4940c7d739be bar c
> > > 		* cebc8fde25bb foo b
> > > 		| * ada8aff4f08a (r/B) foo j
> > > 		| * d6163efdc2db bar i
> > > 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
> > > 		| | * f7309b21ebfa bar k
> > > 		| |/
> > > 		| * e949e24ba457 (r/A) bar h
> > > 		| *   607b450498be bar g
> > > 		| |\
> > > 		| | * b787bcd373d9 bar e
> > > 		| |/
> > > 		|/|
> > > 		| * c496b325576f baz f
> > > 		|/
> > > 		* 1dcb901ebf60 foo a
> > >=20
> > > This would be impossible with an approach that handles all the way un=
til
> > > the end.  I need to be able to stop a bisect-rebase operation on one
> > > branch in the middle, then do a bisect-rebase on its descendants, then
> > > come back to bisect-rebase the parent branch.  Does this make sense?
> > >=20
> > >=20
> > > Have a lovely day!
> > > Alex
> > >=20
> > >=20
> > > >=20
> > > > Thanks
> > > >=20
> > > > Phillip
> > > >=20
> > > >=20
> > > > > That's of course more involved though, so I understand in case yo=
u're
> > > > > not interested in doing that.
> > > > >=20
> > > > > > If not, I will likely provide it in the man-pages repository as=
 a help
> > > > > > tool (which might end up packed by distros as part of manpages-=
utils).
> > > > > > Is that okay to you?  (I ask mainly because it's using the git-
> > > > > > namespace for commands, so you should at lease be aware of it.)
> > > > >=20
> > > > > I mean overall this is our primary way of extension, by picking up
> > > > > utilities that have the "git-" prefix. So arguably you don't have=
 to ask
> > > > > us for permission to do that.
> > > > >=20
> > > > > Whether it makes sense to distribute such a tool as part of
> > > > > manpages-utils is a different question, and one where I myself am=
 of a
> > > > > split mind. But that feels more like a question for distributors =
rather
> > > > > than for us in the Git project.
> > > > >=20
> > > > > Thanks!
> > > > >=20
> > > > > Patrick
> > > >=20
> > >=20
> > > --=20
> > > <https://www.alejandro-colomar.es>
> >=20
> >=20
> >=20
>=20

--=20
<https://www.alejandro-colomar.es>

--7oe3kubrmby3et2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrIE64ACgkQ64mZXMKQ
wqkaaBAAmWrgObaZbk3wowFRWYBWzk2NVyK6a1eccoyH1+10Zczty/UorWruMucE
yxrC6wcLmLfKDolL2RaRtIhTwKrITuuCnfytYpsfUhmwiNcP1FcH4HyzkHCmeCtv
Nd/e0u5y8FzoaT0AS+CWK0mGokOTx7h4ciS58wgK9OQuzpmFfWAhLGRcRxivCo/O
M78FzADg5GcBabjMUYN00dOQEzCohqVhfzPZn43HUpQwI3eaNPzHgU/xjIyKJB+U
J5z3t+tmnuMp+0rGhghQe0Te8SMaNjEPZCSOXUWUvNsFZI3wrz3Hlh9Nenoa7zlN
xDsV17Yg6us/aDSQWLWBZkYTRmRztuk1/yDlpobFNrvGH6HPhcvlpjCXzcbInZRE
681yER+XaPvpTw6nF0LEDDUvW6NqeowVg8fpvfmVqTuN27y3dC7I+xo0C1va5SQK
FsKM6rkcLxiZeJ+I+fbI+JLsuJbYggaDm5mAq6Rd1tizVTvzglCyjWI8AW9Wv3X+
RJdAsvZf1kSTAuTm+bb0C7msCsBAZJmnjF+uTanGuaZLxdZN4HiziSD7aMqW1+H1
w7vvXtMqeaUzWAbadx9hIHMj6JPoTh29moMBdq/IjpT+19PvHh52sM+PjnfsEiDz
N3FdadAQdffZCwBKZJYxY72gDsihTslEt2hc67YUVra1zPPzpWU=
=r3D0
-----END PGP SIGNATURE-----

--7oe3kubrmby3et2e--
