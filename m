Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE01642A
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BdvIBqlu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBNvoMvl"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2A1BD
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 85EAC5C00EE;
	Fri, 27 Oct 2023 05:25:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 05:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398731; x=1698485131; bh=Jh
	bxNiIWrYEMldIqhWvwWUmCJAKgASppsdAZ7kZ2SIE=; b=BdvIBqluVpfsB38Cb8
	nnIr6VI6O72lsIPF93Ldt/R1ranf9CTklTqXOrUnvP/0GP9eMpF9pA4pNQ2w7m97
	JINfApjKq48tTKsULeyLvWhBXobYJ8CluDToaBHeVUL/3tAGukFRjSQVs7BhwB5/
	m6eiHEocSggCmrqTOhQsRllX2OU8aHclvKFdC0Q5S1wozA9z0I9nc91in2CNUr1R
	XiyaZxXDVN6UVVMESGBEhWa2ANVUVGzHL7sjDzr60ZyAtoDaxkHxh2ZKpsBbRzP7
	HZOqaxB1qUdH9xy8jHd5UUojXxxsPCiiaim/wQlx/AvtnM5YxAbWXzoNs6JkRalg
	rFeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398731; x=1698485131; bh=JhbxNiIWrYEMl
	dIqhWvwWUmCJAKgASppsdAZ7kZ2SIE=; b=bBNvoMvlTni0EHK+uQ0K2zebsxqUj
	Dhg88wA7LrlZaQUpDP8kS1gdcWX1KbspqPA3eJYN+a3in9sbucIfgiLIWO1+C9iw
	dIJtcmIzGXIYdkomrt6wDGUuqyd/vzjXnW/l+Wn6ugoeNk5d5XOBLRaZaMxf10Zx
	IBvRnIPIUI1BoMGpEOqkiRmwVA3maYLf9DEVrWhtUIc1EWMVtY4dA+8HqopkILBU
	dUKEHG+VjQvszi+TE2TZDIJnBI2q7D1y3tGvAiZzqz+hwb5gLOJWz9uGoEcEAFd6
	bn+98MzA2JJL1pl7/jWvCx4uRLW8WSA7fId/THdgs1TYplYN5MBaZTYHg==
X-ME-Sender: <xms:C4I7ZVIr-XDkjlR4coLsW_mIfk46Ex3GBjKPcBONL00tNdMnvJoTnA>
    <xme:C4I7ZRI6kUoip0e-kuYwvu6y9B6FSXsFFo4fmBB5t0QlGJdwEmfOizSkqoSgL9VrK
    myyGvFyp-m8TGl5SQ>
X-ME-Received: <xmr:C4I7Zds9-lUEgCiVYHKwTtsBOCfw4BNWpYd17ANGY4-c0lyz7K3ahbXDI8p-JfI36XzVIjGfCBl0yACGY9F5iPwK41XyDvwm-g20wBJdugbh7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:C4I7ZWaE5qMKdeJMmdc0MaLC6uW-APHHwtdlZHQZQz4vIsakG8toXA>
    <xmx:C4I7ZcbHZaJnwps5k4g3YNqZ0gjtKauMP--eb6UARa76xP2bUlGTRg>
    <xmx:C4I7ZaCPQPbx0zd2WwINeO3PRLGabgHse4IenZzF82taRwgOyOe7Kw>
    <xmx:C4I7ZVAboZ8D8A8tvBFK5wVEC_IgaG02Buoz0azp5tirMNkA6GunFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea2daf2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:19 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 2/5] ci: make grouping setup more generic
Message-ID: <85617ef85773af3e20701c75d227fea04ac6468a.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o0yGV8biBJg+S+kE"
Content-Disposition: inline
In-Reply-To: <cover.1698398590.git.ps@pks.im>


--o0yGV8biBJg+S+kE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make the grouping setup more generic by always calling `begin_group ()`
and `end_group ()` regardless of whether we have stubbed those functions
or not. This ensures we can more readily add support for additional CI
platforms.

Furthermore, the `group ()` function is made generic so that it is the
same for both GitHub Actions and for other platforms. There is a
semantic conflict here though: GitHub Actions used to call `set +x` in
`group ()` whereas the non-GitHub case unconditionally uses `set -x`.
The latter would get overriden if we kept the `set +x` in the generic
version of `group ()`. To resolve this conflict, we simply drop the `set
+x` in the generic variant of this function. As `begin_group ()` calls
`set -x` anyway this is not much of a change though, as the only
commands that aren't printed anymore now are the ones between the
beginning of `group ()` and the end of `begin_group ()`.

Last, this commit changes `end_group ()` to also accept a parameter that
indicates _which_ group should end. This will be required by a later
commit that introduces support for GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index eb384f4e952..b3411afae8e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -14,36 +14,34 @@ then
 		need_to_end_group=3D
 		echo '::endgroup::' >&2
 	}
-	trap end_group EXIT
-
-	group () {
-		set +x
-		begin_group "$1"
-		shift
-		# work around `dash` not supporting `set -o pipefail`
-		(
-			"$@" 2>&1
-			echo $? >exit.status
-		) |
-		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 f=
ile=3D\2,line=3D\3::\1/'
-		res=3D$(cat exit.status)
-		rm exit.status
-		end_group
-		return $res
-	}
-
-	begin_group "CI setup"
 else
 	begin_group () { :; }
 	end_group () { :; }
=20
-	group () {
-		shift
-		"$@"
-	}
 	set -x
 fi
=20
+group () {
+	group=3D"$1"
+	shift
+	begin_group "$group"
+
+	# work around `dash` not supporting `set -o pipefail`
+	(
+		"$@" 2>&1
+		echo $? >exit.status
+	) |
+	sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 fi=
le=3D\2,line=3D\3::\1/'
+	res=3D$(cat exit.status)
+	rm exit.status
+
+	end_group "$group"
+	return $res
+}
+
+begin_group "CI setup"
+trap "end_group 'CI setup'" EXIT
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 #
@@ -287,5 +285,5 @@ esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
=20
-end_group
+end_group "CI setup"
 set -x
--=20
2.42.0


--o0yGV8biBJg+S+kE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7ggcACgkQVbJhu7ck
PpSTkw//aejdOHoL+i3z6nAuQthseef3lUcnylpmQgy+P7hPWDCo74jTKGPKl0RN
GwKWZ5VOEAnWhf22Kn02L+8SMIKr5Qz3h8VmXOj4BpVd7D4o+N3wzk1YAIV0pUNw
ZqX6PlbDtsYCfu9gY61Ns37fBKRvj3lLbm5e9LGG2mnZAYDYSWrCfea5Lga+iHS7
AMTFT4WiExSseO36YHgFiEzDQtaFnA3yZDnv+p6me9wBfD2toeVAluuE44FIemT3
4QY3XBJc/Xbt4bSTiSOK6M9RrecSckuy3RTCPDRSCZ/r9BfUiNYGjVqe6KbbgkSw
BhTeG0RViT2xkmqqC/9dseNzWf6CT78kyv278Il69C8b1VSKiXlwL+A0QgJW55OO
MRLzjvRHNBN45OKkNsWdkV9BUlEcJemWFhwc4g5JfzDtFRYCQreqpOAIjRMqZp50
Q8pw8qkEwdI6pVXOrCs4sWDB3RD9Sd8XbBurmR6TZ57j+n09Wr2qytRIMZGFs0ux
7uMuHJ8AIYjJG5Xq1ig9oKKv8z+0LG+NhiZRn6hsnBe8D0OaB56+PXC+ARbfEhXP
zCnoMfPktObLlX364+jJ0MWcKyIkXn6Ig9SfZIhfIIXReBNB0HivtLKMrVyO8Sfk
DOw0rgSz+va3tQfr00bm75mZnz19g31yqxbETKpKi8SZtqFgXSE=
=PsnY
-----END PGP SIGNATURE-----

--o0yGV8biBJg+S+kE--
