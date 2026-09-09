Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE45361DBA
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931518; cv=none; b=JJPdfSb0qUZxVuMqSIcNwAXpF3RRENjh9svRvaoCroEEGTqw2xysGcREfK2jMRUvnhAJ/QVaVObFkf02xv7D5ZJ15Xb9moQ01n5jMM9JIpijX6FuRK7ORDWGrQWjtsePDZ8/iQJZ2w0fxj7uhykElH6RX6hnSRSQa7wdf4VZKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931518; c=relaxed/simple;
	bh=7dW3oJiyIwafhduVDvOpWhxxSCWP/cu496rc6kcp6NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5Gd6pZ42qDL4nBxvXMlgmaOGWXYs+NMnzfgMdg/W0GIbVO5FbO3g7zgTP84BG9vsXEyRV4UY144EN9Y3kFQB+bSY0homC3y5HPGttTaEgkGWoHO6w0lGiGBqIjoiiy3szEA0/Gw1SghHBKbwUiPboNsTfVMU4TcyJW7UriVEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=OoGcOg+w; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="OoGcOg+w"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6895P78f022874-6895P78h022874
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Sep 2026 08:25:07 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4Anz-00BR8o-7h
	for git@vger.kernel.org;
	Wed, 09 Sep 2026 08:25:07 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 08:25:06 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 57938e3e;
	Wed, 9 Sep 2026 05:25:06 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 2/2] lint-docs: check the guide list in command-list.txt
Date: Wed, 9 Sep 2026 08:25:01 +0300
Message-ID: <20260909052501.8448-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260909052501.8448-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=L2OT0Xj+guN/86ea46VQ7i2R0S8yBX/jZpv2FKLxGo4=;
 b=OoGcOg+wfqiTMmF0YcKbK2SD5wO4t29/D8sx19aBsAkBjyavzGfx86gGugn7B29oY/a2wyAe6ePM
	p4mIfZ7TvWpcj1Gu8TEpNlGf8r0oGya6SX5/A8+Oi6xZNTCw9EQONKPwPszQHrwcO0QW1P1BIACF
	Cg93rfr/c2Em2SCwjwDY7uWutd+xWejAD5x6f+F91o+MEpjcNl42/DlG9BkUkFlyihJPe5tlNXgf
	8PUTfohWJ2DSJ7tK5UguJJVvHvXxBz66HzwHtlithh2pO9PdzYk6CWjjiRS2e1HF02WS4z3zMDDw
	VuNJYCowPBItTCUmdAnwa0CRh/QLhHq47+2jEg==

Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
'gitremote-helpers', 2020-08-05) there has been a comment in
Documentation/Makefile reminding developers to add new guides also to
command-list.txt.  However, there is no linter script to enforce that.

Adapt Documentation/lint-manpages.sh to fill that role.  Extract
MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
against them.  Exempt gitweb.conf(5) from the new linter routine.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    c655855559 (doc: git: list gitdatamodel(7) as a concept guide, 2026-09-05)
    should be merged in to make the new test pass.

 Documentation/Makefile         | 2 ++
 Documentation/lint-manpages.sh | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..203f6a0c31 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,8 @@ MAN7_TXT += gittutorial-2.adoc
 MAN7_TXT += gittutorial.adoc
 MAN7_TXT += gitworkflows.adoc
 
+MAN_GUIDES = $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
+
 HOWTO_TXT += $(wildcard howto/*.adoc)
 
 DOC_DEP_TXT += $(wildcard *.adoc)
diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index a0ea572382..290ebe0947 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -1,21 +1,22 @@
 #!/bin/sh
 
 extract_variable () {
+	file=${2:-../Makefile}
 	(
-		cat ../Makefile
+		cat $file
 		cat <<EOF
 print_variable:
 	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
 EOF
 	) |
-	make -C .. -f - print_variable 2>/dev/null |
+	make -C $(dirname $file) -f - print_variable 2>/dev/null |
 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
 }
 
 check_missing_docs () (
 	ret=0
 
-	for v in $ALL_COMMANDS
+	for v in $ALL_COMMANDS $MAN_GUIDES
 	do
 		case "$v" in
 		git-merge-octopus) continue;;
@@ -29,6 +30,7 @@ check_missing_docs () (
 		git-stage) continue;;
 		git-legacy-*) continue;;
 		git-?*--?* ) continue ;;
+		gitweb.conf) continue ;;
 		esac
 
 		if ! test -f "$v.adoc"
@@ -87,6 +89,7 @@ check_extraneous_docs () {
 BUILT_INS="$(extract_variable BUILT_INS)"
 ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
 EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
+MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
 
 findings=$(
 	if ! check_missing_docs
-- 
ta/command-list-guides-sync-lint

