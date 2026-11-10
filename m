Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324468;
	b=3KJ2Mn7K8GNwv2kd3HKZoIlkp2M0MAGb+56Q2ZKAX7hzGQ0HT1f/gvtOZ490vScIUhr7
	 QzJuPLnFVgbhFM/UVBPtK6Vw6oHzjU8nsUJ0F4PXOcVWMQhgPG4X+xbA/dtJQ4UPMo9/5
	 5FZKw37aFi6C8+FdY0yOij90/cWkh0lSJOjhc//uwB/FjOoKJzaJo7xoV1WndzsmMiaFr
	 jSq7hEa15imk2fjBdgF+JIuwj7s6QYom6/StNlgruwun3SbfGSy/x+d+hhDJ4D5gJUIXh
	 5kydLcF1UIlAeNF5RVmuUeBuMasKs9/oTNrQp+n4RxqHOShx6G1PeDXwU7wUKqKaZYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324468;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=;
	b=Prh7wqYxITsDBT+WesyKpIhPO5rb/sybPmerTaEUm1wUNp468YXlFw75BLgcEIHmsz71
	 mDI2dElNUqXfPY7VIGp0s9obCfUIdxuU0vAvewWQgVT5wyKynigcNFY3CQvulcNAL6Ksu
	 lCiTMjB2Xjg59zCwzXiz/pZtnuJJHUjZ7EkZKdjcoCbNPhf9fBLwJdb+bKmuXdm7x/Bw4
	 0A61D5YfGcy7hhDU7P2YAnmlRyfvx6KNn+uMvHn3BI0E8t65nuxnz4zSXSuKDFaKUIkpR
	 /cQODpZ1t3qpVAE9gKsrKLoys9jYpjqJehoTN+lWt+vGPWwKZ1HgukTkprs8IJVxPsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Xrr8D2SL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D37606A331
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D37606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Xrr8D2SL
ARC-Seal: i=1; a=rsa-sha256; t=1794324436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ftSlPf4xYCfYxtIGED85vMRwGPLdbAju0kEogiMYnXh1wCzPp1JR7ghagVFJe3awbFGrrD/7lZ/MOGcq4s2NePC3KIRRxKN5xDEiLwp/dw8G1N8hlXYSqKNPkYQY8K2ldpDMfvjJ4OfYYSnFvCNoxqv/qbRjdMx2T0F+bGzroAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794324436; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=; 
	b=ZtnHLMVhxYi8reYtz6ShHcXVV0sEfK1zNTQVRnFofppfUXv2wBmdOKIVSy5caHHTHX2jXakR9DTafyLbscgahRFxKr9BwJSjanIq7K8GIzI9YDw2CdXMBfIcxE6Z+VeTBFOlyuCuAdGZ7dHhXj7l4qtcmgtd2URHw0olm+J6tj0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=Xrr8D2SLzhb/sSbFJkmXaQNDxnyQCdqdLF0zdHC4gFfFmvaQwQ0bkDH86SYSKUIEveFQ3NRLlzDa1lYl0yeElznyFcczh5oW7OXKgEB/vrTcFvABkN8GRtmWlCtHb/VBvggP2iFb04vP0bChc0TwJG2b1nfaT+zitkOIC+i0qdo=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=OHnUFWX/cwH+DxnElTb6KzwisoaX76UAXk9ICG5u/DE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794324425319358.5292775269211;
	Tue, 10 Nov 2026 07:27:05 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 1/2] builtin/reflog: expire --all and named refs in one loop
Date: Tue, 10 Nov 2026 07:26:40 -0800
Message-ID: <5878cbe0ebc18b9c61cce37587fcd3a211e8d354.1794324064.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794324064.git.laveeshb@laveeshbansal.com>
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com> <cover.1794324064.git.laveeshb@laveeshbansal.com>
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

