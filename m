Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D9244E8C
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689963; cv=none; b=kD0sraP8+YQpfK8SrOW098xeEE1N58wfUxW0zPiAJVT5CsJWRp1q5ieFqjoW/UtM3v0dnCs8P0l3+7FM16T4en3XmZALhHMgW+syCvp0yx9KjjlK6LUsORGiRhqlzNwg5yq5QalGNShvbiWAlTYemcJ+5rXC30BGIutrCkP0Gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689963; c=relaxed/simple;
	bh=3IYogOlAMOkfIyKy+cuWFFSbx1FwNViEztI8b7CQ66M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9w5piVtO/C72aVwxgD0TyAR5cnsMv60Qd6Vx90OXqDMmlwYNHgwk1r6yLvW9NYxqNDyKTNrwDegpvz4zWVx/CCB7fZ81YiS0AQ8G/mEVCtlrJg9xZnL5i1RxPCT6bfkMQn0TUQx49UV3SI+yeQBXSmk4NXTShdQiUONn9rADaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=YpywWAaD; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="YpywWAaD"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6375D8343AC
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 23:52:33 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:8d3d:d08b:92eb:7d46])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id B10072003C1;
	Fri,  8 Aug 2025 23:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754689945;
	bh=3IYogOlAMOkfIyKy+cuWFFSbx1FwNViEztI8b7CQ66M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpywWAaDLGDMbVWWr5aTdZ9RI2G3nN44cFRkPcJIyTXbJ77Vf3lOqCbpFIKU8YZy9
	 HZKJV1PoXJCP5iWd6ZvX7At3fXxZloiJy7Nk4JXlNEAqsk99vD0ESpXvyPaxNH/mhF
	 l4kEMj5FGn/QrlmESmBaw6FtRkNJrM2SaCWXM6noTgLTATuFyi0jdeDbiOpx1hsoqr
	 0+ptUWuFI6YHWDY2Dk4uthrnQORDBg/HHxRpG9MrM0kZ12fbb4s655FCvOo9j9O5Od
	 sEEOew8LQj0qa7MWUxvuj0hLVYbKftPP7k1VpVjkDXrHrzcq2es6pbnyzIQnTQZNhV
	 YBLb12GFVCSJg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH v2 3/6] doc: check for absence of multiple terms in each entry of
 desc list
Date: Fri, 08 Aug 2025 23:52:23 +0200
Message-ID: <5911457.DvuYhMxLoT@cayenne>
In-Reply-To: <878qjxi7oz.fsf@gmail.com>
References:
 <pull.1945.git.1754399033.gitgitgadget@gmail.com>
 <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
 <878qjxi7oz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 6 August 2025 03:02:04 CEST Collin Funk wrote:
> Hi,
>=20
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > Due to portability issues, the script generate-configlist.sh was fixed =
to
> > not use carriage returns in the output. However, the result is that it =
no
> > longer correctly handles multiple terms in a single entry of the=20
definition
> > list.
> >=20
> > We now check that these entries do not exist in the documentation.
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/Makefile                      | 10 +++++++++
> >  Documentation/git-check-attr.adoc           |  3 ++-
> >  Documentation/git-check-ignore.adoc         |  9 +++++---
> >  Documentation/git-http-fetch.adoc           |  4 +++-
> >  Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
> >  Documentation/technical/api-path-walk.adoc  |  5 ++++-
> >  shared.mak                                  |  1 +
> >  7 files changed, 50 insertions(+), 6 deletions(-)
> >  create mode 100755 Documentation/lint-documentation-style.perl
>=20
> I documented that this was the correct way to format them in
> CodingGuidelines. At the time I commented that there were some places
>=20
> that didn't follow this rule. Junio replied [1]:
> > We are updating them gradually while avoiding collisions with
> > patches that do other "real" work; see many recent patches to
> > Documentation/config/ area by Jean-No=C3=ABl Avila for more, e.g.
> > d30c5cc4 (doc: convert git-mergetool options to new synopsis style,
> > 2025-05-25).
>=20
> As long as he is okay with the change, this looks good to me. It isn't
> that many changes, so hopefully it is. :)
>=20
> Small nit, but the issue was '\n' not being interpreted as a newline in
> sed's s command. Mentioning carriage return makes me think of '\r'.
>=20
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>=20
> Collin

As a matter of fact, the script did not check config description files, but=
=20
only root man pages. Will also push this change in the next iteration.

Thanks

Jean-No=C3=ABl



