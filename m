From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] checkout: add missing const to describe_detached_head
Date: Tue, 22 Feb 2011 22:43:22 +0000
Message-ID: <1298414603-22338-2-git-send-email-avarab@gmail.com>
References: <1298414603-22338-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 23:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0xw-000460-9N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab1BVWoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 17:44:16 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:56536 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab1BVWoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 17:44:15 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3819163bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=bnySpgJpqQg5VvQzjpYeDhjy4JI7TOWWfecpWGplrsA=;
        b=sYf7u2OAs6t1Tm0dOpPgmQwwMjh8OY0J1NygW57gi/ThpzyliI56VRfM/wRTu8lrcs
         vI5INm/U8UtQa/rPHjJeqI8Cl0sl8dzqZaT9u/2lJf309Uhu+Q8ysUyMTUX6Cy93xQka
         sr6pbM5tiAU/djRLWnL+gQm6wXNUmAPV88DYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MhKL5+GdqJHgLu2fGCYWYP+CQRiJNuCyooG+FBazth+X43V5uhS01lKFXpQxsoqYYS
         fO4lw03S/5P8iYOYSM2Cfm338yBxNW3V36KONsbKUhBXqRf04+G3ME1qjulNnZVd3Q2A
         WFGzEJHAaXTUpYdo84gjjD501U5+jj/XW6mLo=
Received: by 10.204.97.132 with SMTP id l4mr3072455bkn.167.1298414654247;
        Tue, 22 Feb 2011 14:44:14 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id a17sm4883767bku.11.2011.02.22.14.44.13
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 14:44:13 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298414603-22338-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167586>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd7f56e..bef324e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -297,7 +297,7 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
 	run_diff_index(&rev, 0);
 }
 
-static void describe_detached_head(char *msg, struct commit *commit)
+static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-- 
1.7.2.3
