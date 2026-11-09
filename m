Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794201880;
	b=UbMdyIthGWYPUdMdTadTiBaNkomdWRpwOWEIyg3gqB3Y7x/4EBP6fxA/Zu32WMwJvKRF
	 CXBZ4bdIZ2NZaHPbLx98Ek0bFTSd1JWBAxAlOWRfyCdXPnrGDxl1El8mzK534Ur/aczab
	 bsoEtmGUV4uMAPIl9SNOBntU1VyRCOXiFbWa6mxVa53N/KwGbPq3ySdLhK4Px7zcDuquE
	 krwc4GlNvT9eUEJKi5EAcQD6lMi6P8+2nhtVFEI/YfjQ9efyE4ngxv/PvodNU10un6hh5
	 zf65xIlGyMX8P+Ayw9zkInyNnEXzH4pQlg+bkYrhWx75An6NocbLfS5RRMg3Mp6H0UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201880;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=P+YiiRrSpqiFTc/Ao2bcO/an8hm3rLTbB3ZxCRrNoFs=;
	b=yv/rRvsiqqP2ts8iwvbuROYN3+mtR22LSnPfLJgi7Q5SkLE2Lw7F4GN3Eq2b0xXlIMTU
	 kbsMw6yXhw8xUDi1yN6+YrXhS+7cEA/XQ/RNUlA83VWczgOcrk1LKFs4rayFnRGF9A0NG
	 /AClf5yZ6FMnzcPVx5NwNyB46UZ8rPJGYbw5HTMxPI3LAxNnhESRpXhq76MYdoWh5A/jO
	 QzqF8vXJWVvTOi2iFulMF0TegKvG/U0KuG8dcklTzi0gxYzyV/g1dYubwP5yTYz/EAKnm
	 DKjLQ29PTAFzuO4ycZH2H4YqBKPRkFx6wuNPoyLkRBGDTnFR9g+fU/E3p6vnCFiaqUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b="iBmnu25/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBB606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 05:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBBB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=iBmnu25/
ARC-Seal: i=1; a=rsa-sha256; t=1794201868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hzacHeHJCJgQjmkE6fJq8L/XX7KZsrXjjm2UBcWLGPcsN7ngOjJvrVmMN2T/ngIugeVmtX+d5k6RnyWmGWgfclWKm73omUkOLWsGI/C3CnXstAtueg4Dm3Lz4WEp57R8XJcYg/wZgAnyf1zH8fpxRifbO2sl+ZC8QVLtLxuaHbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794201868; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P+YiiRrSpqiFTc/Ao2bcO/an8hm3rLTbB3ZxCRrNoFs=; 
	b=GmTvWp550Ng13XhiHwKpsNxW5STv0Phx5VImshp4U6KqxarLTh4kg4XCHK4VZ3v3ysDlnJiKhFVFUJqDGArYfOJtnF1K90bpYkuWZNfIcL2UFFLUCzUIYnIVkeL8gKr3R2l1IvwcPva8/QCyANKvzEWhZDUR70fhRlIHxAUxc9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=iBmnu25/cAc1XHWMtMFdQpeag0yDC5INyW8rw4hUH0VJloFlNuOcFiVZLJccNn5Tf5OCbFpG3wHaoMCQPRmsGsqHmQaZDffAstG9r27ibNyf7zqKkYND0dav21ogZuOzxY45k7J7n4nf051z4yZVXAymmwiqsuHFjanPCwu2DoY=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=P+YiiRrSpqiFTc/Ao2bcO/an8hm3rLTbB3ZxCRrNoFs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794201866705251.64738806023342;
	Sun, 8 Nov 2026 21:24:26 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] rev-parse, shortlog: accept --glob with a separate pattern
Date: Sun,  8 Nov 2026 21:24:02 -0800
Message-ID: <20261109052402.33604-1-laveeshb@laveeshbansal.com>
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

"git log --glob <pattern>" works, but the other two commands only
understand "--glob=<pattern>":

    $ git rev-parse --glob 'heads/*'
    --glob
    heads/*

    $ git shortlog --glob 'heads/*'
    error: unknown option `--glob'

0fc63ec4e7 (revisions: allow --glob and friends in
parse_options-enabled commands, 2011-04-21) only recognised the
"--glob=" spelling for commands that parse options in two stages, and
"git rev-parse" parses it by hand. Accept the separate word in both.

The four tests that commit added as known breakage now pass, so turn
them into regular tests.

Assisted-by: LLM
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Notes:
    This only covers --glob. --exclude and --exclude-hidden have the same
    gap and I will send them separately. --branches, --tags and --remotes
    take an optional argument, so they stay in the "=" form.

 builtin/rev-parse.c      | 4 ++++
 revision.c               | 6 ++++++
 t/t6018-rev-list-glob.sh | 8 ++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ec33c19bdf..c1ea7e81af 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -972,6 +972,10 @@ int cmd_rev_parse(int argc,
 				handle_ref_opt(arg, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--glob") && i + 1 < argc) {
+				handle_ref_opt(argv[++i], NULL);
+				continue;
+			}
 			if (opt_with_value(arg, "--remotes", &arg)) {
 				if (ref_excludes.hidden_refs_configured)
 					return error(_("options '%s' and '%s' cannot be used together"),
diff --git a/revision.c b/revision.c
index a83e499047..df75c58bc7 100644
--- a/revision.c
+++ b/revision.c
@@ -2355,6 +2355,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* pseudo revision arguments */
+	if (!strcmp(arg, "--glob") && argc > 1) {
+		overwrite_argv(unkc, unkv, &argv[0], opt, revs);
+		overwrite_argv(unkc, unkv, &argv[1], opt, revs);
+		return 2;
+	}
+
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index bb55c7e3c3..01f064bc9e 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -78,13 +78,13 @@ test_expect_success 'rev-parse --glob=heads/subspace' '
 
 '
 
-test_expect_failure 'rev-parse accepts --glob as detached option' '
+test_expect_success 'rev-parse accepts --glob as detached option' '
 
 	compare rev-parse "subspace/one subspace/two" "--glob heads/subspace"
 
 '
 
-test_expect_failure 'rev-parse is not confused by option-like glob' '
+test_expect_success 'rev-parse is not confused by option-like glob' '
 
 	compare rev-parse "main" "--glob --symbolic main"
 
@@ -409,7 +409,7 @@ test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 
 '
 
-test_expect_failure 'shortlog accepts --glob as detached option' '
+test_expect_success 'shortlog accepts --glob as detached option' '
 
 	compare shortlog \
 	  "main other/three someref subspace-x subspace/one subspace/two" \
@@ -417,7 +417,7 @@ test_expect_failure 'shortlog accepts --glob as detached option' '
 
 '
 
-test_expect_failure 'shortlog --glob is not confused by option-like argument' '
+test_expect_success 'shortlog --glob is not confused by option-like argument' '
 
 	compare shortlog main "--glob -e main"
 
-- 
2.54.0

