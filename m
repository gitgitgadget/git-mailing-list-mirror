Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36764175A77
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777418; cv=none; b=tpwA0yGwMM/ENbO/RIZ5MW/0FRDHhuo9A9u0lk7FpENUqQyEzfNGDWbDGqgWQdX4Bb0fuAmrxmR5YNyjAv2WxrhbIJLOLRwH5sbQyZP7MS5UXCuG76SDIR3PCqz4mlaZQktXvZBXApfpE7bduskY2dn34xr2e1ea+HmdiKfA5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777418; c=relaxed/simple;
	bh=xjOn5P64+Gzvvutl1yHLrtQEUKM/bKXbgJCerYqeWBg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hZ+5nV0a+TXnOEvN0hpONEmh6HQuSJcbEoemaDHHE53rJv4zfGG4JbY77Rb9qqOXDOBEPdWaBch25B3zRFEeAm9+1VcHot0FvDR+SSoDtRluDXlGqUpMbWNcJBPNDvzcvPQZEkTkWeMET6XngX3PWyvIGPoIQ2jO2+IKPlvbBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=YlK+Bma7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="YlK+Bma7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780777411; x=1781382211;
	i=johannes.schindelin@gmx.de;
	bh=8o6cQKGUb4NqyNCiPYCvWO++6ERG16cP1R1GKchrfOw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YlK+Bma7ygru2OKDUVmhHFcQ1RfV8Jxhsa27incejcdrcLg6KEyQw90qVrvqkfhv
	 67t1UeKQJz6FsdlMWxFRR83ElUWMFeYc4Mhqu/1VsxIMBEIPBYKjyY2lz5lnhVbqM
	 Tcdv6X+aHixvrta3QB2wW85NtjhjxthT8eZ4VeXfioqgy5GMl5CorSCz00rgX4blv
	 rZVJzUwnQYgwVpWfQZ5QtMCkHe9fbiwi5AJfzB0c0711vlKvFJdl5nnIZ6Q5vWxfY
	 JipfxKgGWq+/ZvRLHUSHTrqDHK9X99E+R7m34jWuSe1A33iSGZoAzDcpMWUJ1Zsal
	 RdJpCeevjCp0lsEABg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1wO1L61Df9-00Gmf1; Sat, 06
 Jun 2026 22:23:31 +0200
Date: Sat, 6 Jun 2026 22:23:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] doc: fix typos via codespell
In-Reply-To: <xmqqzf1dujtf.fsf@gitster.g>
Message-ID: <3398ef40-1547-4324-2cfc-97b9e2b24854@gmx.de>
References: <20260506101631.18127-1-algonell@gmail.com> <20260602111552.6084-1-algonell@gmail.com> <xmqqzf1dujtf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:4AnO9eOenbLEXiSUl8jZ7QmYxlng0CGjlJ5avFFbo8Q4Ae15N6A
 r75nzzi0d8BsVgb/QiE+yXclxL3+tQi2iiRf1bi3YJXm1LyQvsG0pwb8SyuhMp1SAih/iIN
 ihQD/9ZjPww4ZnP0bT5XZvMzflnhNO+FqFF4Gc3/jNgBN/HXyvB+W5pCjQgHnwXCmNdMOpv
 Sj/OQoRh/wZyafR2yZbXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0IYCxpLsOn4=;PQ3ZcYDUp59euJGFvt3pLELehkv
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 6 Jun 2026, Junio C Hamano wrote:

> Andrew Kreimer <algonell@gmail.com> writes:
>=20
> > There are some typos in the documentation, comments, etc.
> > Fix them via codespell.
>
> [...]
>=20
> I'll squash the fix-up I already had into [v2] that I have queued,
> which should be sufficient to get to the state this [v3] should have
> been, I think.

The mechanical nature of these fixes explains another issue: One typo fix
touched two test fixtures which might seem harmless at first, but those
fixtures are littered with checksums that relied on the original
(misspelled) form.

Please adopt this follow-up into ak/typofixes:

=2D- snipsnap --
=46rom 54aa4f7f7adf0c0e02b5463b5f7f64547e80cbce Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 6 Jun 2026 22:09:04 +0200
Subject: [PATCH] svn-test-dumps: restore checksums after the `hapenning` t=
ypo
 fix

b8b38eee85 (doc: fix typos via codespell, 2026-05-31) ran codespell
against the entire tree and rewrote `hapenning` to `happening`
inside the body of `t/t9150/svk-merge.dump` and
`t/t9151/svn-mergeinfo.dump`. Both files are Subversion dump
files: each `Node-path:` block embeds `Text-content-md5` /
`Text-content-sha1` for the new content and, on copy operations,
`Text-copy-source-md5` / `Text-copy-source-sha1` for the source
content as observed at the cited revision. None of those
checksums were updated, so loading the dumps with svnadmin 1.14.5
(present in `ubuntu:rolling`'s CI image) fails immediately with
`E200014: Checksum mismatch for '/trunk/Makefile'` and the two
tests stop before any of the assertions they actually exercise can
run. The CI failure has been visible on every `seen`-based
linux-sha256 / linux-reftable build since 2026-06-02 (the first
run that picked up b8b38eee85).

Because `happening` and `hapenning` have the same length, no
header byte counts need updating; only the embedded checksums do.
Recompute the MD5 and SHA1 of every text body in the two dumps,
and for every `Node-copyfrom-path` consult the path's most
recently defined content to refresh the corresponding
`Text-copy-source-md5` / `Text-copy-source-sha1`. After this,
`svnadmin load -q` accepts both dumps cleanly and t9150 and t9151
get past their setup steps.

This commit only touches the two dump files; the typo correction
in their surrounding human-readable comment is preserved.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t9150/svk-merge.dump     | 10 ++++----
 t/t9151/svn-mergeinfo.dump | 48 +++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
index 6a8ac81b11e6..3c46afc18a65 100644
=2D-- a/t/t9150/svk-merge.dump
+++ b/t/t9150/svk-merge.dump
@@ -71,7 +71,7 @@ Node-kind: file
 Node-action: add
 Prop-content-length: 10
 Text-content-length: 2401
-Text-content-md5: bfd8ff778d1492dc6758567373176a89
+Text-content-md5: d6a3917748b0c09ad85c2783f1d4dac1
 Content-length: 2411
=20
 PROPS-END
@@ -201,7 +201,7 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2465
-Text-content-md5: 16e38d9753b061731650561ce01b1195
+Text-content-md5: 3f413450a7a26596d9e512ee385a9b19
 Content-length: 2465
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -305,7 +305,7 @@ Node-path: trunk/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2521
-Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
+Text-content-md5: 89788781014278d76ff23648b8b08b2d
 Content-length: 2521
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -412,7 +412,7 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2593
-Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
+Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
 Content-length: 2593
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -529,7 +529,7 @@ Node-path: trunk/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2713
-Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
 Content-length: 2713
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index d5e169563745..ad741400104e 100644
=2D-- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -80,8 +80,8 @@ Node-kind: file
 Node-action: add
 Prop-content-length: 10
 Text-content-length: 2401
-Text-content-md5: bfd8ff778d1492dc6758567373176a89
-Text-content-sha1: 103205ce331f7d64086dba497574734f78439590
+Text-content-md5: d6a3917748b0c09ad85c2783f1d4dac1
+Text-content-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
 Content-length: 2411
=20
 PROPS-END
@@ -194,8 +194,8 @@ Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 2
 Node-copyfrom-path: trunk/Makefile
-Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
-Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
+Text-copy-source-md5: d6a3917748b0c09ad85c2783f1d4dac1
+Text-copy-source-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
=20
=20
 Revision-number: 4
@@ -228,8 +228,8 @@ Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 2
 Node-copyfrom-path: trunk/Makefile
-Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
-Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
+Text-copy-source-md5: d6a3917748b0c09ad85c2783f1d4dac1
+Text-copy-source-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
=20
=20
 Revision-number: 5
@@ -254,8 +254,8 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2465
-Text-content-md5: 16e38d9753b061731650561ce01b1195
-Text-content-sha1: 36da4b84ea9b64218ab48171dfc5c48ae025f38b
+Text-content-md5: 3f413450a7a26596d9e512ee385a9b19
+Text-content-sha1: b3cd389d63c5e3af4fe22b7464cf97968662ad1a
 Content-length: 2465
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -359,8 +359,8 @@ Node-path: branches/right/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2521
-Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
-Text-content-sha1: 4f29afd038e52f45acb5ef8c41acfc70062a741a
+Text-content-md5: 89788781014278d76ff23648b8b08b2d
+Text-content-sha1: f52afb2d6230e5a418416b77c3c9ad610edfd202
 Content-length: 2521
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -467,8 +467,8 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2529
-Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
-Text-content-sha1: 2f656677cfec0bceec85e53036ffb63e25126f8e
+Text-content-md5: abcac8d04eb061b0a3053e359e44a2a0
+Text-content-sha1: 866caf95e04809a5ed897aea41075b24833612ea
 Content-length: 2529
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -572,8 +572,8 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2593
-Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
-Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
+Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
+Text-content-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
 Content-length: 2593
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -689,8 +689,8 @@ Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 8
 Node-copyfrom-path: branches/left/Makefile
-Text-copy-source-md5: 5ccff689fb290e00b85fe18ee50c54ba
-Text-copy-source-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
+Text-copy-source-md5: 706d73919e6f319a0e624aa50c8b8b38
+Text-copy-source-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
=20
=20
=20
@@ -761,8 +761,8 @@ Node-path: trunk/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2593
-Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
-Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
+Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
+Text-content-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
 Content-length: 2593
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -942,8 +942,8 @@ Node-path: trunk/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2713
-Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
-Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
+Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
+Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
 Content-length: 2713
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -1166,8 +1166,8 @@ Node-path: branches/left-sub/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2713
-Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
-Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
+Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
+Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
 Content-length: 2713
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -1408,8 +1408,8 @@ Node-path: branches/left/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2713
-Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
-Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
+Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
+Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
 Content-length: 2713
=20
 # -DCOLLISION_CHECK if you believe that SHA1's
=2D-=20
2.54.0.windows.1.10.gd5b8d9bb7af0

