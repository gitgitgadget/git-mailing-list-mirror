Received: from anthe.w3.org (anthe.w3.org [34.238.48.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71318D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.238.48.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712042; cv=none; b=QdkSAQ5pdMceeNEhXhq7yMSgfRCBB5P/KRJrYO0iJ3nVYDc7HKuZ28vmOq63BJyuuYkGplhQDh5tSdMCKGqhCvN59G3i9WJP4adkjJIxJrZj1jLcq44vLScpDlXb/DtzcmrFsxRhZbNhKQQdOV3SuHMW4y/Dw7e8/MP4zeldIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712042; c=relaxed/simple;
	bh=Y9FhuPhGXB8OS89q6EAlQMwpjFvhdC9kgN8bCpnQPU8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZObQRDLlY9liOiM4jPRir01M+IAL+atfyVdcNf++vLILti7bvgkzug/3PMYDmmNlltZDqCHF8IVtBI2wsAet/7a3MhazLpoWEtHAdPdv7CY/Q51p/vO7f02e0KbymteLtLAdj0m12Cj80TDuEjF+cF+ZIvyjzNp8PxAKThH9ePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w3.org; spf=pass smtp.mailfrom=w3.org; dkim=pass (2048-bit key) header.d=w3.org header.i=@w3.org header.b=aos6yQFG; arc=none smtp.client-ip=34.238.48.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w3.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w3.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w3.org header.i=@w3.org header.b="aos6yQFG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w3.org;
	s=s1; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Cc:Reply-To
	:In-Reply-To:References; bh=tFYxvILqmQI1EgKf/NxEqfuBu/6QvPe+eeuN4a8T7eo=;
	t=1721712040; x=1722576040; b=aos6yQFGowBGcHcOQSEQystUtSu1FUG1BfZ38tNn54Q9TJE
	k8NA3H9pdok7pqsbQZR6gNvSQgtsTcOBJtM+nVaawEJVGhQi6S+j217CZjdgiHzZzOOkOcaojNJ5n
	zNlRJgkX8Fhaiq4u/NFxHj//tr5P7rr2oURpAyAueKSqVAHlG4O3dhetfv6MMbj+bJW0mAg1snuB+
	FBJ+344esZmsrUHHFy4U5hVxITFxJEtzNDEXMBMNatTWBDrziSwsff247r10KGFYqd4w2Xf87XM2g
	bfQoULXOUyB84Z+KiKiiHrLiS0srhQcfXY/ui+09EZCQqGZSUhssBW8MwptASL+Q==;
Received: from ip-10-0-0-242.ec2.internal ([10.0.0.242] helo=spica.w3.internal)
	by anthe.w3.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mike@w3.org>)
	id 1sW7wu-00Eon4-2y;
	Tue, 23 Jul 2024 05:20:32 +0000
Received: from localhost ([::1] helo=spica.w3.internal)
	by spica.w3.internal with esmtp (Exim 4.96)
	(envelope-from <mike@w3.org>)
	id 1sW7wu-009fUz-2n;
	Tue, 23 Jul 2024 05:20:32 +0000
Received: from w3.org ([2001:41c8:51:7e0:fcff:ff:fe00:4635])
	by spica.w3.internal with ESMTPSA
	id KXcgE6A9n2bbKSMANTRr8w
	(envelope-from <mike@w3.org>); Tue, 23 Jul 2024 05:20:32 +0000
Date: Tue, 23 Jul 2024 14:20:30 +0900
From: sideshowbarker <mike@w3.org>
To: git@vger.kernel.org
Subject: Problem: git Notes not discoverable (+proposed solutions)
Message-ID: <Zp89ntYaeFUumaTO@w3.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Nwi/oRxYtFUuOi4"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09) =?utf-8?Q?=28?= =?utf-8?B?8J+Wlg==?=
 compatible; MSIE 6.0; Windows 98)


--5Nwi/oRxYtFUuOi4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

## Problem description

When a project has added git Notes for its commits, git by default doesn=E2=
=80=99t
automatically fetch the Notes; so, the Notes aren=E2=80=99t automatically d=
iscoverable
to contributors who are using =E2=80=9Cgit log=E2=80=9D to read the project=
 commit logs =E2=80=94 and
especially not discoverable to new contributors, or =E2=80=9Ccasual=E2=80=
=9D users of the logs.

A user will see the Notes only if they _already_ know what git Notes are, a=
nd
know that the project uses Notes, and the user knows how to get them.

But the reality is: most users do not even know what git Notes are, and don=
=E2=80=99t
know how to get them if they exist. So most people end up never seeing them.

## Use-case/requirements

For the Ladybird browser project https://github.com/LadybirdBrowser/ladybir=
d/,
Notes for all 62,000+ commits in its repo commit history were recently adde=
d.

And same for the MDN Web Docs project https://developer.mozilla.org/en-US/
and https://github.com/mdn/content/ =E2=80=94 Notes were very-recently adde=
d for all
23,000+ commits in its history. And that case is a relatively high-visibili=
ty
project with a relatively high percentage of new, first-time contributors
submitting patches each month (~33% on average: or ~73 first-time-contribut=
or
patches out of ~361 patches overall that get merged there every month).

(Disclosure: In both cases, I=E2=80=99m the person who added all the Notes=
=E2=80=A6)

The Notes added to those projects provide a variety of relevant GitHub URLs
for each commit =E2=80=94 info that=E2=80=99s generally useful to everybody=
, and not only
useful to say, the project maintainers or the core contributors.

Yet, the projects have no ready way to make the Notes automatically
discoverable/gettable by non-maintainers/core-contributors =E2=80=94 and es=
pecially,
to be easily discoverable by new people showing up to the project.

I realize the projects can update their docs to tell people they can manual=
ly
run =E2=80=9Cgit fetch origin 'refs/notes/*:refs/notes/*'=E2=80=9D to fetch=
 Notes =E2=80=94 or else do
=E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:refs/notes/*'=
=E2=80=9D.

But=E2=80=A6 people don=E2=80=99t always (or often=E2=80=A6) read the docs.

## Patching git: Concrete proposed solutions

I=E2=80=99d be 100% happy to do the work of writing a patch to implement a =
solution
(a git behavior change) for this =E2=80=94 if I could get confirmation that=
 the git
maintainers would actually be open to reviewing such a patch.

As far as what the change would be: I realize this has been brought up
before =E2=80=94 but it seems the obvious solutions are to =E2=80=9Cjust=E2=
=80=9D change git so:

- Proposed solution #1: git auto-fetches all Notes when a repo is first clo=
ned,
  and then auto re-fetches them again for every =E2=80=9Cgit fetch=E2=80=9D=
 or=E2=80=9Cgit pull=E2=80=9D.

  I think that auto-fetching-of-Notes would ideally be the _default_ git
  behavior =E2=80=94 but short of that, at least a new [notes] _option_ for=
 enabling
  that behavior would help. That would seem somewhat more =E2=80=9Capproach=
able=E2=80=9D to
  than =E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:refs/no=
tes/*'=E2=80=9D.

- Proposed solution #2: git checks if a clone lacks Notes vs remote, and em=
its:

  > Your clone is behind the origin remote by N notes. To fetch the notes
  > from the origin remote, run =E2=80=9Cgit fetch origin 'refs/notes/*:ref=
s/notes/*'=E2=80=9D

Either way, I=E2=80=99d be very willing to put work myself into writing up =
a patch.

## Details

The Notes added to both the Ladybird and MDN projects provide a variety of
relevant GitHub URLs for each commit =E2=80=94 info generally useful to eve=
rybody,
and not only useful to say, the project maintainers or core contributors.

For both cases, https://github.com/sideshowbarker/git-gloss/ was used for
adding the Notes. That=E2=80=99s a specialized tool I wrote myself, for add=
ing
GitHub-related Notes which look like this:

  Author: https://github.com/Jon4t4n =F0=9F=94=B0
  Commit: https://github.com/SerenityOS/serenity/commit/9812031a02
  Pull-request: https://github.com/SerenityOS/serenity/pull/20140
  Issue: https://github.com/SerenityOS/serenity/issues/19937
  Reviewed-by: https://github.com/AtkinsSJ =E2=9C=85
  Reviewed-by: https://github.com/nico

That is: for each commit, the Notes include GitHub metadata URLs showing any
GitHub pull-request associated with the commit, along with links to the Git=
Hub
profiles of the pull-request reviewers =E2=80=94 as well any related GitHub=
 issues =E2=80=94
along with including a =E2=80=9Ccanonical=E2=80=9D URL for the commit, and =
a link to the
GitHub profile of the commit author

=F0=9F=94=B0 =E2=80=93 indicates this is author=E2=80=99s first commit to t=
he repo
=E2=9C=85 =E2=80=93 indicates a review approval

I suspect that over time, a lot of other GitHub-based projects may end up
using that tool to add Notes for their project commits =E2=80=94 maybe incl=
uding some
high-profile projects.

So, ideally, it=E2=80=99d be great to be able to avoid every project needin=
g to
separately document that =E2=80=9Cgit fetch origin 'refs/notes/*:refs/notes=
/*'=E2=80=9D or
=E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:refs/notes/*'=
=E2=80=9D are what
people need to do in order to be able to get the Notes.

Instead, ideally, git by default would automatically fetch the Notes for th=
em.
Or, short of that, git would at least emit a message alerting users that No=
tes
exist at the remote, and explaining to users how they can fetch those Notes.

--=20
https://sideshowbarker.github.io/w3c-faq/

--5Nwi/oRxYtFUuOi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE1IdYVkFeY5ZNh0RRh9F0d7w6S5UFAmafPZcACgkQh9F0d7w6
S5XCgRAArah3RQWRKK6sQCkBPeVQIZmNC/TJlh7AgOXs63WgIA/cQk0qqUobY1VI
IA/edb1tqiTf08I7slOBH2SfzPTZVlRpq0t0nBHKlvWIrp8AewgesBxsnOdH3MQd
BmynG5wcSOVDGEQu5ZNE+7hPS55iSzg9P9PMvYupAqtfk0Qhyqk79nhDpjopdTz7
G0Tfnp15qu8gker/nKE9fLsITh1bY9m8s//ZlCWmWs1oD4rXq3AvkiqlRosyf7lS
yKZVkxPRky53Yu6jfdqEm8/pIwVcieMoPNK8dxRKqVmOwaygJRN5bcQAVcmfBhXB
w8s66pdEz1eQloCzjWP6st4WWT/pixHJ7h1fAPBdx2sL3PF34Av4xWiFMhnvFFUB
BvjNzhZR6oOVhfZ3SlvyPXlR9GI+1RFPR0QyfVGLtKvPol7i64WVIWmUeb8ky6ju
oOY42U1OUztcxhl38zZ/5UQSNya5b/7A/w146Q/FKhgYznIKJwBzrEKz8HpE0EEA
SJvpoMnxxKUQQ9+6FvIG5hfyLMuuST366JNc0eOgJKRskeE6DLIS24EJtC9TwNcP
sQ5NVjFIddrPTFMMdSksUeY0WfXtyco2Qoyd8lO5NJO15Qf7UoRK1BKTe4eMOtKg
ocRg1rfu8wpN5NVtYjXtVKn2xLzRNFDwKl2xHSQpbno0Jotpmjc=
=DEJh
-----END PGP SIGNATURE-----

--5Nwi/oRxYtFUuOi4--
