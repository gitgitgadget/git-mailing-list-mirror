Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UfqyldCc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bciBdNIu"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AFBDB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:00:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 152183200B0D
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Dec 2023 02:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364456; x=1702450856; bh=lzTPGchDky
	VlqFZwdrHDmm4zbl4b6mLJEMpQWjwI2Zs=; b=UfqyldCcsxwG8hiBr7yD07q1EX
	XdOoxTZPZdiuJd78JSszYqP+dLfiEqx+WdG84kRuVh3ngZGThn0DcD9EQ8sbCcjo
	Z+FUMRjTmWPnb8ET4ngG41dCnAamadnq+VE13d9uPzuBCi5znTzY3Jk33tQe5Di0
	DBExf9JIi4CDWLBp1qa1OJK/zfcCyIRguFIQASVmtkOQd1j5g01bvgP5kqiaGKNH
	XzDGiE5g+6aC+Kfka2W7lqxCSnNkOrcG7aqQxwSMyN+/QGsUbwlUAW9+91ILjGBW
	C9ZiYBjrw1jokUPeQxPL5GanX8Bzyd+4iGFaDZQ2NGAFdtWO+i1QijXccNqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364456; x=1702450856; bh=lzTPGchDkyVlqFZwdrHDmm4zbl4b
	6mLJEMpQWjwI2Zs=; b=bciBdNIudu/f6kBqd861U8DJskiaWnf2B6KAp6M8AB2j
	La4pdGNM59FmdHiB/rGWSqriHcLIVOCJotnD0zE0Iu09PeCUViqduHe3//1KXQH/
	qUdDoKNnFTZ0iu1ELHZVLMLqNumMlRS7tfegmHhrCIlM1nxpcOxG5xypTi5pLSpi
	MHeG3FVig1eNFlAiQHTOQEDdr1LX3ugrvfic0S3mcQrq8Hr1FvQhChPtclnGwfpT
	gKEZ+i7psjbc9uhyPv6MAG6/CjUTVTkNkv79TyEfZpnh8mudDWIDjVSrxaX3qDVO
	rUUQzAU5cGYUS/My/j0vvK1VR1hM1Mj1UxBMOXxWtg==
X-ME-Sender: <xms:KAV4ZduAhETRewiSs1hArJyh_l6te8ATzgLBFr03mUsbgFZw_-uvjQ>
    <xme:KAV4ZWe7CTR-MNDtMoxF_FFI72e138X0qKq6eJl2Zl2SAo-pvdOXI6EeDq5BRJeN9
    3Q7Sarw9C9BpoNRdA>
X-ME-Received: <xmr:KAV4ZQyt1_JPYzLlqZ9v9IBUxXrrCx2hKMpjy0f4YpN7vFE9JuS2peDWrCxMcifNMDLohzQkVsn80ZC83UgLnJKcmgrg6GYSu-c9N4D3ZUtQt8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KAV4ZUPiQF-FVZ8u0Dzu1An_nIMQ_vOv5hIoJiWzrJgMvZ7Tlx41MQ>
    <xmx:KAV4Zd9M8MWoTNkyuzaM4bORLMtdrQgCnJtk6qcYtEqpBpRviGE33g>
    <xmx:KAV4ZUWx2-xa9GzVJzXItYNXgAgvuiJO6ePCGaayiOkoJNOiC8T0sw>
    <xmx:KAV4ZSJUTT_Z549bxYDOHg4OHJQ21SAWu2AxVPzvNi4No5nUXQwjtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 347863a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:18 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 4/7] builtin/clone: fix bundle URIs with mismatching
 object formats
Message-ID: <3bef564b57ec67ecb54ae8f24396e48ad5967582.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V1GAq2xQM7eAiCcn"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--V1GAq2xQM7eAiCcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We create the reference database in git-clone(1) quite early before
connecting to the remote repository. Given that we do not yet know about
the object format that the remote repository uses at that point in time
the consequence is that the refdb may be initialized with the wrong
object format.

This is not a problem in the context of the files backend as we do not
encode the object format anywhere, and furthermore the only reference
that we write between initializing the refdb and learning about the
object format is the "HEAD" symref. It will become a problem though once
we land the reftable backend, which indeed does require to know about
the proper object format at the time of creation. We thus need to
rearrange the logic in git-clone(1) so that we only initialize the refdb
once we have learned about the actual object format.

As a first step, move listing of remote references to happen earlier,
which also allow us to set up the hash algorithm of the repository
earlier now. While we aim to execute this logic as late as possible
until after most of the setup has happened already, detection of the
object format and thus later the setup of the reference database must
happen before any other logic that may spawn Git commands or otherwise
these Git commands may not recognize the repository as such.

The first Git step where we expect the repository to be fully initalized
is when we fetch bundles via bundle URIs. Funny enough, the comments
there also state that "the_repository must match the cloned repo", which
is indeed not necessarily the case for the hash algorithm right now. So
in practice it is the right thing to detect the remote's object format
before downloading bundle URIs anyway, and not doing so causes clones
with bundle URIs to fail when the local default object format does not
match the remote repository's format.

Unfortunately though, this creates a new issue: downloading bundles may
take a long time, so if we list refs beforehand they might've grown
stale meanwhile. It is not clear how to solve this issue except for a
second reference listing though after we have downloaded the bundles,
which may be an expensive thing to do.

Arguably though, it's preferable to have a staleness issue compared to
being unable to clone a repository altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c             | 48 ++++++++++++++++++-------------------
 t/t5558-clone-bundle-uri.sh | 18 ++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af949..d188650881 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,6 +1266,26 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	refspec_ref_prefixes(&remote->fetch,
+			     &transport_ls_refs_options.ref_prefixes);
+	if (option_branch)
+		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
+				  option_branch);
+	if (!option_no_tags)
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
+
+	refs =3D transport_get_remote_refs(transport, &transport_ls_refs_options);
+
+	/*
+	 * Now that we know what algorithm the remote side is using, let's set
+	 * ours to the same thing.
+	 */
+	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
+	initialize_repository_version(hash_algo, 1);
+	repo_set_hash_algo(the_repository, hash_algo);
+
 	/*
 	 * Before fetching from the remote, download and install bundle
 	 * data from the --bundle-uri option.
@@ -1281,24 +1301,7 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 				bundle_uri);
 		else if (has_heuristic)
 			git_config_set_gently("fetch.bundleuri", bundle_uri);
-	}
-
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
-	refspec_ref_prefixes(&remote->fetch,
-			     &transport_ls_refs_options.ref_prefixes);
-	if (option_branch)
-		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
-				  option_branch);
-	if (!option_no_tags)
-		strvec_push(&transport_ls_refs_options.ref_prefixes,
-			    "refs/tags/");
-
-	refs =3D transport_get_remote_refs(transport, &transport_ls_refs_options);
-
-	if (refs)
-		mapped_refs =3D wanted_peer_refs(refs, &remote->fetch);
-
-	if (!bundle_uri) {
+	} else {
 		/*
 		* Populate transport->got_remote_bundle_uri and
 		* transport->bundle_uri. We might get nothing.
@@ -1319,13 +1322,8 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
-		/*
-		 * Now that we know what algorithm the remote side is using,
-		 * let's set ours to the same thing.
-		 */
-	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, 1);
-	repo_set_hash_algo(the_repository, hash_algo);
+	if (refs)
+		mapped_refs =3D wanted_peer_refs(refs, &remote->fetch);
=20
 	if (mapped_refs) {
 		/*
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 996a08e90c..1ca5f745e7 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -33,6 +33,15 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'clone with path bundle and non-default hash' '
+	test_when_finished "rm -rf clone-path-non-default-hash" &&
+	GIT_DEFAULT_HASH=3Dsha256 git clone --bundle-uri=3D"clone-from/B.bundle" \
+		clone-from clone-path-non-default-hash &&
+	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone with file:// bundle' '
 	git clone --bundle-uri=3D"file://$(pwd)/clone-from/B.bundle" \
 		clone-from clone-file &&
@@ -284,6 +293,15 @@ test_expect_success 'clone HTTP bundle' '
 	test_config -C clone-http log.excludedecoration refs/bundle/
 '
=20
+test_expect_success 'clone HTTP bundle with non-default hash' '
+	test_when_finished "rm -rf clone-http-non-default-hash" &&
+	GIT_DEFAULT_HASH=3Dsha256 git clone --bundle-uri=3D"$HTTPD_URL/B.bundle" \
+		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
+	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 	test_when_finished rm -f trace*.txt &&
=20
--=20
2.43.GIT


--V1GAq2xQM7eAiCcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BSUACgkQVbJhu7ck
PpRDoQ//dXXqixRKdWthoXIW28GpMok+kXl22mqN6ZiZOZqia8NYha5SIUlE5sp8
Cx5wVx1K44zQuC7m2/YymtPh+hiseqsxXN9LAlALfFf/SVsjOp4WhklpsnjmpKhf
YIflXZ74X7yyT9VJ255XfoF9Bq0CyItJR6PAX4TgO8uLlqIhUZ2LXwE4xcKX3EaZ
McRa9dY3MBlVWC/lwINuyL4ysqu2XZ6uKuDyo9GjWJ1jF7mMJUhMY6uXidLKZKsV
XtohH6DNBDjDSnNV7+4FQ5nlrAsjfIkTZQ9PpQxvUqFx/75VmkrUZuWtRDys+fLP
wzbUPH0/GLvCO0z2NtpZREvHpBX9An6P417kXwzr9ne2v/MTB1akcVYy0UhdaIYP
gTmRsDIo4s3/JP+hs8fwIDZRis2l2VPNTO0ZoJQqin1nf2giL4qW9bzs8bO1Y7RY
OvcG0OpCUFoqPrBpo4wjcv+i/KPkT6CxCj/z+zyKYePXeNJf1VgFJ0PR4joNpbj8
AXoSvgf0ozI3Jo5rQSB63gzpnLy/kGOGMvLGLKuf5q17mBI8sWScw+Vutj4ABSpI
7zmKloPkKgoxrGMIWF295+OQWANAcev/vd65Uu0+3un4tCD+ZD3YeBlO5X53QFlp
EJ6ooI1EWUVliG0g8BwxGV2JtrhcO+7BgsVDHA9NfEJQNXzMRq0=
=lQM4
-----END PGP SIGNATURE-----

--V1GAq2xQM7eAiCcn--
