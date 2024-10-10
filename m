Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C374E09
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578470; cv=none; b=thBdr/SzzIZrardHCufT2nxuQ4QrtjnRIyHp0sgdvzPzx3XVoGVim11ltk18HzgZSSsuuWKXBLHV5s5dZ029p48lVg4LV7GcbCWdrY9Yj42oWaopGtUVpgmQmpHEz3trN3/bf6bjynin+0kaB21IwXbswchWrD3o96bUnkt1HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578470; c=relaxed/simple;
	bh=yLPr8mABTU8/SSU5l28Ko0FHa0ZYwGstI1J4BysDfuM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdldBTIbEF7imXAWa0XbDZKHhcC4hQRAiwX2Oa11vkPMQYZcMdKUGyF3FI/kkgjYwogICHPQC/XYf9CblcRsY9WzWSSMv+S7kjV//hxjXayVTmRRKFU3AXy5kLcfWihqvcsHdlFZTZROY5Vo5OmFpFS6KOK974p14Fq2IdstwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hRL6hRpJ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hRL6hRpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728578466; x=1728837666;
	bh=K38ApCRFXRW976Aj3C658xlgbxHTgI/43+vdPs96yb0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hRL6hRpJQEchkUgG7KMPBBW1rur8614pjWeUtp5iimSXSsAjYeJ6zQQSk3opZziV+
	 E9PSRa+65/su3BqD16BH/zFu1sLTz8G4lytyicCZKEhlhjIIpv2wb8+DE9xmxKS51P
	 haMwXmNYfDzx3nPMw3QL8IQ7vsfGDNh8f9u3e1HCkb3shS+BgMW/02koZRF0KLEZme
	 ITkMdryXrAt6hbDiHZDQZFyXFVaXmLCq9wBqrsUtIGDHwN1ydce6h35G6d1V6r9sAg
	 3Ev1Pua87L7ETP1DHITus54ew+T0Ofp0Qn2Z0pDqf8yQqe7hQrYOEcGdeTwm9a6J6w
	 LBFNo+m5PZsWQ==
Date: Thu, 10 Oct 2024 16:41:03 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>
In-Reply-To: <Zwf4PT-vaLX35ELL@ArchLinux>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me> <Zwf4PT-vaLX35ELL@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: c60d9b3c1bcbe33385fa5c90f6b6a8df62633bba
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------82d13f1212e8f46e4a7dec57c459775eeae6b2f61c0450d91711544baeffdf4f"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------82d13f1212e8f46e4a7dec57c459775eeae6b2f61c0450d91711544baeffdf4f
Content-Type: multipart/mixed;boundary=---------------------da7f1fd789add33e68d1d781547fc632

-----------------------da7f1fd789add33e68d1d781547fc632
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Thursday, October 10th, 2024 at 10:52, shejialuo <shejialuo@gmail.com> =
wrote:

> On Mon, Oct 07, 2024 at 10:12:30PM -0500, Caleb White via B4 Relay wrote=
:
> =


> > From: Caleb White cdwhite3@pm.me
> > =


> > This lays the groundwork for the next patch, which needs the backlink
> > returned from infer_backlink() as a `strbuf`. It seemed inefficient to
> > convert from `strbuf` to `char*` and back to `strbuf` again.
> =


> =


> I think here we should first talk about the current behavior of the
> `infer_backlink`:
> =


> `infer_backlink` initializes a "strbuf" for the inferred backlink
> and returns the result with type "char *" by detaching the "strbuf"
> =


> And then you should tell your intention like the following (The reader
> like me does not know what is the intention of the next patch, you shoul=
d
> explicitly mention this).
> =


> Because we decide to link worktrees with relative paths, we need to
> convert the returned inferred backlink "char *" to "strbuf".
> However, it is a bad idea to convert from `strbuf` to `char*` and
> back to `strbuf` again. Instead, we should just let the
> `infer_backlink` to accept the "struct strbuf *" parameter to
> improve efficiency.
> =


> > This refactors infer_backlink() to return an integer result and use a
> > pre-allocated `strbuf` for the inferred backlink path, replacing the
> > previous `char*` return type and improving efficiency.
> =


> =


> I think you should also talk about that you make the
> `repair_worktree_at_path` function to align with above refactor.

Thank you for the feedback, I'll add these changes.

> > if (strbuf_read_file(&actual, gitfile, 0) < 0)
> > @@ -658,17 +657,18 @@ static char *infer_backlink(const char gitfile)
> > id++; / advance past '/' to point at <id> */
> > if (!*id)
> > goto error;
> > - strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id=
);
> > - if (!is_directory(inferred.buf))
> > + strbuf_reset(inferred);
> =


> =


> Question here: should we use `strbuf_reset` here? I want to know the
> reason why you design this. Is the caller's responsibility to clear the
> "inferred" when calling this function?

Yes we should, sure it is the caller's responsibility but this just helps
prevent bugs. There's plenty of functions that reset the strbuf that's
passed to the function before modifying it.


> > + strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id)=
;
> > + if (!is_directory(inferred->buf))
> > goto error;
> > =


> > strbuf_release(&actual);
> > - return strbuf_detach(&inferred, NULL);
> > + return 1;
> > =


> > error:
> > strbuf_release(&actual);
> > - strbuf_release(&inferred);
> > - return NULL;
> > + strbuf_reset(inferred); /* clear invalid path */
> > + return 0;
> > }
> =


> =


> Design question, when calling `infer_backlink` successfully, we will
> return 1, if not, we will return 0. But in the later code, we use the
> "inferred.buf.len" to indicate whether we could get the inferred
> backlink successfully.

Originally, this function call was inside an `if` condition, and it made
sense to keep the boolean return. However, the dependent patch that I late=
r
rebased on refactored this to be a standalone call. I didn't feel like
introducing another variable just to capture the return value when I could
glean the same information from the existing strbuf.

> We have two signals to indicate the success. I think it's a bad idea to
> use "inferred.buf.len". Let me give you an example here:

I don't see a problem with this---the two "signals" are guaranteed to
always be in sync (either the return is 1 and len is > 0, or return is
0 and len is 0). Having the boolean return gives you flexibility in how
you can call the function (if it can be placed inside an if condition).

> struct strbuf inferred_backlink =3D STRBUF_INIT;
> inferred_backlink =3D infer_backlink(realdotgit.buf);
> =


> // What if I wrongly use the following statements?
> strbuf_addstr(&inferred_backlink, "foo");
> =


> if (inferred_backlink.buf.len) {
> =


> }

I'm sorry, but this example doesn't make sense. This will fail to compile
for several reasons:
- infer_backlink() requires two args
- you cannot assign an `int` to a `struct strbuf`
- even if inferred_backlink became an int then the strbuf_addstr()
  would fail because you can't pass an `int*` to a `struct strbuf*`
- `inferred_backlink.buf.len` doesn't exist, it's `inferred_backlink.len`
  (probably just a typo)

> If you insist using "inferred_backlink.buf.len" as the result, this
> function should return `void`. And you should add some comments for this
> function.

I can add comments, and I can change the return type to `void` if there's
consensus, but I really don't see any issue with leaving it as-is.

> > - if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
> > - free(backlink);
> > - backlink =3D inferred_backlink;
> > - inferred_backlink =3D NULL;
> > + if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backli=
nk.buf)) {
> > + strbuf_swap(&backlink, &inferred_backlink);
> > }
> =


> =


> For single line statement after "if", we should not use `{`.

The brackets were introduced by the patch that my series depends on.
I can remove them, but perhaps it would be better to address that
on the dependent patch?

Best,
-----------------------da7f1fd789add33e68d1d781547fc632--

--------82d13f1212e8f46e4a7dec57c459775eeae6b2f61c0450d91711544baeffdf4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnCAORCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAA4Bwf7BzZ+5YGBoM3hESojb2bO4dRIAZC3tMEGkybx6+Y2sowlALBz
yjqX2BXqmO20xOx45D3l6C9oxEMDn/HEcM5VHDP+7iMf81VcwQaVrs10Rmin
EbkUUmQ7j4TtZNCM5F3+sZjbIjT5rtF8JGgJsR1nT2pv9kDaNk8V5gbTKlxv
OImQBKHGsK2CzGS7Jw7eV5MXZkBTsbsD8IB4Bx9NeGNZiQvXyO6YjDSo8fcu
+D0cdXqmO87li+TCk3/5IITS7nzyksUeRUOrSJZbIF3JcBFuRepdJseprOih
qJJ/9d6WKtwZZxZbgK1w4HtzEJ2xg1wkSEkjec8HOE9FWLaxcQ+6nw==
=UdLQ
-----END PGP SIGNATURE-----


--------82d13f1212e8f46e4a7dec57c459775eeae6b2f61c0450d91711544baeffdf4f--

