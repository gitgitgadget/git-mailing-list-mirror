Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6A125BB
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RnAVttu3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDPB1R2G"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A0A6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 645483200A0E;
	Tue, 31 Oct 2023 04:16:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 Oct 2023 04:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740180; x=1698826580; bh=hD
	2reD7nwLokJDCvVWxGcYUGVdk3HjvYWr3ciuUtZS8=; b=RnAVttu3BaDLho7B0b
	ZWNHbuuB0RO6J7NPTayV1hU96wpXHEvC8RMrmrfxbIJN2dLg+2cWn1OEWb6nCxlR
	dPeSP2CYwtuYlCG0bCCvetWB6y+ADCVA5XDpictNtWV+cJGOQOl3ewk+sZ10Sb1b
	/oia9aYfINtF/OuEKQwsc3/XGrz00Une920b2s4uVrgU2jQJIUcBiAj3hyanhQoW
	raO9j7bXx+id1fmHvJyLw2EAbpkK0Cpi1S9Nf7w+khyNlLs8xmzQzx1RiF8hQB7L
	rrt+duyiXPrAYikNO2pK2J3mlpCdeRMetP9B3sv+B+7J8XM4MWVW1KdPdGWHJYjf
	tZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740180; x=1698826580; bh=hD2reD7nwLokJ
	DCvVWxGcYUGVdk3HjvYWr3ciuUtZS8=; b=dDPB1R2GWtEE3q234u0rY4swVY0WQ
	iBuLwD3R6hIy7GyytDWxr/RYmKfmxPogVHCrPNh94Njo00V486I8idTGEvkl/9lw
	oSgBkYbpPSvnQ6EkU7Hg6lQzW+aeqDZPwLU7ePejJjwcrw/djWPOJVxEmVotupAo
	ifANwZOCtwz5iZ465VAynNdZvS/Cd42crB46QY48scTApRsBdyUtsd7joVGkOYnL
	kzQVqLnPc1K4Se/tWliD7rqDdrmSTlTEDxUhAhzz81bMOdIJBER/whEOBhXHIEGV
	8mHRduavovXBs8thHNOA9W6EldX7iSM/U5KpYmqrT1Cb9Vs9qvn9kEbXA==
X-ME-Sender: <xms:07dAZYxDJyo8zxaHw7kPhsSfLcP8Pa7ixXa5MLbsokwTchPEGWx2yQ>
    <xme:07dAZcSmbS6ZrRNvDD02MWHv33F7EZY_DYx6yi_eQE-AqoZV53uFqUe23UCTb7re6
    29nTxciCFpKYMNUvQ>
X-ME-Received: <xmr:07dAZaVxlPTyrzqoh6DTMpN2R_H4PCOGGsMJqFviY-p51OnmHpNJYeNoE4PmihpsYF1YKlhD88fL-1ca8WpsKrYvOz8vwhjqsDw_Z2MR_UM0b3Sz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:07dAZWgNTqCK6ShvKw1iCHYMBrw0uTOBEImxeVJQmCGT3XkD6yxyug>
    <xmx:07dAZaDpainaJNj2Df2dTo_PkXWxWroBz_A35QOa07-wN3i13JYEJw>
    <xmx:07dAZXLV0VAWPu8G2AQ53h3V7Yb9z4-ODPEVDOjUZpABNMm0iyVCFg>
    <xmx:1LdAZVO3wEt4SJK4UxCn02gOVmxWiaGSGKQFVTCLIn_WoDMG7V1R3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f3524a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:11 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 02/12] builtin/show-ref: split up different subcommands
Message-ID: <773c611975011dd9db83f900dedff2f3eeb5d473.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NaIcINZzHUbf9n0a"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--NaIcINZzHUbf9n0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While not immediately obvious, git-show-ref(1) actually implements three
different subcommands:

    - `git show-ref <patterns>` can be used to list references that
      match a specific pattern.

    - `git show-ref --verify <refs>` can be used to list references.
      These are _not_ patterns.

    - `git show-ref --exclude-existing` can be used as a filter that
      reads references from standard input, performing some conversions
      on each of them.

Let's make this more explicit in the code by splitting up the three
subcommands into separate functions. This also allows us to address the
confusingly named `patterns` variable, which may hold either patterns or
reference names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 101 ++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7efab14b96c..cad5b8b5066 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -104,7 +104,7 @@ static int add_existing(const char *refname,
  * (4) ignore if refname is a ref that exists in the local repository;
  * (5) otherwise output the line.
  */
-static int exclude_existing(const char *match)
+static int cmd_show_ref__exclude_existing(const char *match)
 {
 	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
@@ -142,6 +142,54 @@ static int exclude_existing(const char *match)
 	return 0;
 }
=20
+static int cmd_show_ref__verify(const char **refs)
+{
+	if (!refs || !*refs)
+		die("--verify requires a reference");
+
+	while (*refs) {
+		struct object_id oid;
+
+		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
+		    !read_ref(*refs, &oid)) {
+			show_one(*refs, &oid);
+		}
+		else if (!quiet)
+			die("'%s' - not a valid ref", *refs);
+		else
+			return 1;
+		refs++;
+	}
+
+	return 0;
+}
+
+static int cmd_show_ref__patterns(const char **patterns)
+{
+	struct show_ref_data show_ref_data =3D {0};
+
+	if (patterns && *patterns)
+		show_ref_data.patterns =3D patterns;
+
+	if (show_head)
+		head_ref(show_ref, &show_ref_data);
+	if (heads_only || tags_only) {
+		if (heads_only)
+			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+		if (tags_only)
+			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+	} else {
+		for_each_ref(show_ref, &show_ref_data);
+	}
+	if (!found_match) {
+		if (verify && !quiet)
+			die("No match");
+		return 1;
+	}
+
+	return 0;
+}
+
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
 	hash_only =3D 1;
@@ -185,56 +233,15 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	struct show_ref_data show_ref_data =3D {0};
-	const char **patterns;
-
 	git_config(git_default_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
 	if (exclude_arg)
-		return exclude_existing(exclude_existing_arg);
-
-	patterns =3D argv;
-	if (!*patterns)
-		patterns =3D NULL;
-
-	if (verify) {
-		if (!patterns)
-			die("--verify requires a reference");
-		while (*patterns) {
-			struct object_id oid;
-
-			if ((starts_with(*patterns, "refs/") || !strcmp(*patterns, "HEAD")) &&
-			    !read_ref(*patterns, &oid)) {
-				show_one(*patterns, &oid);
-			}
-			else if (!quiet)
-				die("'%s' - not a valid ref", *patterns);
-			else
-				return 1;
-			patterns++;
-		}
-		return 0;
-	}
-
-	show_ref_data.patterns =3D patterns;
-
-	if (show_head)
-		head_ref(show_ref, &show_ref_data);
-	if (heads_only || tags_only) {
-		if (heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
-		if (tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
-	} else {
-		for_each_ref(show_ref, &show_ref_data);
-	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
-		return 1;
-	}
-	return 0;
+		return cmd_show_ref__exclude_existing(exclude_existing_arg);
+	else if (verify)
+		return cmd_show_ref__verify(argv);
+	else
+		return cmd_show_ref__patterns(argv);
 }
--=20
2.42.0


--NaIcINZzHUbf9n0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt9AACgkQVbJhu7ck
PpQ5lRAArN+dPkra83wAfWlZPSyDWFPKoj3g+9PJykUNfB2qqauLPEET9togTL84
gTSVq8EWr8CccHKjt8GDFK9K2HBrtBDAuFIIGA9s+2X6Uj/Z834sqBEr2fAWVvMo
aUI+NkyFi1Ram2CFo0dt1IfgOq9gDu5BREQxlPNyZMgTnQC20+a235dO3tlT7ei3
gpvE90c/rIOuwC5V/6wU5PTBJrehvMHS5q2Sx/uMkAXMB0R8j6wrHF5zkS3eqJ0s
xk3hNv7y65vVzcG3oc1T1U7wmQ+/falilrrfKhM5WHnLWhsFV8kdsQudF8VKodCo
2AGa9N03Ap3MN+1O7wmXVYNC6HU0h0BShnmAX+c+XUASuWsDcwbw3RWuw4uusgAI
Q+38Nbh7crhUGQdxiB8D/JwoAWiMteH5KLXLOsYE45tZoD3DS62c/MJ7r0K5qujC
z49lH//c5n1uaHhqKoJD8WJXA2jdV7vlxALAbzUxrQpH8uZwRqWV7jO/GOVcFkM+
JrvYLzlSElhXPjApaXefdWGHl6zopPyikudJ1UUz96nSUcNDeryvkfrb3Kv1QtaB
dC/KJhu9PTu5TuzTlLzi9VYLPAkFMUt2iWHLv5RAmjW6b1zaTpEbnvJ2G8nW7jJP
pFZ+oibEMzX+0uWxPl8zyn8lJ0S2n6U0ELKMlD+pNJGh/Gq6N9Y=
=H/vq
-----END PGP SIGNATURE-----

--NaIcINZzHUbf9n0a--
