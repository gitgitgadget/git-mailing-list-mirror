Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695066;
	b=Eg3geywGrg9vVa89jWz7sg8+FiyKHW7c0luu4uftIN4dh2ld0Uox43fPFgYjzc1NJi/4
	 uxmJCd4y0FZaXug1skZLQbDhTPFIv3jxQ6V4tcQGFbxLaNjfGYdwBtZaxe8Ru57/qi7xm
	 JuwhXB59ymIq5WHqFbMSe8V8fBR3NU7kujjH+V9F2DEpcYX8DtlReWge52JMVXVb8ThLg
	 jXNbhgKWK0AKV+//nceIn/Bl4C4aPnDomZ768Bxpnb+boW/0sLHxvK8/9ye3kZ+O+UZnB
	 8oi0jprdf8sXi1bHWztaC9SISMnxhCakfW6Q/v8QFOHZ4nX8oQY2tX4MOEVlVTGMH2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695066;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ufPlsrffToUcwCtV1n3aUjMSkTIitQ62k8PB5q/ydxk=;
	b=xPB4LzE3VMPDHQYSa0vVB79Mg30F6+ZB5L8YvI2DAFGKeCJKI+3SC2YZeD1LsrMEbqF2
	 S5fLC5EYd5H8FIQ1RnubB3b2wT60oNFUkxfaPrY2rvh/rz5a/pQl5EzNAM5sIrBwtXKK4
	 mxzpqBjThlYNwr0v2uYw6BflRX1askLbqEdB5R9nf6hplJhbcnqzON8K5x/1IN7Ese4PF
	 Qvu4Zv7yuldNQ+w0ehJvXkLpjNYQ3AJh+QrFQGWUwRkpDGrrnEASjrGUzRS0ZDFF0YP82
	 uWbL11nlXbpZ/6+ShHDAuNXxbms63hYAQsV48hBJ06SChChahjSaN90gHHjvOF2mUtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=nlH5CkRo;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9312606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 22:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9312606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=nlH5CkRo
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AEMONlM1613655
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 23:24:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1794695063; bh=SZnAeq1ixxX0Sc6Gb3ZsVhi4xQLhjeL5cuw2HupYd7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlH5CkRo3tCUwGMaxjBK1bmD1mdZxPkeJVsSql2iw7/bzttMvN8wBONSXjlntmLqF
	 rQJYzG6HcUNuvDpFUs8zNB3R7w6SsNZSLDzwfgjB3Jl5ql2CNYU0rv+S9ws/kDVz+/
	 s+ONowjEOQN20xnPGoYgPn+izkFpSjYfykfE+xU4=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v2] doc/gitcli: minor fixes
Date: Sat, 14 Nov 2026 23:23:37 +0100
Message-ID: <20261114222411.105592-1-dirk@gouders.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114201632.103400-1-dirk@gouders.net>
References: <20261114201632.103400-1-dirk@gouders.net>
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

Use plural/singular where appropriate and imperative form when rules
are listed.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/gitcli.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 9c4598e29c..454c482a50 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -8,7 +8,7 @@ gitcli - Git command-line interface and conventions
 DESCRIPTION
 -----------
 
-This manual describes the convention used throughout Git CLI.
+This manual describes the conventions used throughout Git CLI.
 
 Many commands take revisions (most often "commits", but sometimes
 "tree-ish", depending on the context and command) and paths as their
@@ -29,7 +29,7 @@ arguments.  Here are the rules:
    are paths.
 
  * When an argument can be misunderstood as either a revision or a path,
-   they can be disambiguated by placing `--` between them.
+   it can be disambiguated by placing `--` before or after it.
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
    and what I have in the work tree for that file", not "show the difference
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

