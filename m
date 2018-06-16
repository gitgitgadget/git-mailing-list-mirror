Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCCD1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFPSIM (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 14:08:12 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:55954
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752587AbeFPSIL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Jun 2018 14:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1529172490;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FahJ8x2woL6lw7GWgeDb6SD28p6pPF3N5z9e3H0TnS0=;
        b=VYqSe7AX84QXScaNNU0v7D9AH0CXTB0MjqvOQlksyoPhuWAex7SaRH87kAVYWCaW
        YxTKH4FC2z02VLdYgidjI5bYwhl4ryo3NfBwXitRd0uF29QdLGFiF28ME+23C/lHmgz
        +YTAELGnIsIWAk7LM8PIRB9HsWOn5+tRy1u2ivYk=
From:   Xtreak <tir.karthi@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016409c877f9-58c13d7c-4d25-43e2-8d64-c13d98b88ee7-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: fix typos in documentation and release notes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 Jun 2018 18:08:10 +0000
X-SES-Outgoing: 2018.06.16-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/RelNotes/1.7.11.7.txt | 2 +-
 Documentation/RelNotes/2.17.0.txt   | 2 +-
 Documentation/RelNotes/2.18.0.txt   | 2 +-
 Documentation/diff-options.txt      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/1.7.11.7.txt b/Documentation/RelNotes/1.7.11.7.txt
index e7e79d999bd38..e743a2a8e46eb 100644
--- a/Documentation/RelNotes/1.7.11.7.txt
+++ b/Documentation/RelNotes/1.7.11.7.txt
@@ -25,7 +25,7 @@ Fixes since v1.7.11.6
    references" nor "Reload" did not update what is shown as the
    contents of it, when the user overwrote the tag with "git tag -f".
 
- * "git for-each-ref" did not currectly support more than one --sort
+ * "git for-each-ref" did not correctly support more than one --sort
    option.
 
  * "git log .." errored out saying it is both rev range and a path
diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.txt
index d6db0e19cf17b..c2cf891f71adf 100644
--- a/Documentation/RelNotes/2.17.0.txt
+++ b/Documentation/RelNotes/2.17.0.txt
@@ -342,7 +342,7 @@ Fixes since v2.16
    validate the data and connected-ness of objects in the received
    pack; the code to perform this check has been taught about the
    narrow clone's convention that missing objects that are reachable
-   from objects in a pack that came from a promissor remote is OK.
+   from objects in a pack that came from a promisor remote is OK.
 
  * There was an unused file-scope static variable left in http.c when
    building for versions of libCURL that is older than 7.19.4, which
diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index 7c59bd92fbd99..1eb13ece53600 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -324,7 +324,7 @@ Fixes since v2.17
    after giving an error message.
    (merge 3bb0923f06 ps/contains-id-error-message later to maint).
 
- * "diff-highlight" filter (in contrib/) learned to undertand "git log
+ * "diff-highlight" filter (in contrib/) learned to understand "git log
    --graph" output better.
    (merge 4551fbba14 jk/diff-highlight-graph-fix later to maint).
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f466600972f86..bfa3808e49cc0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -133,7 +133,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	as file creations or deletions ("new" or "gone", optionally "+l"
 	if it's a symlink) and mode changes ("+x" or "-x" for adding
 	or removing executable bit respectively) in diffstat. The
-	information is put betwen the filename part and the graph
+	information is put between the filename part and the graph
 	part. Implies `--stat`.
 
 --numstat::

--
https://github.com/git/git/pull/510
