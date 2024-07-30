Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2B1A08B5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348032; cv=none; b=h6wsszFkRcohuBSZINp/PMXihq+OSi1Eeohfq1UnsS51aRwECIOyogMpNJN9BMu9LR+Q50gkMJW+kOHy/fKMRADnnTL7nPTpbskoqNGGAS9bfO4YJwveWv28QlrqVbR+zgD762OAlEml3ToJLETvt/SUb1UBFHG/PQB7GY/9ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348032; c=relaxed/simple;
	bh=qp6fNknR1RL7lcr3+F5aiPSZ2pVtsTKcMRxGsJ2/Elk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HPmv86gVhEqjqU4R4jtFTYEnYXuXeLeEfGXf4H5qLg7LlqYxMk/pTjWENxGTiFxOthxmWCUxJvYQVZuY4VzLXQIfOHiz0rxlKnE2ooeh5tCKkbxOh/00j+EWEks6PC1KZcszBrVxsPm4VsVDXis1OX2XOK8xlNgzXRjOyjrgSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MdSQG6e8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MdSQG6e8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348021; x=1722952821; i=l.s.r@web.de;
	bh=SHHOFpleuDt6ILgdpeHiyxhHyqBjbpNM4EPuS/slrVI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MdSQG6e8iKqNkvfgQ464Ap10UMxJCI03QBirCo1y4oZ8oCjQSO1UO4Uer4j/b7bl
	 gKUP7MVELNZlk4ST/4Wp7sQ9ai/2KvvC6nK33aT4Pjoqbmk+ucnLq9mTWJ3O8SqgF
	 dqie3NthTX5XXJ3VWJxUMEnDw2cAiikAvCwCk7PxYJ9KyRgpqUlBnGksvjEPsHu0/
	 TTJ+bBh7DKAo0MGkRRMtDXRUD0ANrqRoSz30NqEet8BTSBgh1LgkLOHUQGeN+bOfR
	 I1O/rBnhhBSRusvzbQVy5yTmPyIgybdmXQg6nekWNWkgb801Vby75lze+pWHhMoh0
	 HDdphEteyzQyCRw/xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1s31se09d7-00edAm; Tue, 30
 Jul 2024 16:00:21 +0200
Message-ID: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>
Date: Tue, 30 Jul 2024 16:00:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t-example-decorate: remove test messages
To: Git List <git@vger.kernel.org>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8j9GHCEAoL3OoaY+aIspRvSQDqAoWPauPzZCNMRnlN5gI1fZBp
 0340C9vSNkZ9PctgckF5EykJePCrY/kWtL51fwN2ZtIfh6EZGfuskVQDyOTHn0LWOnMruGK
 GIslscgGXp+hYK41qyrxyQpswh7bnlDfxy/NIL01xNT/S8Uw26kfEypDwIBA12IDEvQt8yX
 Ld0dRsUIFpz8+vuPyKifA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:99hdruRnXXc=;6IG9sk5xrBRbRhxNuAghRy9UoVI
 MtB8Miy01DVhbJOh7y9daRf6Wp2ZDyPPuf4uO+WvzcBGmv8/1L8SgmQo0B/V+hB4QVj7pu2KC
 3KxSZzDE94JE34WNvzzZXrPJELCpG7A/R5uFvlWHTNZ3LtVt1nbhv4SkQqir5dQ71CiKvj8os
 sj9VNUE0cwYsnRmEe4HDW4ruHgkQu2WS0LH0poKRZkLlRVHoLXUvlz7Xju0It78/W5U6SlSJ8
 S+myLfpv8heArVS+VxTix/a2hIiflBQ5q/GTHYhX2aLJcJhdhdDtGLAkbvHmQETo00rgF5xb8
 +QHebOlZLwsZkr5BBG8CtoBbpFwV1SnhKtkb3jNKFr9KfPYmN11sgqkrNO1M7p6E2l8YRLe6M
 Zr/trpTMHyXFqaf0kFelyGjcM4GZHiauVnRfBMjxHZeTCcymzK4GXT3+Uz16n0GXB7yp0TSd+
 Ttu9jH9SfgUrwqHThlIb1p7PsR06rOoFAutbmI4STcTKE2WfXlUmaywWoqAcPEOO2D2BjpVS9
 L7RvmxmX2T3Y54dlnwQ/j+57pFfdTvEqthNAHQ5t3jPbCdaI/rrb24vWxTzX+PAyqRh5lMrp8
 5HMD/y3jFL1qFU1bZghLRfOzKGmg/fvC/0bH/QmYGvBF3hkBdErXv9XJkIk6xMUkYYrv7AqJE
 rORrt2VJM3VHt/tnykFvsihEHD0s/q879n28bs9Lz4yqdptb3clYyvnpo01JyxcgRVsICfXBz
 KiVrClEos6+HboyZoTA5RhNEtyRkgO1/8v1fPQGk4p9+QNL0bKFBq+y9KLOHCl1rUK4sN/3xU
 2HsRcyReaJKVWVZVi/3RGppw==

The test_msg() calls only repeat information already present in test
descriptions and check definitions, which are shown automatically if
the checks fail.  Remove the redundant messages to simplify the tests
and their output.  Here it is with all of them failing before:

 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:18
 # when adding a brand-new object, NULL should be returned
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:21
 # when adding a brand-new object, NULL should be returned
 not ok 1 - Add 2 objects, one with a non-NULL decoration and one with a N=
ULL decoration.
 # check "ret =3D=3D &vars->decoration_a" failed at t/unit-tests/t-example=
-decorate.c:29
 # when readding an already existing object, existing decoration should be=
 returned
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:32
 # when readding an already existing object, existing decoration should be=
 returned
 not ok 2 - When re-adding an already existing object, the old decoration =
is returned.
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:40
 # lookup should return added declaration
 # check "ret =3D=3D &vars->decoration_b" failed at t/unit-tests/t-example=
-decorate.c:43
 # lookup should return added declaration
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:46
 # lookup for unknown object should return NULL
 not ok 3 - Lookup returns the added declarations, or NULL if the object w=
as never added.
 # check "objects_noticed =3D=3D 2" failed at t/unit-tests/t-example-decor=
ate.c:58
 #    left: 1
 #   right: 2
 # should have 2 objects
 not ok 4 - The user can also loop through all entries.
 1..4

... and here with the patch applied:

 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:18
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:20
 not ok 1 - Add 2 objects, one with a non-NULL decoration and one with a N=
ULL decoration.
 # check "ret =3D=3D &vars->decoration_a" failed at t/unit-tests/t-example=
-decorate.c:27
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:29
 not ok 2 - When re-adding an already existing object, the old decoration =
is returned.
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:36
 # check "ret =3D=3D &vars->decoration_b" failed at t/unit-tests/t-example=
-decorate.c:38
 # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:40
 not ok 3 - Lookup returns the added declarations, or NULL if the object w=
as never added.
 # check "objects_noticed =3D=3D 2" failed at t/unit-tests/t-example-decor=
ate.c:51
 #    left: 1
 #   right: 2
 not ok 4 - The user can also loop through all entries.
 1..4

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-example-decorate.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-de=
corate.c
index a4a75db735..8bf0709c41 100644
=2D-- a/t/unit-tests/t-example-decorate.c
+++ b/t/unit-tests/t-example-decorate.c
@@ -15,36 +15,29 @@ static void t_add(struct test_vars *vars)
 {
 	void *ret =3D add_decoration(&vars->n, vars->one, &vars->decoration_a);

-	if (!check(ret =3D=3D NULL))
-		test_msg("when adding a brand-new object, NULL should be returned");
+	check(ret =3D=3D NULL);
 	ret =3D add_decoration(&vars->n, vars->two, NULL);
-	if (!check(ret =3D=3D NULL))
-		test_msg("when adding a brand-new object, NULL should be returned");
+	check(ret =3D=3D NULL);
 }

 static void t_readd(struct test_vars *vars)
 {
 	void *ret =3D add_decoration(&vars->n, vars->one, NULL);

-	if (!check(ret =3D=3D &vars->decoration_a))
-		test_msg("when readding an already existing object, existing decoration=
 should be returned");
+	check(ret =3D=3D &vars->decoration_a);
 	ret =3D add_decoration(&vars->n, vars->two, &vars->decoration_b);
-	if (!check(ret =3D=3D NULL))
-		test_msg("when readding an already existing object, existing decoration=
 should be returned");
+	check(ret =3D=3D NULL);
 }

 static void t_lookup(struct test_vars *vars)
 {
 	void *ret =3D lookup_decoration(&vars->n, vars->one);

-	if (!check(ret =3D=3D NULL))
-		test_msg("lookup should return added declaration");
+	check(ret =3D=3D NULL);
 	ret =3D lookup_decoration(&vars->n, vars->two);
-	if (!check(ret =3D=3D &vars->decoration_b))
-		test_msg("lookup should return added declaration");
+	check(ret =3D=3D &vars->decoration_b);
 	ret =3D lookup_decoration(&vars->n, vars->three);
-	if (!check(ret =3D=3D NULL))
-		test_msg("lookup for unknown object should return NULL");
+	check(ret =3D=3D NULL);
 }

 static void t_loop(struct test_vars *vars)
@@ -55,8 +48,7 @@ static void t_loop(struct test_vars *vars)
 		if (vars->n.entries[i].base)
 			objects_noticed++;
 	}
-	if (!check_int(objects_noticed, =3D=3D, 2))
-		test_msg("should have 2 objects");
+	check_int(objects_noticed, =3D=3D, 2);
 }

 int cmd_main(int argc UNUSED, const char **argv UNUSED)
=2D-
2.46.0
