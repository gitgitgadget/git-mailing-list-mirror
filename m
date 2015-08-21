From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/3] builtin/log.c: minor reformat
Date: Fri, 21 Aug 2015 11:03:12 -0700
Message-ID: <xmqqio885xjz.fsf@gitster.dls.corp.google.com>
References: <1440110591-12941-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 20:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSqet-0007nd-IN
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 20:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbbHUSDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 14:03:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32781 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbHUSDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 14:03:14 -0400
Received: by pacgz8 with SMTP id gz8so1560039pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6Ay4Zvf47z1FEy01scox+5qcTgYAZQMGJt6+LgNuh0w=;
        b=eXQQT7ndCdRMMWSwnlrNuORrkxKHCrM1v1nx/x2S5C4jFPXJhP6hC1mV6d9qmRw9eU
         8UJorF7Pr8qupSeXHsdCeMOEq5sSwZExnPAARVkHUNKSZY0Y7Y2CPLsoIXf7pAUkG3gj
         Llul2VrYVuTjeEpjKqF5gw6JceehnNBVkyo5mlBW4ZIa5GJetrQ5CxlC9D8KTK3NgmTy
         uO8lBnf3H2lEWXNRD9czaxHzLof2kRdfPkAWGE3ZH+GHlbKJVQqIGSFCEf6npxOaLhmp
         vdWfUWe1efbChuli23E6i0heBmCtev2gibGLeuOvMIsdfkprZbjYA9kCJZnl0A+Bpb1f
         O7sg==
X-Received: by 10.68.254.136 with SMTP id ai8mr19381432pbd.98.1440180193890;
        Fri, 21 Aug 2015 11:03:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id gh5sm8504385pbc.87.2015.08.21.11.03.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 11:03:13 -0700 (PDT)
In-Reply-To: <1440110591-12941-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Thu, 20 Aug 2015 15:43:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276319>

Two logical lines that were not overly long was split in the middle,
which made them read worse.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0cdd889..a491d3d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -342,8 +342,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
-		if (!log_tree_commit(rev, commit) &&
-		    rev->max_count >= 0)
+		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
 			 * We decremented max_count in get_revision,
 			 * but we didn't actually show the commit.
@@ -1464,8 +1463,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (ignore_if_in_upstream &&
-				has_commit_patch_id(commit, &ids))
+		if (ignore_if_in_upstream && has_commit_patch_id(commit, &ids))
 			continue;
 
 		nr++;
