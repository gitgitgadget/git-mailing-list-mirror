Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509130;
	b=oxzRFRc1YbYukNXfaNVWi3+yGSmsMnNu/5hqOgYEy4BzrQ82FZcLbQR3+0qAArKThoNk
	 pAfzRjhBUlI1PR8+7xUG6ZwTxaA/06kGwBvJc5hfShaE6lORpIYl1jNgBHZGLrSBB95ov
	 Z11tCOZijkxNmw8elbgnrfAt31oPLVO526QRP8yj97qbt6J7KFPHazjDzUUV6AySpMQLO
	 UJxHIN4E9hTBzYCBVUiDDWVnMTlZznDEYSoZq5Lh+9mxOEN1G1sAFOwtbzGCXIYfG36EB
	 IBKPgWTtIgyIinbJaGUpzUof7VjkZunaRYtOq6SQ2PmpSDHkoWiESTgx/Ejh7XGLHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509130;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MrzQKXNZN8rmTsb9SrewUcQlkg7valqOva9I2N3175M=;
	b=QJy1C0JRCS4Uqyu2p+BDJMH4M3Fr+oHRdGpEqnKJGirMlm52LgFuxOPVWHLK3Pra4HYC
	 YKiZcfihaAHSa1dxqEv3sjYrm5DGR0Hb58DCNvgopvMPPCFh2CEaSA5BstITKIw0FM79Z
	 M0Y/Kmkuuu2apmmZHZDSMG2HxJjR0SR3qXp1dYznEbS8XTh9V1AVGMYKJAt7NBM7clbwL
	 BtAGVY0mQM/kUhw/kj5nEPjYCx5tJ7mR1PGjLVEpohGfCbMwnxy+677Z062y7/K1tTYvE
	 WWFzWRufVcBAbjZ1/PAr9l42jyzRrpGlKWRCUhquB+tkdn8NHXDCmuBNSKZyIQfV13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=nCUytJEW;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51C606A336
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 08:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E51C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=nCUytJEW
Received: from lena.gouders.net ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AO8W1lu2369260
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 24 Nov 2026 09:32:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795509126; bh=MrzQKXNZN8rmTsb9SrewUcQlkg7valqOva9I2N3175M=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc;
	b=nCUytJEW68XcwaqqHFD7vF6HTQvMj33Jpos1WcC9c8XZTC5JDiUEuPUcIqDOqlcKp
	 YEXMN+UurSMW7CpnOe/5zCFlIdX9nTxkoEcwY+WpuDEZL/YIeHI9hGdoz4dWhjO+YJ
	 ijHnrEa4d+KYCDPM5g6ZvHd9PjZojwt/XQ5G1J90=
From: Dirk Gouders <dirk@gouders.net>
Date: Tue, 24 Nov 2026 09:31:55 +0100
Subject: [PATCH v5] doc/gitcli: minor fixes
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
Message-Id: <20261124-b4-gitcli-v5-1-450d50655781@gouders.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPQQ6CMBAF0KuYri2ZmbZUXXkP40JgxFEDpgWiM
 dxdqi5k4fIn//3JPFXkIBzVZvFUgQeJ0jZTcMuFKk+HpmYt1ZQVAeWIZHRhdS1deRV99OaARe7
 WpV+pqX8LfJT7e2u3/+TYF2cuuzSQGieJXRse72MDpt53Fy0B5oYyBGMBNOpKwmVbt33FIWYNd
 yotDjQ3RBZxMs6t6a8xv8aBB+N8hmhW3v019sfMfh5sMowGKmDwnM/tOI4vaOVZplIBAAA=
X-Change-ID: 20261123-b4-gitcli-f73a1b659c78
In-Reply-To: <20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
References: <20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=dirk@gouders.net;
 h=from:subject:message-id; bh=07/D+s2rnNajVK+bnRStvNVkcR5wpgu0D/IG+rYzPL0=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLJZvRvfTvi6peFXDE/L9+bVUSvnlseuVdvzyGJz9aOVR
 2zldmgadjJOYGFg5GKoElNkWTqpyC5NZcWLsm+qmTCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPkAJHjZ9BIL0h3SM8vTUktKtbLSy1xNLU0MjcydjUzMzJxtHC1MDdzMzMyNbN0NDE1d3V
 0MTM2NzY1cbR0ZuDiFIBZVxTN/lf29lyv84symKY217q/95gxN13Gfu3rGTcLSsxeztbrTsif82
 Bna4XKX743Rm/q82d8ffjh5auSyvl3E+e+2iCylIl/l2X98lORGqxs5tIxS57GmqULJZvdP7sv/
 c3Noxb3ZTP/djTsZFGTWDir800325enDwMm9L76tPNQ7rJPjOWvPPep8M9ytIt28Nu7iesU74vS
 PAufE8/2HFF2k/gaYeIT+I6DK5khzyejubPOdIPMEzv/Wo/gaV+3Lc8+GzVX4r2Rv+qv3W/v5f8
 o3TKFJfOmdor1r7qeJN1GydlH5+ZPbaq6cv6j6RKRGJei8pdVE432Rtt8Va+494bDr/zuqYivCm
 qf/72r3/NjXS8A
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

Fix some grammar issues in the gitcli documentation:

- use plural/singular where appropriate
- use imperative form when rules are listed
- fix a typo in the first rule regarding flags

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
Changes in v5:
- Restore a lost change caused by wrong tooling.
- Link to v4: https://patch.msgid.link/20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net

Changes in v4:
- Reword the commit message and clearly list the changes
- Fix a typo in the first rule regarding flags as suggested by Andy Koppe
- Link to v3: https://patch.msgid.link/20261115070357.113875-1-dirk@gouders.net

Changes in v3:
- Resent with proper Cc and range-diff against v1.

Changes in v2:
- Addressed feedback on the second part of the change.

Range-diff versus v4:

1:  19c1ee5260 ! 1:  147ae7818c doc/gitcli: minor fixes
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
---
 Documentation/gitcli.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 9c4598e29c..775dd8ee09 100644
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
+ * Split short options into separate words: prefer `git foo -a -b`
+   to `git foo -ab` (the latter may not even work).
 
  * When a command-line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261123-b4-gitcli-f73a1b659c78

