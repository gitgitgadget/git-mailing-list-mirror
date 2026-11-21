Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795290827;
	b=ys+v7XZbqKXGvx0LDnSvQ18DsafXVJcLpilzrExIZgpI9wDhHMm4+QC9/9DLTW17Ano1
	 9UgkYlDiCWd+JYNhk54p2EW6kOaMi4Qo+sAQS7WH1yJJDJmxodBt5hEa+nUkappnYPJ/W
	 e30fJflCm353xdQwtbHqabSzAqlSXTTQUnbHfivcLw9t7YNfMtO37ti7gEHRUs+SLdAFc
	 sCSeaOFJkh3fXfXqIL9xy3vxvQ/n+0PDiU+vPzTzZbEME6ha2eW1b0yaxUHnqD28zqauM
	 Bl9p12+gpgE8A2X0cM58n8tBvtbyb8CorlLVzi3qYonTcQcCLwsjDCrYdNWPNEtwtLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290827;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=;
	b=YEFCkRVh+Qo2k24Ir0fvDaUvNUJf9cdQt/CAoe5Wv7m6vB8VPNq/eReKJdDtXK0CAWR+
	 qBSjGjVvveaUnzov9mZsj1guheEYOHrbLWuwrn3+zKVv4atkg5qLK5xsw6OL4OkYvMVBX
	 KKPpkcuENrC+yOHsLw/t7oEyH3Mt5vQTC12Vn9Q0IodBlnFJw44xi/QJvrdmfDoOAWmGQ
	 53pCEh6fhPzITy4XjyVbQphrRUDDpAuqF0PjqLPHtSbyXWprWmCH/P81gwsL75bmH1+Gh
	 rEx46zvZ2Bh60r/OxYoifiht/QQqU8bR8RKxvb+0zVGhqQc4KCgwfb5XFm4nGVp1jjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=B8g83TmQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A1606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 421A1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=B8g83TmQ
ARC-Seal: i=1; a=rsa-sha256; t=1795290815; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W656nE52BZAm2IBRX5f1IVUW3WQUfR08RMt4lp1ZXccd9HdlUXVhwkEVLP/u/xduo4y2tB/9T79cGnNghm/yQOv5EslTqpVcHbQf2T15GWgPMjRTKa2TFUV29Y7ZqWnwaFlAZIXx0rqRdxnSDSpzGQl8m2nj0QnHoOzsBrm9PZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795290815; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=; 
	b=H9u279/aSziFBdpqxDjHYxGje89RIKHXegxnJA7DbnIKsf/wuf2fw+6093lowSiaAQqfHmrqQju/NF8roVVK07ntjsslhW/hhOJ4fE3PupmjBdTGyRbA9yq1tacgpU9m6wV4q/fUogbfCLqmK+N/LOcg8Cp7Y3twa+krjxFd/Bo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=B8g83TmQ8qYXCZzGRF+tFtng2c8t9wWstegZT431ZjXwxsLTfb6wP2brw7P5p9/L1R/6pDmJyvTsqjADTFMLIntv2DG1cm9NKifnKSWhXJGPn65+eJqxVYsd0I9W2bbN9IuZ1AlgyLab04AZ25Iv1kdVVktdaRUtRgayRfITOBE=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795290812440285.3986930694741;
	Sat, 21 Nov 2026 11:53:32 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3 1/2] builtin/reflog: expire --all and named refs in one loop
Date: Sat, 21 Nov 2026 11:53:16 -0800
Message-ID: <5878cbe0ebc18b9c61cce37587fcd3a211e8d354.1795290319.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1795290319.git.laveeshb@laveeshbansal.com>
References: <cover.1794324064.git.laveeshb@laveeshbansal.com> <cover.1795290319.git.laveeshb@laveeshbansal.com>
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

"git reflog expire" calls refs_reflog_expire() from two places, one
for --all and one for the refs named on the command line, each with
its own copy of the callback setup. The copies can drift apart:
d1536ac3e2 (builtin/reflog: say "would prune" for named refs with
--dry-run, 2026-10-23) fixed a copy that was missing dry_run.

Collect the reflogs from both sources into one list and expire them
in a single loop, so the call is set up in one place. The names given
on the command line are still looked up in that loop, so the output
and the exit status stay the same.

Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
 builtin/reflog.c | 50 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 49e5453dd9..42d37a3724 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -187,6 +187,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	unsigned int flags = 0;
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+	struct worktree_reflogs collected = {
+		.reflogs = STRING_LIST_INIT_DUP,
+	};
+	struct string_list_item *item;
 	const struct option options[] = {
 		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
@@ -244,10 +248,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	}
 
 	if (do_all) {
-		struct worktree_reflogs collected = {
-			.reflogs = STRING_LIST_INIT_DUP,
-		};
-		struct string_list_item *item;
 		struct worktree **worktrees, **p;
 
 		worktrees = get_worktrees(the_repository);
@@ -259,44 +259,42 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 					     collect_reflog, &collected);
 		}
 		free_worktrees(worktrees);
-
-		for_each_string_list_item(item, &collected.reflogs) {
-			struct expire_reflog_policy_cb cb = {
-				.opts = opts,
-				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
-			};
-
-			reflog_expire_options_set_refname(&cb.opts,  item->string);
-			status |= refs_reflog_expire(get_main_ref_store(the_repository),
-						     item->string, flags,
-						     reflog_expiry_prepare,
-						     should_prune_fn,
-						     reflog_expiry_cleanup,
-						     &cb);
-		}
-		string_list_clear(&collected.reflogs, 0);
 	}
 
+	/* util marks the names that still have to be looked up */
 	for (i = 0; i < argc; i++) {
-		char *ref;
+		item = string_list_append(&collected.reflogs, argv[i]);
+		item->util = (void *)1;
+	}
+
+	for_each_string_list_item(item, &collected.reflogs) {
 		struct expire_reflog_policy_cb cb = {
 			.opts = opts,
 			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 		};
-
-		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
-			status |= error(_("reflog could not be found: '%s'"), argv[i]);
+		const char *refname = item->string;
+		char *ref = NULL;
+
+		if (item->util &&
+		    !repo_dwim_log(the_repository, item->string,
+				   strlen(item->string), NULL, &ref)) {
+			status |= error(_("reflog could not be found: '%s'"),
+					item->string);
 			continue;
 		}
-		reflog_expire_options_set_refname(&cb.opts, ref);
+		if (ref)
+			refname = ref;
+
+		reflog_expire_options_set_refname(&cb.opts, refname);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
-					     ref, flags,
+					     refname, flags,
 					     reflog_expiry_prepare,
 					     should_prune_fn,
 					     reflog_expiry_cleanup,
 					     &cb);
 		free(ref);
 	}
+	string_list_clear(&collected.reflogs, 0);
 
 	reflog_clear_expire_config(&opts);
 
-- 
2.54.0

