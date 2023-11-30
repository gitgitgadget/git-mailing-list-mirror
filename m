Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IS7oMXZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIMi5X4P"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467510E2
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:18:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 453145C01A1;
	Thu, 30 Nov 2023 05:18:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 05:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339534; x=1701425934; bh=WA
	Gn675Hty3eTMwM9Ze/XFsoPTIWfeUycD+5JfOGDHE=; b=IS7oMXZlRGCoDJVCmc
	sWEbIqLAVLTFC3htNRn8T0eJSAkYORnnpf3PcndXLXs6eEt/qgaQPhEYNqpi8tGq
	0SyR1QyefcwE9ys5OWouNisoDrK9/ZDNtdk9aznAaDJWVfqR5UM3Hg2xsd5Rn7Ef
	NhUIvmTYpuzM9P2XQC+zHYUFgctC6R/MHUidOOAHza/8yq1PNXIvBFKmNLR4x81K
	U8msFLokYjoPEfTDrxsTuOURNkGWYYbQb5qHncpAEBy/VJWi2eR6OIXvG7JGCOGr
	Mjexx8c/VHzo65G2amJQIU9nksJIviE9torelz1MPiq6YwhQfZSiWiH6ieXM4b8a
	MsHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339534; x=1701425934; bh=WAGn675Hty3eT
	MwM9Ze/XFsoPTIWfeUycD+5JfOGDHE=; b=UIMi5X4PgDtBBi30jFtRrZERxVqXZ
	2jqGgWZxaFOcRiWDZI1R2b/OL3mHs5DcAkwiow2fqlVXASC9mYL6W/kgyZWlFEof
	wRzgNHjfVzPJUKvxpfBjhQMdu3QhIS6zLDGFc0R5rA98lxsdqvL9gIy1dzmDcAC2
	9dktQoKC7l1bFPQOzoMHcVCND5bLsLAILAVhtj42xJSHqN8NzwDqMcdmmewvVpKX
	aamNd6qZApcYSsoAmvMAudaKg3ICxGrVPTAx19AXsNOAWwZ+oE0dXVqLD606ItbA
	F/vDX+0ab0plTjVDlQFcNMW4sGblnc9gvhCuUVAvmx5D4ymZKWZpjAuyA==
X-ME-Sender: <xms:jmFoZbqGQDky1N3nNocRYm00JuAVojINqep4TgAYMb_rMt1GDAaAaA>
    <xme:jmFoZVqV8iDbCwdvfbjJjxObrI7__P1ANhWsVawSxWfZfD5ooZ3toZVAPsADqSVrI
    9ZNC_nmrgmZ5xRAzQ>
X-ME-Received: <xmr:jmFoZYPL0KuzVQ5vQaJqegRJVc-HrLyGbP-gSD4RAbBR_I0iPeYzXDPsxfbyX6gN7IsVb9MtnCYXC0QYZ1pKJVy0wKdskUwv6bGLzonZo0a6s33V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:jmFoZe7EZToEi5WCVQfERcNCI89pR33EmYPszvja2SI5KokgDDvppw>
    <xmx:jmFoZa5x7nfHLf1N72ENKB6V4sepaWaDQ0u6zTTA83BJ7sm3qBuFhQ>
    <xmx:jmFoZWhX93v01dGqBct_PCjLpdZxxB_oA7pTgsOVEfY-5UgepjJGpQ>
    <xmx:jmFoZaHGSMssKy3B7JXw0S_jTQ3qryrrDqeUsmZDQINsppjOFCGDNg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02767ed8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:40 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/24] midx: implement `--retain-disjoint` mode
Message-ID: <ZWhhi15VpeCRflDB@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UzEDUdrRWq9NKuWp"
Content-Disposition: inline
In-Reply-To: <3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com>


--UzEDUdrRWq9NKuWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:13PM -0500, Taylor Blau wrote:
> Once multi-pack reachability bitmaps learn how to perform pack reuse
> over the set of disjoint packs, we will want to teach `git repack` to
> evolve the set of disjoint packs over time.
>=20
> To evolve the set of disjoint packs means any new packs made by `repack`
> should be disjoint with respect to the existing set of disjoint packs so
> as to be able to join that set when updating the multi-pack index.
>=20
> The details of generating such packs will be left to future commits. But
> any new pack(s) created by repack as disjoint will be marked as such by
> passing them over `--stdin-packs` with the special '+' marker when
> generating a new MIDX.
>=20
> This patch, however, addresses the question of how we retain the
> existing set of disjoint packs when updating the multi-pack index. One
> option would be for `repack` to keep track of the set of disjoint packs
> itself by querying the MIDX, and then adding the special '+' marker
> appropriately when generating the input for `--stdin-packs`.
>=20
> But this is verbose and error-prone, since two different parts of Git
> would need to maintain the same notion of the set of disjoint packs.
> When one disagrees with the other, the set of so-called disjoint packs
> may actually contain two or more packs which have one or more object(s)
> in common, making the set non-disjoint.
>=20
> Instead, introduce a `--retain-disjoint` mode for the `git
> multi-pack-index write` sub-command which keeps any packs which are:
>=20
>   - marked as disjoint in the existing MIDX, and
>=20
>   - not deleted (e.g., they are not excluded from the input for
>     `--stdin-packs`).
>=20
> This will allow the `repack` command to not have to keep track of the
> set of currently-disjoint packs itself, reducing the number of lines of
> code necessary to implement this feature, and making the resulting
> implementation less error-prone.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-multi-pack-index.txt |  8 +++
>  builtin/multi-pack-index.c             |  3 +
>  midx.c                                 | 49 +++++++++++++++
>  midx.h                                 |  1 +
>  t/lib-disjoint.sh                      | 38 ++++++++++++
>  t/t5319-multi-pack-index.sh            | 82 ++++++++++++++++++++++++++
>  6 files changed, 181 insertions(+)
>  create mode 100644 t/lib-disjoint.sh
>=20
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-m=
ulti-pack-index.txt
> index d130e65b28..ac0c7b124b 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -54,6 +54,14 @@ write::
>  		"disjoint". See the "`DISP` chunk and disjoint packs"
>  		section in linkgit:gitformat-pack[5] for more.
> =20
> +	--retain-disjoint::
> +		When writing a multi-pack index with a reachability
> +		bitmap, keep any packs marked as disjoint in the
> +		existing MIDX (if any) as such in the new MIDX. Existing
> +		disjoint packs which are removed (e.g., not listed via
> +		`--stdin-packs`) are ignored. This option works in
> +		addition to the '+' marker for `--stdin-packs`.

I'm trying to understand when you're expected to pass this flag and when
you're expected not to pass it. This documentation could also help in
the documentation here so that the user can make a more informed
decision.

Patrick

>  	--refs-snapshot=3D<path>::
>  		With `--bitmap`, optionally specify a file which
>  		contains a "refs snapshot" taken prior to repacking.
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 0f1dd4651d..dcfabf2626 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -138,6 +138,9 @@ static int cmd_multi_pack_index_write(int argc, const=
 char **argv,
>  			 N_("write multi-pack index containing only given indexes")),
>  		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
>  			     N_("refs snapshot for selecting bitmap commits")),
> +		OPT_BIT(0, "retain-disjoint", &opts.flags,
> +			N_("retain non-deleted disjoint packs"),
> +			MIDX_WRITE_RETAIN_DISJOINT),
>  		OPT_END(),
>  	};
> =20
> diff --git a/midx.c b/midx.c
> index 65ba0c70fe..ce67da9f85 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -721,6 +721,12 @@ static void midx_fanout_add_midx_fanout(struct midx_=
fanout *fanout,
>  					   &fanout->entries[fanout->nr],
>  					   cur_object);
>  		fanout->entries[fanout->nr].preferred =3D 0;
> +		/*
> +		 * It's OK to set disjoint to 0 here, even with
> +		 * `--retain-disjoint`, since we will always see the disjoint
> +		 * copy of some object below in get_sorted_entries(), causing us
> +		 * to die().
> +		 */
>  		fanout->entries[fanout->nr].disjoint =3D 0;
>  		fanout->nr++;
>  	}
> @@ -1362,6 +1368,37 @@ static struct multi_pack_index *lookup_multi_pack_=
index(struct repository *r,
>  	return result;
>  }
> =20
> +static int midx_retain_existing_disjoint(struct repository *r,
> +					 struct multi_pack_index *from,
> +					 struct write_midx_context *ctx)
> +{
> +	struct bitmapped_pack bp;
> +	uint32_t i, midx_pos;
> +
> +	for (i =3D 0; i < ctx->nr; i++) {
> +		struct pack_info *info =3D &ctx->info[i];
> +		/*
> +		 * Having to call `midx_locate_pack()` in a loop is
> +		 * sub-optimal, since it is O(n*log(n)) in the number
> +		 * of packs.
> +		 *
> +		 * When reusing an existing MIDX, we know that the first
> +		 * 'n' packs appear in the same order, so we could avoid
> +		 * this when reusing an existing MIDX. But we may be
> +		 * instead relying on the order given to us by
> +		 * for_each_file_in_pack_dir(), in which case we can't
> +		 * make any such guarantees.
> +		 */
> +		if (!midx_locate_pack(from, info->pack_name, &midx_pos))
> +			continue;
> +
> +		if (nth_bitmapped_pack(r, from, &bp, midx_pos) < 0)
> +			return -1;
> +		info->disjoint =3D bp.disjoint;
> +	}
> +	return 0;
> +}
> +
>  static int write_midx_internal(const char *object_dir,
>  			       struct string_list *packs_to_include,
>  			       struct string_list *packs_to_drop,
> @@ -1444,6 +1481,18 @@ static int write_midx_internal(const char *object_=
dir,
>  	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
>  	stop_progress(&ctx.progress);
> =20
> +	if (flags & MIDX_WRITE_RETAIN_DISJOINT) {
> +		struct multi_pack_index *m =3D ctx.m;
> +		if (!m)
> +			m =3D lookup_multi_pack_index(the_repository, object_dir);
> +
> +		if (m) {
> +			result =3D midx_retain_existing_disjoint(the_repository, m, &ctx);
> +			if (result)
> +				goto cleanup;
> +		}
> +	}
> +
>  	if ((ctx.m && ctx.nr =3D=3D ctx.m->num_packs) &&
>  	    !(packs_to_include || packs_to_drop)) {
>  		struct bitmap_index *bitmap_git;
> diff --git a/midx.h b/midx.h
> index a6e969c2ea..d7ce52ff7b 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -54,6 +54,7 @@ struct multi_pack_index {
>  #define MIDX_WRITE_BITMAP (1 << 2)
>  #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
>  #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
> +#define MIDX_WRITE_RETAIN_DISJOINT (1 << 5)
> =20
>  const unsigned char *get_midx_checksum(struct multi_pack_index *m);
>  void get_midx_filename(struct strbuf *out, const char *object_dir);
> diff --git a/t/lib-disjoint.sh b/t/lib-disjoint.sh
> new file mode 100644
> index 0000000000..c6c6e74aba
> --- /dev/null
> +++ b/t/lib-disjoint.sh
> @@ -0,0 +1,38 @@
> +# Helpers for scripts testing disjoint packs; see t5319 for example usag=
e.
> +
> +objdir=3D.git/objects
> +
> +test_disjoint_1 () {
> +	local pack=3D"$1"
> +	local want=3D"$2"
> +
> +	test-tool read-midx --bitmap $objdir >out &&
> +	grep -A 3 "$pack" out >found &&
> +
> +	if ! test -s found
> +	then
> +		echo >&2 "could not find '$pack' in MIDX"
> +		return 1
> +	fi
> +
> +	if ! grep -q "disjoint: $want" found
> +	then
> +		echo >&2 "incorrect disjoint state for pack '$pack'"
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +# test_must_be_disjoint <pack-$XYZ.pack>
> +#
> +# Ensures that the given pack is marked as disjoint.
> +test_must_be_disjoint () {
> +	test_disjoint_1 "$1" "yes"
> +}
> +
> +# test_must_not_be_disjoint <pack-$XYZ.pack>
> +#
> +# Ensures that the given pack is not marked as disjoint.
> +test_must_not_be_disjoint () {
> +	test_disjoint_1 "$1" "no"
> +}
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index fd24e0c952..02cfddf151 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -3,6 +3,7 @@
>  test_description=3D'multi-pack-indexes'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-chunk.sh
> +. "$TEST_DIRECTORY"/lib-disjoint.sh
> =20
>  GIT_TEST_MULTI_PACK_INDEX=3D0
>  objdir=3D.git/objects
> @@ -1215,4 +1216,85 @@ test_expect_success 'non-disjoint packs are detect=
ed' '
>  	)
>  '
> =20
> +test_expect_success 'retain disjoint packs while writing' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		for i in 1 2
> +		do
> +			test_commit "$i" && git repack -d || return 1
> +		done &&
> +
> +		find $objdir/pack -type f -name "pack-*.idx" |
> +		sed -e "s/^.*\/\(.*\)/\1/g" | sort >packs.old &&
> +
> +		test_line_count =3D 2 packs.old &&
> +		disjoint=3D"$(head -n 1 packs.old)" &&
> +		non_disjoint=3D"$(tail -n 1 packs.old)" &&
> +
> +		cat >in <<-EOF &&
> +		+$disjoint
> +		$non_disjoint
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +		test_must_be_disjoint "${disjoint%.idx}.pack" &&
> +		test_must_not_be_disjoint "${non_disjoint%.idx}.pack" &&
> +
> +		test_commit 3 &&
> +		git repack -d &&
> +
> +		find $objdir/pack -type f -name "pack-*.idx" |
> +		sed -e "s/^.*\/\(.*\)/\1/g" | sort >packs.new &&
> +
> +		new_disjoint=3D"$(comm -13 packs.old packs.new)" &&
> +		cat >in <<-EOF &&
> +		$disjoint
> +		$non_disjoint
> +		+$new_disjoint
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap \
> +			--retain-disjoint <in &&
> +
> +		test_must_be_disjoint "${disjoint%.idx}.pack" &&
> +		test_must_be_disjoint "${new_disjoint%.idx}.pack" &&
> +		test_must_not_be_disjoint "${non_disjoint%.idx}.pack"
> +
> +	)
> +'
> +
> +test_expect_success 'non-disjoint packs are detected via --retain-disjoi=
nt' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		packdir=3D.git/objects/pack &&
> +
> +		test_commit base &&
> +		base=3D"$(echo base | git pack-objects --revs $packdir/pack)" &&
> +
> +		cat >in <<-EOF &&
> +		+pack-$base.idx
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +		test_must_be_disjoint "pack-$base.pack" &&
> +
> +		test_commit other &&
> +		other=3D"$(echo other | git pack-objects --revs $packdir/pack)" &&
> +
> +		cat >in <<-EOF &&
> +		pack-$base.idx
> +		+pack-$other.idx
> +		EOF
> +		test_must_fail git multi-pack-index write --stdin-packs --retain-disjo=
int --bitmap <in 2>err &&
> +		grep "duplicate object.* among disjoint packs" err &&
> +
> +		test_must_fail git multi-pack-index write --retain-disjoint --bitmap 2=
>err &&
> +		grep "duplicate object.* among disjoint packs" err
> +	)
> +'
> +
>  test_done
> --=20
> 2.43.0.24.g980b318f98
>=20

--UzEDUdrRWq9NKuWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYYoACgkQVbJhu7ck
PpSogQ//VVRqVnn4qA/PwmL8WxXrediVUGZnYmE9gny7lGUlSadtyagXEsLMm+d2
E1MrjkFGPFHzNhADjFB0EuC6Ql8LEcxnPi7inGpQYNCb+omEBoHh3nsdINcXw+u0
o6dPMH3ZjcI6Bu9+Ewj1caznwwUzbsrWYBrTArICXtnKtzI5LCJZhAaLF5/kPn2W
HoVM5vaILhIgh9YbsMTEv9Hl8gOOB8UXBTE7kxRBKIc8V6Gy4m/Kec4b3D9lX2/F
sfUKqkUrr2af60c+UqJlD+/X2AQKaz+Zn6w4egJZfzDCEPwVisXD2dldBCAFqBrb
pu7SJ4/SJAyURvCpRYTGsPbwoxAyuuSpGuOazULQVnFeQ7xlj8YApAQwplUoXpio
hJ/aOUVa5UUic63kp54y8CPt6GdN7ZpQ/DVw5/WKYI05ub7lfsBHY6ykrlqmIc1a
7luuniMkT7itENO5SLs/hSTIkPaq4J995vCVJdFiFRu1x4ejzfa+pmNqoc/ZomEP
c8ZelnvhC/r4hvdb6aJ9y8tBTb5WxralIVQN4Qmn/ZRyVpDdP6S35C3qiob3T6n5
wZbDepbVeWAgRkzmconfs9EQetztLpbVD4tEQl2AkT1fvBSviOaqUeivf5I9p7Ba
I7wovcMRoDuJ4MEjykTqfHVEqayBoxqNykt6O1oJLvI4tTzL1Xw=
=YO5v
-----END PGP SIGNATURE-----

--UzEDUdrRWq9NKuWp--
