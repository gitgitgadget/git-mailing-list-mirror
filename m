Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792806046;
	b=rqeW56UI96JZm54ETNXqoT4AVzkMcFtZuL9tHprT0zE51LNIQLKKzxC+YUBx2cNKjfNB
	 lm+Oy0G37n0MQ0uWe5pdlIM/sEhnYhzuox+JmMDy6mLx/MtjCLeOThvJ481Koq9V2jO94
	 VS74Lx4PTCVsBjjBfWRuoFOUMXosISvPzMOUOWp1vNpL43eH8muCPA5gzH3Fk1omRMWMh
	 OicoFTn9CkMPZkPaua3SoWQ/HSXVrJsL2xXJyYSZb63WoCVD6ReQ5IkmZ+WP4NsIlsw5X
	 s62jdnZForr14husD88wjD6e0ZLdUusoJIWJYE6j06HEDP54SbYAhJv/WGrErf7RFtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806046;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=4/6Lq/D0t5MjQ/eB0bvO9NfoH/R8E51fN7h+02SpZ+c=;
	b=ZfQwcyIih7xV+VFDjeTn+U7ALbm9zSnD5JZDqg0rhlB1vJC6aLmiTH/OyRp1qRrjFFtf
	 NeSZ8drPxgpmRoFXPc84cs+66FXdpfR5flo9bykApEnMM6hvfYKeZf3ssxsQDyddletkC
	 k/ScuzL7J+NMxXZdBDwbzQR0lMu8+h18Re9fjrw1K6LDdVbJPHJXlOb1d2gxxZvoPPmRS
	 8xe3Ny+xKYSdZDnFUWkqAjc0+oonqas7XAeoIZI5Tz3gAr4004VIFrJLorRr687U9Fw6S
	 3fvczh3bWJH39YXUjnCogFLtengKZONh9SAJ368p3aW2bE4sb3/Y15+hRlPE1xmBa6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b="G5lb/ti+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C5606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 01:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=G5lb/ti+
ARC-Seal: i=1; a=rsa-sha256; t=1792806028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OkZgyPTQJGcK38IBUvrXuc1HEsKqeddm6lVFKSoFMM2ln1D9fpXFSNarNcK3wCcdhrJ4GscBXednPYuyklflRxJTPao4DUC0yBz4jAus27Vz3XDuFVSWPSUELpalxFeCwgkbKuJrgFw65hXD5g4VgR56uOsAD/FxSj7h7EHRE1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792806028; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4/6Lq/D0t5MjQ/eB0bvO9NfoH/R8E51fN7h+02SpZ+c=; 
	b=FMy6ynaVlVOLw8P7DLX58IQ40xU5FcCZkG8y34j9l3Alsn1fI9oqRnA92C2U8BA0ZeQ+ZuJthFLpvOyvJ3iW52DpKvSYbgqa8g0SUZvt7cQcp7oX1/QrYGQ1l4CDSIt+sgjj3QqIt/n781RInaJRIs3uhX6lN5Wi2TGxH3R8flc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792806028;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4/6Lq/D0t5MjQ/eB0bvO9NfoH/R8E51fN7h+02SpZ+c=;
	b=G5lb/ti+Fa49W0HsF2U2kSHR55xCSuAtkrpQm3Q4/vH5cX4CVIDcnSg/gzrgU6sG
	9hY6HXGR0b48nVh5+fWOSe4X4ZbbBQMBljMdVequzwRWAaLY/3/KLWix/H7cCM2d7EX
	UBhV3gWOYqd4YdLGXAwakccNLZJdgXNILtLXeP3c=
Received: by smtp.zohomail.com with SMTPS id 1792806025050589.3255213039168;
	Fri, 23 Oct 2026 18:40:25 -0700 (PDT)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Sven Weiland <sven.weiland@tngtech.com>
Subject: [PATCH] builtin/reflog: say "would prune" for named refs with --dry-run
Date: Fri, 23 Oct 2026 18:38:50 -0700
Message-ID: <20261024013850.66448-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

With --dry-run --verbose, "git reflog expire --all" reports the entries
it would remove as "would prune", but when refs are named on the command
line it reports them as "prune", which looks as if they were removed:

    $ git reflog expire --dry-run --verbose --expire=now HEAD
    prune commit (initial): first

Nothing is removed in either case, only the label is wrong. This was
reported at [1].

fcd2c3d9d8 (reflog + refs-backend: move "verbose" out of the backend,
2021-12-22) added dry_run to struct expire_reflog_policy_cb and set it
in the --all loop, but not in the loop for named refs. Set it there
too.

Add tests for named refs and --all. No test checked the keep/prune
wording before.

[1] https://lore.kernel.org/git/b46cbce8-d2bb-46d2-bdd3-545422813d6b@tngtech.com/

Reported-by: Sven Weiland <sven.weiland@tngtech.com>
Assisted-by: Claude Sonnet 5.5
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Notes:
    The dry_run bit just duplicates what is already in flags, so every
    caller has to copy it, and one got missed. Dropping it would mean
    changing the callback signature, so I left that alone.

 builtin/reflog.c  |  5 ++++-
 t/t1410-reflog.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1211c58fa4..49e5453dd9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -279,7 +279,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 
 	for (i = 0; i < argc; i++) {
 		char *ref;
-		struct expire_reflog_policy_cb cb = { .opts = opts };
+		struct expire_reflog_policy_cb cb = {
+			.opts = opts,
+			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+		};
 
 		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("reflog could not be found: '%s'"), argv[i]);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 93b5b49e1d..998a7e8667 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -240,6 +240,40 @@ test_expect_success 'reflog expire --dry-run should not touch reflog' '
 	check_fsck "missing blob $F"
 '
 
+# A dry run only ever says "keep" or "would prune".
+check_dry_run_output () {
+	test_grep "^would prune " "$1" &&
+	sed -e "/^keep /d" -e "/^would prune /d" \
+		-e "/^Marking reachable objects/d" "$1" >unexpected &&
+	test_must_be_empty unexpected
+}
+
+test_expect_success 'reflog expire --dry-run --verbose with a named ref' '
+	git reflog refs/heads/main >before &&
+	git reflog expire --dry-run --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		refs/heads/main >output &&
+	check_dry_run_output output &&
+
+	git reflog refs/heads/main >after &&
+	test_cmp before after
+'
+
+test_expect_success 'reflog expire --dry-run --verbose --all' '
+	git reflog refs/heads/main >before &&
+	git reflog expire --dry-run --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all >output &&
+	check_dry_run_output output &&
+
+	git reflog refs/heads/main >after &&
+	test_cmp before after
+'
+
 test_expect_success 'reflog expire' '
 
 	git reflog expire --verbose \
-- 
2.54.0

