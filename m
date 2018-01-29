Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4750A1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeA2WjL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:11 -0500
Received: from mail-ua0-f201.google.com ([209.85.217.201]:39089 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeA2WjI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:39:08 -0500
Received: by mail-ua0-f201.google.com with SMTP id q28so6845335uaa.6
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=nJ2HRATkUSl1L3ClsjUDGsQoSX43lxAMgOuUtOd2Ckc=;
        b=lA7YNQlzf2v6+2/SMKJNcQVchahCFjMGdfq/Dj4mEVTkIamzPbHVz8BR86cpTcbFaV
         xt9pCqWU5FMbuRFNqgRbNEczPBbsH7mOo9FFr/lEkUuUAfbgAoKJN4QTArHF5lh/OGIV
         QuA5BFNsyPeHmfU5GXkuriinV9Z/pnDA2iPNgDCX6w1X5pxdd7p44o+u8SNqPbciAbM+
         qal3ESsbJJxC1h7Sws2g7WibxUGziama5t0ANwrpRpaOCkv/rXpDz3Kdb9a8raCk2809
         XnYjZRgP06GQpdwuPoZMym4sWFsxplX74w7JPFu/uk/sJVHEN3il47jTecIAFZ5D52h5
         98cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=nJ2HRATkUSl1L3ClsjUDGsQoSX43lxAMgOuUtOd2Ckc=;
        b=qr/8Oh+NKtBxqlvp91SNZtxI886NlU13r50aqQ8EHr+vdTZ+ixCeJZuOAuScT9x4yf
         ZqNGMO4PvkxmK5bZVt41PEz3YsYUzAzKIzje45VQaW2tTs3n/xZjOgfdWa4gCKk8XskP
         72gMmDkk7uNqZfGlursctxVauwzfRBuxwbyR+QHIm6qqqlOC0h0PL8TjpBySgURFRz2y
         xW0FWoGJiWaDLFFfGW5/ARUxF3C/6dpgtdB+t82FZKkzu/kKkD8RinCdv3QB526V7Air
         Dz3TB+VdobXJG9z5tDTu1DGl7vmMq1nSDcr2v05I8Ci/0Y18ae2d+XYUsxzchVG6YzdT
         QaZQ==
X-Gm-Message-State: AKwxytdSZ5DkdwXfeHsSQybF3Ih1wxbC4k706nDZfPyFB9wFeyw1AglO
        0cbvGJJzrHXuFvkzAVo/Dmaf5Bp/pgp722lQeY2961VHKIqbnAEPL/JCd6KJMD0EPEOKJ5/ugZk
        AlJSgv4fMzvQmUjWdm12MzPNqpI5YT8VozzpNuHCcuCJ2Li9N2xdyr61FNw==
X-Google-Smtp-Source: AH8x224mM2OkgIX2b8eS+AaLCJHV09DZtyGUV5MdQWjXUFEGlEn+aySIB1iJvz6HY5lzFjCvS5Pz1BoQELM=
MIME-Version: 1.0
X-Received: by 10.31.85.196 with SMTP id j187mr12420752vkb.25.1517265547263;
 Mon, 29 Jan 2018 14:39:07 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:28 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-38-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 37/37] replace: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/replace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 42cf4f62a..e48835b54 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -284,7 +284,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 {
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
-	struct object_id old, new, prev;
+	struct object_id old, new_oid, prev;
 	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old) < 0)
@@ -300,14 +300,14 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	export_object(&old, type, raw, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
 		die("editing object file failed");
-	import_object(&new, type, raw, tmpfile);
+	import_object(&new_oid, type, raw, tmpfile);
 
 	free(tmpfile);
 
-	if (!oidcmp(&old, &new))
+	if (!oidcmp(&old, &new_oid))
 		return error("new object is the same as the old one: '%s'", oid_to_hex(&old));
 
-	return replace_object_oid(object_ref, &old, "replacement", &new, force);
+	return replace_object_oid(object_ref, &old, "replacement", &new_oid, force);
 }
 
 static void replace_parents(struct strbuf *buf, int argc, const char **argv)
@@ -386,7 +386,7 @@ static void check_mergetags(struct commit *commit, int argc, const char **argv)
 
 static int create_graft(int argc, const char **argv, int force)
 {
-	struct object_id old, new;
+	struct object_id old, new_oid;
 	const char *old_ref = argv[0];
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
@@ -410,15 +410,15 @@ static int create_graft(int argc, const char **argv, int force)
 
 	check_mergetags(commit, argc, argv);
 
-	if (write_sha1_file(buf.buf, buf.len, commit_type, new.hash))
+	if (write_sha1_file(buf.buf, buf.len, commit_type, new_oid.hash))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
 	strbuf_release(&buf);
 
-	if (!oidcmp(&old, &new))
+	if (!oidcmp(&old, &new_oid))
 		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old));
 
-	return replace_object_oid(old_ref, &old, "replacement", &new, force);
+	return replace_object_oid(old_ref, &old, "replacement", &new_oid, force);
 }
 
 int cmd_replace(int argc, const char **argv, const char *prefix)
-- 
2.16.0.rc1.238.g530d649a79-goog

