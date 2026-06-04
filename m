Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03321FF23
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578947; cv=none; b=byzXw8b4FHQ/wNHdn3oUnX7XJg0SVUyLr7+uxndpLqfvpjqNG0QNmQKkxZp4K/9HM0tKsjzSd7iVYvs6uJjCzWw1Wsy66Dy0RUckOU/sujrs/DCxtnVtjKM8yamnSol3kyizgTdEWgp5LA79e93s87dVLYUSKGdYClB7Gz7947E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578947; c=relaxed/simple;
	bh=x8GeLR6WqWtqHddDjoIoLE6EHG0IXq5948BhSciFeXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdZt+quK+E7K0qocLn1ti/pYY8dRbTIBu04p1EPfAsRou8HSuZLisiB254GCyqMmli/sAOeez9YjOJKu5aIvOPk+Rc1WBwgS/KbFzCX7/v88GRlbh3EDnrpi2/DDPzAVpfFXOyuywtzQvXDp8ZT60eXOdd6pzQoLzv4pug5XQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=jZS7sGVH; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="jZS7sGVH"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 654DFZKO027914-654DFZKQ027914
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 4 Jun 2026 16:15:36 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wV7v5-002n95-OG
	for git@vger.kernel.org;
	Thu, 04 Jun 2026 16:15:35 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 16:15:35 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 9de21626;
	Thu, 4 Jun 2026 13:15:35 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] docs: fix typos
Date: Thu, 4 Jun 2026 16:14:57 +0300
Message-ID: <20260604131457.19215-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=7OmwAQuuR3hfSxsinb1RWOUCHVnkgb/hAtBvxusUf6Q=;
 b=jZS7sGVHebB68eg/YD/lugpvMOdBRLqqMAK0Rgog9F0SmgDgjsLJdA5wK5tFROf8IvwuWF0Nwc8n
	6o8J0bsJKMuNE4tKPyFe0xWhKzskmQ/PRhbMr9QUNGr27p6VmR5sSIQtUX/OIxjm38r2f33v6bmr
	tO1eBO0Mquvl2+6h1lcFzS4dSOkzjpCfMFgyVylgHFZNF1PcXKEgcnrs5g9DLiJBf2JnIM05fWXV
	ksgmeU46Cr7e9ju42Yddu5yvbJlq7R7RD6sD5k3H8yT7+SDpsOFyYTZqNNGeasGMgmXxMEKVa0Q7
	I1uxAOglMaEKdKC2wEMwcC1IJ3L2BPM51Cuqtw==

Fix some typos and grammar errors in comments and documentation files.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    Written mostly as an exercise on how to submit patches that depend
    on other topics.
    
    $ git log --oneline --first-parent v2.54.0..
    d19e9182ab (HEAD -> ta/typofixes) docs: fix typos
    5a7e9cc03d Merge branch 'ta/approxidate-noon-fix'
    f03649d802 Merge branch 'kh/name-rev-custom-format'
    023a226b4b Merge branch 'jc/neuter-sideband-fixup'
    
    As can be seen, these topics have already graduated to master:
    
    $ git cherry master
    + d19e9182ab097a722e32d459a9a58c8985831e3b

 Documentation/config/sideband.adoc | 2 +-
 Documentation/git-format-rev.adoc  | 2 +-
 date.c                             | 2 +-
 replay.h                           | 2 +-
 t/t9902-completion.sh              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..ff007aeb73 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -13,7 +13,7 @@ sideband.allowControlCharacters::
 		Allow control sequences that move the cursor. This is
 		disabled by default.
 	`erase`::
-		Allow control sequences that erase charactrs. This is
+		Allow control sequences that erase characters. This is
 		disabled by default.
 	`false`::
 		Mask all control characters other than line feeds and
diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index c40d52e9f6..505a52fecc 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -33,7 +33,7 @@ OPTIONS
 The argument `rev` is also accepted.
 
 `text`;; Formats all commit object names found in freeform text. These
-	must the full object names, i.e. abbreviated hexidecimal object
+	must be full object names, i.e. abbreviated hexadecimal object
 	names will not be interpreted.
 +
 Anything that is parsed as an object name but that is not found to be a
diff --git a/date.c b/date.c
index 05b78d852f..014065b419 100644
--- a/date.c
+++ b/date.c
@@ -1074,7 +1074,7 @@ void datestamp(struct strbuf *out)
  *
  * The tm->tm_mday field has an additional logic of using negative values
  * for date adjustments: -2 means yesterday and -3 the day before that,
- * and so on.  The idea is to deref such adjustments until we are sure
+ * and so on.  The idea is to defer such adjustments until we are sure
  * there's no explicit mday specification in the approxidate string.
  */
 static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
diff --git a/replay.h b/replay.h
index 0ab74b9805..90ed299ff0 100644
--- a/replay.h
+++ b/replay.h
@@ -19,7 +19,7 @@ struct replay_revisions_options {
 
 	/*
 	 * Starting point at which to create the new commits; must be a
-	 * committish. References pointing at decendants of `onto` will be
+	 * committish. References pointing at descendants of `onto` will be
 	 * updated to point to the new commits.
 	 */
 	const char *onto;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..7c6db76c9d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2446,7 +2446,7 @@ test_expect_success FUNNYNAMES \
 	>repeated-quoted/2-file &&
 	>repeated-quoted/3\"file &&   # ... and here, too.
 
-	# Still, we shold only list the directory name only once.
+	# Still, we should list the directory name only once.
 	test_path_completion repeated repeated-quoted
 '
 

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
prerequisite-patch-id: f827362e061e199150f149dd36c67664c77406bc
prerequisite-patch-id: e5b32f0b916ec86eab6631b9bd9bafd639191765
prerequisite-patch-id: 567a1832a220b2dbf095796cc8093b526d6a076c
prerequisite-patch-id: aafa4bd4ceb7836a92d28d4c89b57032f74332e9
prerequisite-patch-id: 2e073762fc9dceafcc6f16711bba425384a24305
prerequisite-patch-id: 0aa605f0acdb71aa2eb173fdf3c57713c9561fe2
prerequisite-patch-id: 5163040262c89eed4bcb04228b445d76497c9d58
prerequisite-patch-id: c06c0461bf75ed638214ce98a54bba6578941c10
prerequisite-patch-id: 571fdf3570f30fd41f6d681e99acc37df94d09a3
prerequisite-patch-id: 54e7102e880d24a6b2d22bef9aa90a3078086d4d
prerequisite-patch-id: d829fff1fcc8b6d086fcb6a40c62f835226ae32f
prerequisite-patch-id: d1d8e2f2e274565e1d7437aa5ccfe44c3f3d8355
prerequisite-patch-id: c79ebac6894b9a206f5699e9811e0348e111753d
prerequisite-patch-id: a7750d7d2ec637d906f975f27ba3d03b33a4a34f
prerequisite-patch-id: 083f554bc5e09ae54c6b545628196e11a9e90cea
-- 
2.30.2

