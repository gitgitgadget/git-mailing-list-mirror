Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726251;
	b=j1/FF+vJTfq1f1i+GAY3qmPgAHhfTMTwsi/N1A3y+WMlVN75+Q5qzY345hD1pxtBEbvR
	 t3O+/ivUr8heLQCI6BNnTFJAoQLsGA7eBUpe62V9joxM5cQolb0L+rW/w2LtU4jtaKbVB
	 AgHPjdaJMss19wIm9uVbXNCEBacG36hlnKm+wiDQ6ntiHiP8pQW22HZEq7Ptg0Yd+WEoz
	 NFS+0yH7hZySEA8f5Qa/Z716trwZEL3y1abDv+2GZJ/YpebVtHujIWtDc+3/TN8J8559f
	 O0q51ZiuTytEd+X7wnM3ifDHTz56WdroBSqfE6uF7c8N/U+570FdWiZHbldwYWwVVHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726251;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2mFJx3xq4fRi2buRN6qD1Zo0FbGBavZDkfqiZtwXmec=;
	b=tnfXo3cmqvjQ1UgaUusiHzsIATwVVt3DXIvjQBvpC8rgBcWx16TXAxJCfI/vmiUhQUgV
	 C1HPVPy4eTaD5u8T8H8wQd2lCgBAjTXkw7sD6hMQLyUJlE73sAHtriR7SatkXD3PDeJZH
	 BHIesmqGtKyl1qbZNbrd+/ZOjusXpmCZL4b1Q10HWpfGpJhjV69is2oMEuQdrVRDMqqoj
	 J+HC7QZngZet46jwzom5BmpFsmSVvuSb99gI3GJiB5f5MRW89JuBigCDo4rOUMUwPn0zT
	 gXwcpwEWhbvmkcYL1XdidFTuzoccPMh0sdgYBG15qXRtb650tONOB6CW4N5ecONu89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=PHHSO+qs;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4D606A327
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 07:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF4D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=PHHSO+qs
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AF744XU1633632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 08:04:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1794726246; bh=34u2p1Puch0RugiI6M0iIykfD52LcB/oQkXDBA5CLlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHHSO+qskWUJmbE1pRBoTxmVukdq1N/Q/me1wsN3Hc/uBMziKAQANiQC4HaUrmqhI
	 ogqPc+JmPcKmV+lvnpGP0fb6Owatj6An7XEf+onwfR95OJ485xNOV4+QJigB4K/lCw
	 gOFpgUfb3oouqqKEfzGK0dq+euyE6b45ypKyNHHs=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v3] doc/gitcli: minor fixes
Date: Sun, 15 Nov 2026 08:03:37 +0100
Message-ID: <20261115070357.113875-1-dirk@gouders.net>
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
Please disregard v2, I forgot to Cc the reviewer and to add the range-diff.

Changes in v3:
- Resent with proper Cc and range-diff against v1.

Changes in v2:
- Addressed feedback on the second part of the change.

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

Range-diff against v1:
1:  1393397087 ! 1:  7f44bbde6b doc/gitcli: minor fixes
    @@ Commit message
     
         Fix three details in the gitcli documentation:
     
    -    Use plural where appropriate and imperative form when rules are
    -    listed.
    +    Use plural/singular where appropriate and imperative form when rules
    +    are listed.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
    @@ Documentation/gitcli.adoc: gitcli - Git command-line interface and conventions
      Many commands take revisions (most often "commits", but sometimes
      "tree-ish", depending on the context and command) and paths as their
     @@ Documentation/gitcli.adoc: arguments.  Here are the rules:
    -    `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
         are paths.
      
    -- * When an argument can be misunderstood as either a revision or a path,
    -+ * When arguments can be misunderstood as either a revision or a path,
    -    they can be disambiguated by placing `--` between them.
    +  * When an argument can be misunderstood as either a revision or a path,
    +-   they can be disambiguated by placing `--` between them.
    ++   it can be disambiguated by placing `--` before or after it.
         E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
         tree.  Please show changes between the version I staged in the index
    +    and what I have in the work tree for that file", not "show the difference
     @@ Documentation/gitcli.adoc: you will.
      Here are the rules regarding the "flags" that you should follow when you are
      scripting Git:
-- 
2.55.0

