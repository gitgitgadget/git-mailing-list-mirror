Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469371;
	b=e5FR4+ZY9m3vbATA3oTGuDuMLRb9Hoza1buHJriQgS+2AFpwS82cjOfckFYrWYOiCc+A
	 GvyQ1gf5BAHUV+E44zEE88m2EW3N5CdqV/Sm1t8MvL9GuIBYNU63tnEVoLk+ItLX/i8Hu
	 IOTA/5iz8o9Ml2a//14FylK/VlUYqJWbB0KAAkFNqK6isGGhkCju6JwP2Y+qF4o/A6KYU
	 Y3mO1/QRiFwacEBxfRT0/oaJyY67eCwL0oiIRScNmJBdlOEMktd/N+klywj6p46QGbA6o
	 qUVQ22BpIKC1+2uJ1uKwmfVsw7qWQkyPGt9ExbyDGSVGlAvGG67hyYXKFRYa5KZtjJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469371;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6L4Px9WycXAsKqB4ef25X62mUOPItwl16q2kxn6xzw4=;
	b=YOwGpT+u6OXxCI+qHphVkfdAYMv2vvEAtjoDFcpJJvHOPqyaJCB8LwBI1uigRq+lYgrh
	 AX9Z4tNGRyNakhH4ri53LzCpvA1GbqbQOojpKGxyqeag6EVcLmavsF5CsvIGGN4VdUjFF
	 XUDQApkQz5aGTjnVkrIHeBFM88B2C4whnI7Ak5O1cIcF4Wa4nByGxRmYHkAd1zerI+iS9
	 9SzV9ddZxz1H4ugVosxSLRXW/+xkCssY5YzhLW8StPONVty5bOvMl0P8vKwUJI2eFMxb6
	 jM79GhJnYyxZsWp7eBxu9/QU/NnUxDKVISuy5rEIH8/WakzYvjZ7Dna7qdUHuUAT+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=kTWU7hGT;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA6606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DA6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=kTWU7hGT
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6ANLTQWG2334997
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 23 Nov 2026 22:29:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795469367; bh=6L4Px9WycXAsKqB4ef25X62mUOPItwl16q2kxn6xzw4=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc;
	b=kTWU7hGTufB2YxKvMCcyEr8IYgwM30x6cfAkIBUQg00ZMnm8aLlrM/PtUHt3+xoI8
	 NbQCxxS830ZhjjR6P6jrbphuBMBSvARZeZmxYDtLNIxWVUft97nEMTIHFUaBiE4plT
	 WjhtGncgTMn6SZWy+YQCcB5AQEE7MNeoi5Q5tixI=
From: Dirk Gouders <dirk@gouders.net>
Date: Mon, 23 Nov 2026 22:29:24 +0100
Subject: [PATCH v4] doc/gitcli: minor fixes
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4V0bUln2lJw5X8YFzwKjBowLRAN4
 d+l6EITXZ7knnNn5q0j69k+mpmzE3nquxXULmJlm3eN5VStzFBgAoCSF4o3NJRX4rWRORSJzkq
 TsnV/c7am+9Y6nl7sx+JsyyEEwqIlP/TusZ1NEHbvLigUkEiMQUglBAdekbscmn6srPNxZwcWi
 hN+O4gKYHW0zvCvIz8dLYyQ2sQAMjX6p7MsyxOaZI91FgEAAA==
X-Change-ID: 20261123-b4-gitcli-f73a1b659c78
In-Reply-To: <20261115070357.113875-1-dirk@gouders.net>
References: <20261115070357.113875-1-dirk@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501; i=dirk@gouders.net;
 h=from:subject:message-id; bh=lsPF2hfC3zS2S0WOkFc80z0CjQWOxtwbXGdG36DowQo=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLJZNpi/EJqnPNvLKbj35urvl6YuiIg//XX9L5UT80QKZ
 01uFziZ2Mk4gYWBkYuhSkyRZemkIrs0lRUvyr6pZsIMYmUCmSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoZAho6RA0SOn0EjvSDdIT2/NCW1qFgvL7XE0dTSyNzI2NXMzMjE0cLVwtzMzczI1MzS0cTU3NX
 RxczY3NjUxNHSmYGLUwBmnSgX+//UpQc1dDibW8u1FvzdMVMsNPLS2d1r1R9G5q4pWlT2uD5og/
 mhHQvmfNzj+s1U8XTfMVvRUpeP0r4lrqKHNdyZjH622snzGlk43rims6Aqa2503d2uw+adv3eei
 jdP7DyXLSGt5d7R5DR54T/barstD0u96n+pcelUN5U2m/QW83hEecssloryny3iJ/5y741Nh8QF
 Xq2ecCyfTWTphWcb38jdYyoX4V19VayrO/+BnJWo8H/GawnSh8oYrp0qPC3+wVg66Nnb/w5MFcr
 cBk3Hzgv7xzdEfvCLyUkROfgyJjxv0jRX9uOHlb0ueq687Xtl3j3+/qqfM1uM1zerCayM3vw0+1
 35iec37SIqAA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

Fix some grammar issues in the gitcli documentation:

- use plural/singular where appropriate
- use imperative form when rules are listed
- fix a typo in the first rule regarding flags

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
Changes in v4:
- Reword the commit message and clearly list the changes
- Fix a typo in the first rule regarding flags as suggested by Andy Koppe
- Link to v3: https://patch.msgid.link/20261115070357.113875-1-dirk@gouders.net

Changes in v3:
- Resent with proper Cc and range-diff against v1.

Changes in v2:
- Addressed feedback on the second part of the change.

Range-diff versus v3:

1:  2005f5ce9e ! 1:  d844b9957e doc/gitcli: minor fixes
    @@ Metadata
      ## Commit message ##
         doc/gitcli: minor fixes
     
    -    Fix three details in the gitcli documentation:
    +    Fix some grammar issues in the gitcli documentation:
     
    -    Use plural where appropriate and imperative form when rules are
    -    listed.
    +    - use plural/singular where appropriate
    +    - use imperative form when rules are listed
    +    - fix a typo in the first rule regarding flags
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
    @@ Documentation/gitcli.adoc: you will.
      
     - * Splitting short options to separate words (prefer `git foo -a -b`
     -   to `git foo -ab`, the latter may not even work).
    -+ * Split short options to separate words: prefer `git foo -a -b`
    ++ * Split short options into separate words: prefer `git foo -a -b`
     +   to `git foo -ab` (the latter may not even work).
      
       * When a command-line option takes an argument, use the 'stuck' form.  In
---
 Documentation/gitcli.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 9c4598e29c..78708aeccb 100644
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
+ * Split short options into separate words: prefer `git foo -a -b`
+   to `git foo -ab` (the latter may not even work).
 
  * When a command-line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261123-b4-gitcli-f73a1b659c78

