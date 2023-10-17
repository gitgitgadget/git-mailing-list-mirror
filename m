Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541473D963
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u4uB4zzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kh6aMsjq"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377BFF
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 34DC43200ABE;
	Tue, 17 Oct 2023 04:45:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 04:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532327; x=1697618727; bh=dy
	tYIpeqmicJJhDhhyOMeyIPf14iy3CI3tnp1qEN8ZU=; b=u4uB4zzQfbS4nXZay5
	WOtkrR9QREdIsGPi96/0ACqmQhsYlMT24+WGu9AwQrpQqkF358b0QaAb/J+ehfV0
	VVK7JAf6lnIcnRbqxPFQTuj9o14P2aebBgpN3CX/T1u9yHh0+h2ldp4EhUiLqCrR
	o0N8ygRIqlXPPIAXY9rTeqsGReY2RnV/IPWks4lTQydiDb5m6KdFXsgBqtSIIyMt
	m1iK61PW8p4/pdzZhGNRZkypts/UdI8oRvBdoON2QbB3umYig1PKXkA+KDP3y473
	LbCuV82Ov8VqOxhxDUpWzDaEwupkpymRFSQn3InQn6zST8OUwgxD0H17yiLWTcGY
	MdEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532327; x=1697618727; bh=dytYIpeqmicJJ
	hDhhyOMeyIPf14iy3CI3tnp1qEN8ZU=; b=Kh6aMsjqOqX23YBT3U4CyooO72q0d
	lN0wYVHf/Y7pfotezTywYmfXLkUPp8tzHMFdg+2+EkiRVCnbdAuOmSyI7R4AVyAz
	ELFJvCggqysJrfqVw1RABLknIP6lAeBpdIoFXn24Ic7t5031+tbzqZ4h2BX/7tYz
	V6xPKTmB3XYoikuZTeE+fFcLhpY7WL9P/thVaphnGuAgMByyuKS6/FfoENfJLbTI
	LsxmBh78qogh6KKg/DZPzD/KCi7PYkeQqYbDC6W0S/Qsmg6Bo+D32SAp7ZjPM6fO
	bgOywdSoOqYUoGF8DDuHU6Kiuw7hYz637zgyHFXVOspBjevCTB23DOORw==
X-ME-Sender: <xms:p0kuZa5nREYlHb1HM1HmwaycoibOv0iXebgpCic5cPLut8RvilLgsA>
    <xme:p0kuZT6VpCAbriuiKgMnAwDvpdbdIm088lmsaNCMi_dvmUCg_by-SQmXMLGvqJwyk
    0hfFOrEeHPGbrP_VA>
X-ME-Received: <xmr:p0kuZZeXsRSZqSiyvsPL9ZXWd4sMTes4pNaH1CzMChazqHPr-P5BGA6-z72eWckQj6NhcjfIdRAIr7fTlBympDIcDYuuPRFw0l_QbXLEmhDBVCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephfffjeeuheevvdfhueehfefftdelffeiue
    ehleduieelgfefudejhfevhfeitdeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdp
    fihikhhiphgvughirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:p0kuZXKh5lMd42JB-Ue8sa3rey3B6WIeMXi_I8mSAgtWEHyj1fEIVg>
    <xmx:p0kuZeLtmttfwH33DDv2EuRIJzjXHF69BKqwnWopaO8IynuTXnUTBg>
    <xmx:p0kuZYzx7nvyayA2m7GYJQc_3fQTEQiDv-WmpgqNTOoqXrof08VMbg>
    <xmx:p0kuZTEjM0oPdgGQPCHuosftRz70tSzGSARmuXjPJBlY-ZhMk8yPCA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d698a1f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:25 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/17] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZS5JpJCw-MY256xo@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <61d44519a5ffaf2c040198cf8d80d05a09de5de5.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="joOqqNNsCa0gKMvo"
Content-Disposition: inline
In-Reply-To: <61d44519a5ffaf2c040198cf8d80d05a09de5de5.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--joOqqNNsCa0gKMvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:49PM -0400, Taylor Blau wrote:
> From: Jonathan Tan <jonathantanmy@google.com>
>=20
> The murmur3 implementation in bloom.c has a bug when converting series
> of 4 bytes into network-order integers when char is signed (which is
> controllable by a compiler option, and the default signedness of char is
> platform-specific). When a string contains characters with the high bit
> set, this bug causes results that, although internally consistent within
> Git, does not accord with other implementations of murmur3 (thus,
> the changed path filters wouldn't be readable by other off-the-shelf
> implementatios of murmur3) and even with Git binaries that were compiled
> with different signedness of char. This bug affects both how Git writes
> changed path filters to disk and how Git interprets changed path filters
> on disk.
>=20
> Therefore, introduce a new version (2) of changed path filters that
> corrects this problem. The existing version (1) is still supported and
> is still the default, but users should migrate away from it as soon
> as possible.
>=20
> Because this bug only manifests with characters that have the high bit
> set, it may be possible that some (or all) commits in a given repo would
> have the same changed path filter both before and after this fix is
> applied. However, in order to determine whether this is the case, the
> changed paths would first have to be computed, at which point it is not
> much more expensive to just compute a new changed path filter.
>=20
> So this patch does not include any mechanism to "salvage" changed path
> filters from repositories. There is also no "mixed" mode - for each
> invocation of Git, reading and writing changed path filters are done
> with the same version number; this version number may be explicitly
> stated (typically if the user knows which version they need) or
> automatically determined from the version of the existing changed path
> filters in the repository.
>=20
> There is a change in write_commit_graph(). graph_read_bloom_data()
> makes it possible for chunk_bloom_data to be non-NULL but
> bloom_filter_settings to be NULL, which causes a segfault later on. I
> produced such a segfault while developing this patch, but couldn't find
> a way to reproduce it neither after this complete patch (or before),
> but in any case it seemed like a good thing to include that might help
> future patch authors.
>=20
> The value in t0095 was obtained from another murmur3 implementation
> using the following Go source code:
>=20
>   package main
>=20
>   import "fmt"
>   import "github.com/spaolacci/murmur3"
>=20
>   func main() {
>           fmt.Printf("%x\n", murmur3.Sum32([]byte("Hello world!")))
>           fmt.Printf("%x\n", murmur3.Sum32([]byte{0x99, 0xaa, 0xbb, 0xcc,=
 0xdd, 0xee, 0xff}))
>   }
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/config/commitgraph.txt |   5 +-
>  bloom.c                              |  69 +++++++++++++++++-
>  bloom.h                              |   8 +-
>  commit-graph.c                       |  32 ++++++--
>  t/helper/test-bloom.c                |   9 ++-
>  t/t0095-bloom.sh                     |   8 ++
>  t/t4216-log-bloom.sh                 | 105 +++++++++++++++++++++++++++
>  7 files changed, 223 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/=
commitgraph.txt
> index 2dc9170622..acc74a2f27 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -15,7 +15,7 @@ commitGraph.readChangedPaths::
> =20
>  commitGraph.changedPathsVersion::
>  	Specifies the version of the changed-path Bloom filters that Git will r=
ead and
> -	write. May be -1, 0 or 1.
> +	write. May be -1, 0, 1, or 2.
>  +
>  Defaults to -1.
>  +
> @@ -28,4 +28,7 @@ filters when instructed to write.
>  If 1, Git will only read version 1 Bloom filters, and will write version=
 1
>  Bloom filters.
>  +
> +If 2, Git will only read version 2 Bloom filters, and will write version=
 2
> +Bloom filters.
> ++
>  See linkgit:git-commit-graph[1] for more information.
> diff --git a/bloom.c b/bloom.c
> index 3e78cfe79d..ebef5cfd2f 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -66,7 +66,64 @@ int load_bloom_filter_from_graph(struct commit_graph *=
g,
>   * Not considered to be cryptographically secure.
>   * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#=
Algorithm
>   */
> -uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
> +uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len)
> +{
> +	const uint32_t c1 =3D 0xcc9e2d51;
> +	const uint32_t c2 =3D 0x1b873593;
> +	const uint32_t r1 =3D 15;
> +	const uint32_t r2 =3D 13;
> +	const uint32_t m =3D 5;
> +	const uint32_t n =3D 0xe6546b64;
> +	int i;
> +	uint32_t k1 =3D 0;
> +	const char *tail;
> +
> +	int len4 =3D len / sizeof(uint32_t);
> +
> +	uint32_t k;
> +	for (i =3D 0; i < len4; i++) {
> +		uint32_t byte1 =3D (uint32_t)(unsigned char)data[4*i];
> +		uint32_t byte2 =3D ((uint32_t)(unsigned char)data[4*i + 1]) << 8;
> +		uint32_t byte3 =3D ((uint32_t)(unsigned char)data[4*i + 2]) << 16;
> +		uint32_t byte4 =3D ((uint32_t)(unsigned char)data[4*i + 3]) << 24;
> +		k =3D byte1 | byte2 | byte3 | byte4;
> +		k *=3D c1;
> +		k =3D rotate_left(k, r1);
> +		k *=3D c2;
> +
> +		seed ^=3D k;
> +		seed =3D rotate_left(seed, r2) * m + n;
> +	}
> +
> +	tail =3D (data + len4 * sizeof(uint32_t));
> +
> +	switch (len & (sizeof(uint32_t) - 1)) {
> +	case 3:
> +		k1 ^=3D ((uint32_t)(unsigned char)tail[2]) << 16;
> +		/*-fallthrough*/
> +	case 2:
> +		k1 ^=3D ((uint32_t)(unsigned char)tail[1]) << 8;
> +		/*-fallthrough*/
> +	case 1:
> +		k1 ^=3D ((uint32_t)(unsigned char)tail[0]) << 0;
> +		k1 *=3D c1;
> +		k1 =3D rotate_left(k1, r1);
> +		k1 *=3D c2;
> +		seed ^=3D k1;
> +		break;
> +	}
> +
> +	seed ^=3D (uint32_t)len;
> +	seed ^=3D (seed >> 16);
> +	seed *=3D 0x85ebca6b;
> +	seed ^=3D (seed >> 13);
> +	seed *=3D 0xc2b2ae35;
> +	seed ^=3D (seed >> 16);
> +
> +	return seed;
> +}
> +
> +static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_=
t len)
>  {
>  	const uint32_t c1 =3D 0xcc9e2d51;
>  	const uint32_t c2 =3D 0x1b873593;
> @@ -131,8 +188,14 @@ void fill_bloom_key(const char *data,
>  	int i;
>  	const uint32_t seed0 =3D 0x293ae76f;
>  	const uint32_t seed1 =3D 0x7e646e2c;
> -	const uint32_t hash0 =3D murmur3_seeded(seed0, data, len);
> -	const uint32_t hash1 =3D murmur3_seeded(seed1, data, len);
> +	uint32_t hash0, hash1;
> +	if (settings->hash_version =3D=3D 2) {
> +		hash0 =3D murmur3_seeded_v2(seed0, data, len);
> +		hash1 =3D murmur3_seeded_v2(seed1, data, len);
> +	} else {
> +		hash0 =3D murmur3_seeded_v1(seed0, data, len);
> +		hash1 =3D murmur3_seeded_v1(seed1, data, len);
> +	}
> =20
>  	key->hashes =3D (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32=
_t));
>  	for (i =3D 0; i < settings->num_hashes; i++)
> diff --git a/bloom.h b/bloom.h
> index 1e4f612d2c..138d57a86b 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -8,9 +8,11 @@ struct commit_graph;
>  struct bloom_filter_settings {
>  	/*
>  	 * The version of the hashing technique being used.
> -	 * We currently only support version =3D 1 which is
> +	 * The newest version is 2, which is
>  	 * the seeded murmur3 hashing technique implemented
> -	 * in bloom.c.
> +	 * in bloom.c. Bloom filters of version 1 were created
> +	 * with prior versions of Git, which had a bug in the
> +	 * implementation of the hash function.
>  	 */
>  	uint32_t hash_version;
> =20
> @@ -80,7 +82,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
>   * Not considered to be cryptographically secure.
>   * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#=
Algorithm
>   */
> -uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
> +uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
> =20
>  void fill_bloom_key(const char *data,
>  		    size_t len,
> diff --git a/commit-graph.c b/commit-graph.c
> index ea677c87fb..db623afd09 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -314,17 +314,26 @@ static int graph_read_oid_lookup(const unsigned cha=
r *chunk_start,
>  	return 0;
>  }
> =20
> +struct graph_read_bloom_data_context {
> +	struct commit_graph *g;
> +	int *commit_graph_changed_paths_version;
> +};
> +
>  static int graph_read_bloom_data(const unsigned char *chunk_start,
>  				  size_t chunk_size, void *data)
>  {
> -	struct commit_graph *g =3D data;
> +	struct graph_read_bloom_data_context *c =3D data;
> +	struct commit_graph *g =3D c->g;
>  	uint32_t hash_version;
> -	g->chunk_bloom_data =3D chunk_start;
>  	hash_version =3D get_be32(chunk_start);
> =20
> -	if (hash_version !=3D 1)
> +	if (*c->commit_graph_changed_paths_version =3D=3D -1) {
> +		*c->commit_graph_changed_paths_version =3D hash_version;
> +	} else if (hash_version !=3D *c->commit_graph_changed_paths_version) {
>  		return 0;
> +	}

In case we have `c->commit_graph_changed_paths_version =3D=3D -1` we lose
the check that the hash version is something that we know and support,
don't we? And while we do start to handle `-1` in the writing path, I
think we don't in the reading path unless I missed something.

> +	g->chunk_bloom_data =3D chunk_start;
>  	g->bloom_filter_settings =3D xmalloc(sizeof(struct bloom_filter_setting=
s));
>  	g->bloom_filter_settings->hash_version =3D hash_version;
>  	g->bloom_filter_settings->num_hashes =3D get_be32(chunk_start + 4);
> @@ -412,10 +421,14 @@ struct commit_graph *parse_commit_graph(struct repo=
_settings *s,
>  	}
> =20
>  	if (s->commit_graph_changed_paths_version) {
> +		struct graph_read_bloom_data_context context =3D {
> +			.g =3D graph,
> +			.commit_graph_changed_paths_version =3D &s->commit_graph_changed_path=
s_version
> +		};
>  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
>  			   &graph->chunk_bloom_indexes);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> -			   graph_read_bloom_data, graph);
> +			   graph_read_bloom_data, &context);
>  	}
> =20
>  	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
> @@ -2441,6 +2454,13 @@ int write_commit_graph(struct object_directory *od=
b,
>  	}
>  	if (!commit_graph_compatible(r))
>  		return 0;
> +	if (r->settings.commit_graph_changed_paths_version < -1
> +	    || r->settings.commit_graph_changed_paths_version > 2) {
> +		warning(_("attempting to write a commit-graph, but "
> +			  "'commitgraph.changedPathsVersion' (%d) is not supported"),
> +			r->settings.commit_graph_changed_paths_version);
> +		return 0;
> +	}
> =20
>  	CALLOC_ARRAY(ctx, 1);
>  	ctx->r =3D r;
> @@ -2453,6 +2473,8 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->write_generation_data =3D (get_configured_generation_version(r) =
=3D=3D 2);
>  	ctx->num_generation_data_overflows =3D 0;
> =20
> +	bloom_settings.hash_version =3D r->settings.commit_graph_changed_paths_=
version =3D=3D 2
> +		? 2 : 1;
>  	bloom_settings.bits_per_entry =3D git_env_ulong("GIT_TEST_BLOOM_SETTING=
S_BITS_PER_ENTRY",
>  						      bloom_settings.bits_per_entry);
>  	bloom_settings.num_hashes =3D git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NU=
M_HASHES",
> @@ -2482,7 +2504,7 @@ int write_commit_graph(struct object_directory *odb,
>  		g =3D ctx->r->objects->commit_graph;
> =20
>  		/* We have changed-paths already. Keep them in the next graph */
> -		if (g && g->chunk_bloom_data) {
> +		if (g && g->bloom_filter_settings) {
>  			ctx->changed_paths =3D 1;
>  			ctx->bloom_settings =3D g->bloom_filter_settings;
>  		}
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index aabe31d724..3cbc0a5b50 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -50,6 +50,7 @@ static void get_bloom_filter_for_commit(const struct ob=
ject_id *commit_oid)
> =20
>  static const char *bloom_usage =3D "\n"
>  "  test-tool bloom get_murmur3 <string>\n"
> +"  test-tool bloom get_murmur3_seven_highbit\n"
>  "  test-tool bloom generate_filter <string> [<string>...]\n"
>  "  test-tool bloom get_filter_for_commit <commit-hex>\n";
> =20
> @@ -64,7 +65,13 @@ int cmd__bloom(int argc, const char **argv)
>  		uint32_t hashed;
>  		if (argc < 3)
>  			usage(bloom_usage);
> -		hashed =3D murmur3_seeded(0, argv[2], strlen(argv[2]));
> +		hashed =3D murmur3_seeded_v2(0, argv[2], strlen(argv[2]));
> +		printf("Murmur3 Hash with seed=3D0:0x%08x\n", hashed);
> +	}
> +
> +	if (!strcmp(argv[1], "get_murmur3_seven_highbit")) {
> +		uint32_t hashed;
> +		hashed =3D murmur3_seeded_v2(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7);
>  		printf("Murmur3 Hash with seed=3D0:0x%08x\n", hashed);
>  	}
> =20
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index b567383eb8..c8d84ab606 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -29,6 +29,14 @@ test_expect_success 'compute unseeded murmur3 hash for=
 test string 2' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'compute unseeded murmur3 hash for test string 3' '
> +	cat >expect <<-\EOF &&
> +	Murmur3 Hash with seed=3D0:0xa183ccfd
> +	EOF
> +	test-tool bloom get_murmur3_seven_highbit >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'compute bloom key for empty string' '
>  	cat >expect <<-\EOF &&
>  	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab=
0|0x771ae004|
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index da67c40134..8f8b5d4966 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -536,4 +536,109 @@ test_expect_success 'version 1 changed-path used wh=
en version 1 requested' '
>  	)
>  '
> =20
> +test_expect_success 'version 1 changed-path not used when version 2 requ=
ested' '
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion 2 &&
> +		test_bloom_filters_not_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 1 changed-path used when autodetect request=
ed' '
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'when writing another commit graph, preserve existin=
g version 1 of changed-path' '
> +	test_commit -C highbit1 c1double "$CENT$CENT" &&
> +	git -C highbit1 commit-graph write --reachable --changed-paths &&
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		echo "options: bloom(1,10,7) read_generation_data" >expect &&
> +		test-tool read-graph >full &&
> +		grep options full >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'set up repo with high bit path, version 2 changed-p=
ath' '
> +	git init highbit2 &&
> +	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
> +	test_commit -C highbit2 c2 "$CENT" &&
> +	git -C highbit2 commit-graph write --reachable --changed-paths
> +'
> +
> +test_expect_success 'check value of version 2 changed-path' '
> +	(
> +		cd highbit2 &&
> +		echo "c01f" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'setup make another commit' '
> +	# "git log" does not use Bloom filters for root commits - see how, in
> +	# revision.c, rev_compare_tree() (the only code path that eventually ca=
lls
> +	# get_bloom_filter()) is only called by try_to_simplify_commit() when t=
he commit
> +	# has one parent. Therefore, make another commit so that we perform the=
 tests on
> +	# a non-root commit.
> +	test_commit -C highbit2 anotherc2 "another$CENT"
> +'
> +
> +test_expect_success 'version 2 changed-path used when version 2 requeste=
d' '
> +	(
> +		cd highbit2 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 2 changed-path not used when version 1 requ=
ested' '
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion 1 &&
> +		test_bloom_filters_not_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 2 changed-path used when autodetect request=
ed' '
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'when writing another commit graph, preserve existin=
g version 2 of changed-path' '
> +	test_commit -C highbit2 c2double "$CENT$CENT" &&
> +	git -C highbit2 commit-graph write --reachable --changed-paths &&
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		echo "options: bloom(2,10,7) read_generation_data" >expect &&
> +		test-tool read-graph >full &&
> +		grep options full >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'when writing commit graph, do not reuse changed-pat=
h of another version' '
> +	git init doublewrite &&
> +	test_commit -C doublewrite c "$CENT" &&
> +	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
> +	git -C doublewrite commit-graph write --reachable --changed-paths &&
> +	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
> +	git -C doublewrite commit-graph write --reachable --changed-paths &&
> +	(
> +		cd doublewrite &&
> +		echo "c01f" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +

With the supposedly missing check in mind, should we also add tests for
currently unknown versions like 3 or -2?

Patrick

>  test_done
> --=20
> 2.42.0.342.g8bb3a896ee
>=20

--joOqqNNsCa0gKMvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSaMACgkQVbJhu7ck
PpRY6g//S1wGk2w9jL7dqNNddUbWklll582m9K7cytaF8einOoGAibQZPixVuGwT
CkYLTDVXLn2kDKrpI8SrSXK3+ZQOCjmffe5Lf7y7xwVwBqRF8rsZyyzEwtTVYB3E
L+AytzpryxqnR6LkyXFn9VLPQ1E5gS0qEwWJesdAy46Em7Mu93R2bypNRI3S5G/a
NgtTfnSm0NJnXitKe0EUAw3/oLmDdBse5GcN9jqsTgTJUNsN7JO3QNjqH5z5bK8G
M0oyGXyub4PVu+ZfogGrwtpgTYYU3Ea0srqhCZbr5z9kfgIs8WRYUHvYT2Em/YfF
QI+GhyRQLxyEbPpsfmcasBX6IO+NZq3eZX9cCKdJkJvKmETJkuYg0Y8LlIUQ/Ddt
KaOtm85MDcpY2MacEx/BkVq6C0Dc8bSmHLycxKOaydDdf0tNVyWd9G74RjjfMUog
EB63t5GBYJQEO53fkpT0jAXO+RZ94gsoxKS7k80hwdo0wshbqD/TSXs6e6lXAupt
x3mVnehwmhUhZGpNgEcTBYY3RsemZW1ltlCcm8kvDiBY3+mgoX7ELa0Za/xDQP/I
8BQ6REmxtwR2+h/Knz7SpthxPm8JMhWo8VL3OuHKPR5bsAWcrz0ZvUIkjXPeQOWf
UF1mkLtOWEvPJppWQ2ynm10cpHUmhV8Q40Sr9JZ8iYiwvku+EPI=
=X05b
-----END PGP SIGNATURE-----

--joOqqNNsCa0gKMvo--
