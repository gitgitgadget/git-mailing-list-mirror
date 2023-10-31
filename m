Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982B168B7
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IuXKLp3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1BtKeuI"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B591
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:04:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 80AD432001FC;
	Tue, 31 Oct 2023 05:04:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 05:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743097; x=1698829497; bh=CB
	TC27/gk3SfAJlkjrofJ1X981YGe0tiPYnh8gyQi0U=; b=IuXKLp3APBeF7Cnmh4
	9iUjq0IciS8sEJj8Dm1ACgC5iZjUJOG3LucnKCLPxyPh8akoWRS+C8yeJHnhdgS2
	QlGcLLSoVNw1NhpsQau2n3v+3bEn//v+pl7Thz8YeR3/tkDixYUDj8Fk8e3fR2uC
	Qg+5XFN0seL61fFIjE2/ZM/Q5S2BYLSeubNeX8oEY38uwsiRtYo5qQ8rVl44hP+u
	IXqePzyCh0HdxdBZA90Jueg/3NvA7+grgEyBDiaVf1pL77lZ7fT0O4L6NQLTLWFv
	3YqoTv3s0QuAJHhgEa8hAHmlcIGo8ID49WVUJbF77kYeV5A4ixpHsPyQnaW2L4F0
	hDrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743097; x=1698829497; bh=CBTC27/gk3SfA
	JlkjrofJ1X981YGe0tiPYnh8gyQi0U=; b=k1BtKeuI9Cqxqs3dbCFVco5BqfKv3
	tUGDdWU3SZ31xRLuRvWyzvW2tmz3YDikz1b8yB9Xvs9Ll7APQyRaMQ35L8WRQqKk
	vNQHIYuODmgVRRogAe/EzQQUNAYuZfVv+EVXJA9awpqm0SouuN3GBfCLnE71j4wM
	noPOqaalm8+/UebSWVc4Ug9gNDqnR2rpyefIhJUoAiiT2deiYlveNlPN54pD8xYH
	O1YEFzCaOp215BekETd/AhCMmz8LC+uiigvLksItjNsTMjmaPjBpcGUn3GPdtJsc
	Sus4e1kgJwKn3qsL6nW9dzKhe0CNkxCFWNP8e1Bh1tx4pGgXRaoIok2eg==
X-ME-Sender: <xms:OMNAZXekv6TqAEcTNFNH9uX9el70ApNmDevUWIuq1srwPfrhs-PV5Q>
    <xme:OMNAZdMMBmsMme3ra4MxZrw62dA8jnVJ9e8OAuyfPaqWJ0fTii3IleaYeZm2iaJ21
    0npcK__GJH_H8xd3Q>
X-ME-Received: <xmr:OMNAZQhg_cRRpRyQ3b9_eYOVBa88XyTt41y8NUlazwpGai21CzVP9v9ktXjzh14E4mX1yPBVKpAPmtvN5_MQm4d3Xk9Zplcivps28ICfiLsEv-7F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:OMNAZY9_bED9EJbUkGNtEzIAuwZ1ESMT33KUCYkga13ANzK7y-dSfA>
    <xmx:OMNAZTuO5L6shyG-STc2CXp5FS1UJyFHtkRgWnjpHrMH6HAia778rw>
    <xmx:OMNAZXEtZGhag12J4duJ-xOOQZMDOW3r1sjxPNua0XHME3DQetkZxQ>
    <xmx:OcNAZTJwIFO1fEawMAd0As8ZNYPEKJT5JvQoC95Qi9GFXIRLLhvdVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:04:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd5ebe73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:48 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 4/8] ci: split out logic to set up failed test artifacts
Message-ID: <e15651b3f5d5b7250f73eeb0db33ae1d68cd37c0.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nGRzfMpHV+yemeGW"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--nGRzfMpHV+yemeGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some logic in place to create a directory with the output from
failed tests, which will then subsequently be uploaded as CI artifacts.
We're about to add support for GitLab CI, which will want to reuse the
logic.

Split the logic into a separate function so that it is reusable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b3411afae8e..9ffdf743903 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,6 +131,27 @@ handle_failed_tests () {
 	return 1
 }
=20
+create_failed_test_artifacts () {
+	mkdir -p t/failed-test-artifacts
+
+	for test_exit in t/test-results/*.exit
+	do
+		test 0 !=3D "$(cat "$test_exit")" || continue
+
+		test_name=3D"${test_exit%.exit}"
+		test_name=3D"${test_name##*/}"
+		printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m\=
\n"
+		echo "The full logs are in the 'print test failures' step below."
+		echo "See also the 'failed-tests-*' artifacts attached to this run."
+		cat "t/test-results/$test_name.markup"
+
+		trash_dir=3D"t/trash directory.$test_name"
+		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+	done
+	return 1
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=3D${TERM:-dumb}
=20
@@ -171,25 +192,8 @@ then
 	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=3Dt
 	handle_failed_tests () {
-		mkdir -p t/failed-test-artifacts
 		echo "FAILED_TEST_ARTIFACTS=3Dt/failed-test-artifacts" >>$GITHUB_ENV
-
-		for test_exit in t/test-results/*.exit
-		do
-			test 0 !=3D "$(cat "$test_exit")" || continue
-
-			test_name=3D"${test_exit%.exit}"
-			test_name=3D"${test_name##*/}"
-			printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m=
\\n"
-			echo "The full logs are in the 'print test failures' step below."
-			echo "See also the 'failed-tests-*' artifacts attached to this run."
-			cat "t/test-results/$test_name.markup"
-
-			trash_dir=3D"t/trash directory.$test_name"
-			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-		done
-		return 1
+		create_failed_test_artifacts
 	}
=20
 	cache_dir=3D"$HOME/none"
--=20
2.42.0


--nGRzfMpHV+yemeGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwzUACgkQVbJhu7ck
PpSWZw//TJs5Enj/7MBfLO745OgnAMZBFQmNINTIMHnsVQvYiQ+mn4AWnyXBQeAf
8mSfHJDsAsLyCwV6Jlrcu6E/IIIdfSHYj+WDR1acerUnfUH2m7yDaJXuHFvfS161
UZsGVzUEC/ySdesbEZH0BGvpsVqDbF6KXHnRVr5NF96O2tC9pMJyJ01itCLVwJJE
FK5bZ/BIN1NkyIs9FFgqCiEdpsHl11QO7MbgGgBK5Gd3gudrD3WV5mlecdsg9IpA
8wjVgip2ccuG3iW966CiQIXL7D3h4RldFCR73FvEwISk7Ie0BG5vIu41SZ7Bg3Sx
oLCoj2SmdsPy0brXPe1gQ2vLrnUdSmdDbXe0HSZdrndfYJq4CObtBsetmqwTIJuL
PhC555VrsMyB0YYSfMdTAI5bFq30pV+CRuBX1wr1dvXOY+2tcOCf8GQjLltsGAci
rHQ3OIaqU6amcfajuK+BmqajcV9BAxbxc8JFbvkE3OGveOS+K/Qm25JCoib1I7yB
jxDAa1xWkOu2p7aPfi86koOH+IQfMet8XnDJRKkq6ddCygWveIN7CJRGRSE/3Ueb
HJiJUzxiTARlhHNrmM+7m+P90RuJH98ivthLTwyu48G7vAE84/MLBOYhbIydO785
DWaO+jgkC3JIXB7JuxmFdHUttvF00s6dRamZoS7sAjiWS/6uZFE=
=2oyE
-----END PGP SIGNATURE-----

--nGRzfMpHV+yemeGW--
