Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5BB1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfHSJS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:18:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53461 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfHSJS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:18:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so928328wmp.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WTVTaWiIchnVIuKKsKzPFNFS0QzN1XqnOShWmcVz9TY=;
        b=CcnyrKiiCqO1xuwlA1ta19p0Gk0mO7mnNvCACtEwbIZooSGUe8TVTCxTyduieXigsa
         ia1PLetLGvZ0FCZdbyMe8RlQQ9wcvcd2T79NDCVuMcWXxuvLfxoF3suj6n8Q1K164A5N
         o4ZmDpyM3pps1zqXTG1DzwSX7AQfFuyCYa0qZFXiKlGPl9VPzMlm9eAx/hAkKeW3fE5X
         xxQrxIGfemFI7mRR/wDDj19vwQypZ7rMIOdRDln9h8Y9nJRxcQdYGqzWKs2u+3P0R7V2
         DONCVADUCXLZyKqfK/dgzI4Gup4S9V48mZE7pscf9V+yE5ugRn8wNL2P2vy2MYgUGkv9
         Sl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WTVTaWiIchnVIuKKsKzPFNFS0QzN1XqnOShWmcVz9TY=;
        b=rBnfn6Mdgkk0tfm5OM3oXtNL6KpEI5G9OJJ8ye6IzYd7i3mo3WGYyTZ1KeXPMCsb6J
         XddjW+AAeTENYpyXWYnyuOxJI1b1PxacR8kKvBnOFwX8AC79xskqX8PYxTX9z8PeOVOz
         38dmrCGPF4hylqMN5eBEtueCeeOXOY27K3j76XVZuU8DJoGgEBIwW3zFjspV+PeiM+ch
         mPrRgFdsxR5GMEgVnd6kxxcZ/K8/YWacVK0DLas4EIDPg6icnRARIDeWg8L190oKyV2F
         MCqjUpnOJDBWTalgq0ktgaUt0KUoaev+Vcoz1SDcgup9KkS8Q5ruCeF7iPT6rrSju4BE
         2bSA==
X-Gm-Message-State: APjAAAXZDPh5dE2w5dhB7Al7f8HS1VqDIoaFJoAq0/UQdS6xQkudHwAx
        UOzFstaoJgXgCR+f+PFaQgdhfKIf
X-Google-Smtp-Source: APXvYqx399/kXlw6xtgAnR/hdcBhHlBFMcKQHMjLgX5+h6FPbSJZNKggEWTAY8u7rai75WQU6Z6HzA==
X-Received: by 2002:a1c:18a:: with SMTP id 132mr19702831wmb.15.1566206304279;
        Mon, 19 Aug 2019 02:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 39sm47640006wrc.45.2019.08.19.02.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:18:23 -0700 (PDT)
Date:   Mon, 19 Aug 2019 02:18:23 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Aug 2019 09:18:20 GMT
Message-Id: <3c3b4599e5a82824fdaa88a76fccd7a57ca3c3b9.1566206300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.312.git.gitgitgadget@gmail.com>
References: <pull.312.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] sequencer: simplify root commit creation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Adapt try_to_commit() to create a new root commit rather than special
casing this in run_git_commit(). The significantly reduces the amount of
special case code for creating the root commit and reduces the number of
commit code paths we have to worry about.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 75 +++--------------------------------------------------
 1 file changed, 4 insertions(+), 71 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a13e1a7466..758c780790 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -869,34 +869,6 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
-/* Read author-script and return an ident line (author <email> timestamp) */
-static const char *read_author_ident(struct strbuf *buf)
-{
-	struct strbuf out = STRBUF_INIT;
-	char *name, *email, *date;
-
-	if (read_author_script(rebase_path_author_script(),
-			       &name, &email, &date, 0))
-		return NULL;
-
-	/* validate date since fmt_ident() will die() on bad value */
-	if (parse_date(date, &out)){
-		warning(_("invalid date format '%s' in '%s'"),
-			date, rebase_path_author_script());
-		strbuf_release(&out);
-		return NULL;
-	}
-
-	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(name, email, WANT_AUTHOR_IDENT, date, 0));
-	strbuf_swap(buf, &out);
-	strbuf_release(&out);
-	free(name);
-	free(email);
-	free(date);
-	return buf->buf;
-}
-
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -954,45 +926,6 @@ static int run_git_commit(struct repository *r,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
-		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
-		const char *author = NULL;
-		struct object_id root_commit, *cache_tree_oid;
-		int res = 0;
-
-		if (is_rebase_i(opts)) {
-			author = read_author_ident(&script);
-			if (!author) {
-				strbuf_release(&script);
-				return -1;
-			}
-		}
-
-		if (!defmsg)
-			BUG("root commit without message");
-
-		if (!(cache_tree_oid = get_cache_tree_oid(r->index)))
-			res = -1;
-
-		if (!res)
-			res = strbuf_read_file(&msg, defmsg, 0);
-
-		if (res <= 0)
-			res = error_errno(_("could not read '%s'"), defmsg);
-		else
-			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
-					  NULL, &root_commit, author,
-					  opts->gpg_sign);
-
-		strbuf_release(&msg);
-		strbuf_release(&script);
-		if (!res)
-			res = update_ref(NULL, "HEAD", &root_commit, NULL, 0,
-					 UPDATE_REFS_MSG_ON_ERR);
-
-		return res < 0 ? error(_("writing root commit")) : 0;
-	}
-
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
@@ -1376,7 +1309,7 @@ static int try_to_commit(struct repository *r,
 			 struct object_id *oid)
 {
 	struct object_id tree;
-	struct commit *current_head;
+	struct commit *current_head = NULL;
 	struct commit_list *parents = NULL;
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
@@ -1411,7 +1344,8 @@ static int try_to_commit(struct repository *r,
 		}
 		parents = copy_commit_list(current_head->parents);
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
-	} else if (current_head) {
+	} else if (current_head &&
+		   (!(flags & CREATE_ROOT_COMMIT) || (flags & AMEND_MSG))) {
 		commit_list_insert(current_head, &parents);
 	}
 
@@ -1488,8 +1422,7 @@ static int do_commit(struct repository *r,
 {
 	int res = 1;
 
-	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG) &&
-	    !(flags & CREATE_ROOT_COMMIT)) {
+	if (!(flags & EDIT_MSG) && !(flags & VERIFY_MSG)) {
 		struct object_id oid;
 		struct strbuf sb = STRBUF_INIT;
 
-- 
gitgitgadget
