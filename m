Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794687412;
	b=YtrQ5VOTx7+rS43/3nedFqiGCCNalO9O3nmY0m8GUyIVgs8csMvwMjL8sIjxF7msqsMO
	 TwweFBpYeBMWEomrAHVOYXLpa8oWjHD82l7N7hQWBINd63SC6XAzlHfASoNySFOXjg5ai
	 bSjyRQ/VVne13PpAEzG9YcXY/wH9ENrCcdZ8qnnTlWni0g6a+lw8d0+VoGaUQ0ZH/Cc2t
	 QBXln27so1o/jhl20Tq6FhYFyt5RZDrM09mGMfnlkRIeQAcITNRl1vJIH8vSV4V37pnYx
	 HjbcLogZOQWJEuPpIbF82UAIt/aMjPrivNKD0fm5LBiVDrrpqxSyA9o65prfdC88T0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794687412;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UZ4jlrXFs+UGEQAQKGeZTbi0CykQKtJn2fZsP6tKG4U=;
	b=JQFbGKcanz2kc7pULWvHR24bLqYwwOc9m0T19YKgkQonJgTcGOa8yCHe2CzPdyIE8uA0
	 KG60aL3jb6jcgE7SPTt/cvd/AC6Umzy+udG4i3eA+nlD3kxddr+CUk5fSw+D5tcNFL2/k
	 8JqOZci9XZbx/4zwl0Iqv64zHEHjdnOXVgqMMWublB6y1UyR6loXsF9qu2Ueh/uuIMB15
	 HTGMRzQRQjY9wzh6rIitDjF/t52kyXof/Brw0mtoOtKBYAGTKfHSAx2BuRkAZE85tMecc
	 oFHwBAhhXCmkqBJu1MN1qZNI4TXP1ji+qOn2o7xb5+2ixc6ChqU43tygvnIOUfz3UTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NmVMG2Hr;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41A606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA41A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NmVMG2Hr
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AEKGf7l1608829
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 21:16:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1794687402; bh=+ZeB4Sttx+Ykqc87sXRT6hQVB5tuTXGDZ7xPRPC5gMk=;
	h=From:To:Cc:Subject:Date;
	b=NmVMG2HrRgVUYgNj/PLr+l+0AoNq1ZbhRqRReIX1Ke/Ehv14oQjCpsm5nSA3QasTV
	 rQFKhr8O3jWg3XkjaIIDujWvJg5vWSiO5JQ7DaPfmp9TqFhM7OPN9jGTSs1mV9hePK
	 k3O0IXzpbci05AuBKTrSuqnt9TMAuC+QMp/HffmE=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH 1/1] doc/gitcli: minor fixes
Date: Sat, 14 Nov 2026 21:15:44 +0100
Message-ID: <20261114201632.103400-1-dirk@gouders.net>
X-Mailer: git-send-email 2.55.0
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

Fix three details in the gitcli documentation:

Use plural where appropriate and imperative form when rules are
listed.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/gitcli.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 9c4598e29c..6b0a58938a 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -8,7 +8,7 @@ gitcli - Git command-line interface and conventions
 DESCRIPTION
 -----------
 
-This manual describes the convention used throughout Git CLI.
+This manual describes the conventions used throughout Git CLI.
 
 Many commands take revisions (most often "commits", but sometimes
 "tree-ish", depending on the context and command) and paths as their
@@ -28,7 +28,7 @@ arguments.  Here are the rules:
    `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
    are paths.
 
- * When an argument can be misunderstood as either a revision or a path,
+ * When arguments can be misunderstood as either a revision or a path,
    they can be disambiguated by placing `--` between them.
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
@@ -76,8 +76,8 @@ you will.
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 
- * Splitting short options to separate words (prefer `git foo -a -b`
-   to `git foo -ab`, the latter may not even work).
+ * Split short options to separate words: prefer `git foo -a -b`
+   to `git foo -ab` (the latter may not even work).
 
  * When a command-line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
-- 
2.55.0

