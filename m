From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] add: trivial style cleanup
Date: Fri, 30 Aug 2013 16:56:49 -0500
Message-ID: <1377899810-1818-6-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlO-00075N-Pj
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3H3WBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:44 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44924 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab3H3WBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:43 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so2444237obb.16
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vWysvSGfvFCIou9Ku0FXo7Z0v4OB1oG8wgaTxdHhsxs=;
        b=B3B2Uqbq8ZGnuV/Dh3VgnbtCGIJ1KLK89py6dWB84T+JwUbJrll6wVCF4Q1YvkzBsk
         EkCsjirrujnbv+M3JdIU7T7kMhCTLzYnBbqxdSuHOXpAOxUHTg112aWcKR2pke/wMx6E
         sshNp8wBbXsI7rPvHbw3pIN1efwWBneB0TjUxGI/I28OHrQY4fN/rZgWLlfdmcp1tHBU
         caaAdLQb4hmIyBxDxWrB3bmvhol6nv46wEmb09YqwXzH+5mMzRflbNPFCRTdP1bPh74N
         sHX3ODhuAhHT0WYOWuD++I4aDvHOxhdyMXaEXNxqWw1Roqb5rq1qT3qzEbvcRLPcIjrM
         HJ0A==
X-Received: by 10.182.48.230 with SMTP id p6mr8682307obn.1.1377900100777;
        Fri, 30 Aug 2013 15:01:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm68808obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233475>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8266a9c..a1e1e0e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -336,7 +336,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (read_cache() < 0)
-		die (_("Could not read the index"));
+		die(_("Could not read the index"));
 
 	init_revisions(&rev, prefix);
 	rev.diffopt.context = 7;
@@ -347,11 +347,11 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
 	out = open(file, O_CREAT | O_WRONLY, 0666);
 	if (out < 0)
-		die (_("Could not open '%s' for writing."), file);
+		die(_("Could not open '%s' for writing."), file);
 	rev.diffopt.file = xfdopen(out, "w");
 	rev.diffopt.close_file = 1;
 	if (run_diff_files(&rev, 0))
-		die (_("Could not write patch"));
+		die(_("Could not write patch"));
 
 	launch_editor(file, NULL, NULL);
 
@@ -364,7 +364,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	child.git_cmd = 1;
 	child.argv = apply_argv;
 	if (run_command(&child))
-		die (_("Could not apply '%s'"), file);
+		die(_("Could not apply '%s'"), file);
 
 	unlink(file);
 	free(file);
@@ -598,7 +598,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	unplug_bulk_checkin();
 
- finish:
+finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-- 
1.8.4-fc
