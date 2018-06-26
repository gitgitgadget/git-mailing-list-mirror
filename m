Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA2E1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFZSCO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:02:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55780 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeFZSCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:02:12 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so3646982itl.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=uYPaCoJiMNlNn9Lxh3i8jg4L3IE5Z/qU3il+3ojarwE=;
        b=XTPc49+kP+CKCYvBp1oxxPlDVDFJdyz0QsjlwEE3EKZf+x0w53yNVKo+WIT4SK4PSk
         na8ZkHmKQgmFZbtLKZXZOqobdYusI3dzWTE8rTL8T78Q1xuWh45JoIitznlps43Los2m
         0oNLrQYlkVvrc6eq5+e7uUqnmPmxf0FzGd4wM/FtZ/v3fDyfOEPNQi0M9skdmlsSgeQ/
         8WQOfFhatYEHidN/sphYDtF3Yk/naQ0Nf17jDr+4lE56jLaFEVAAQyTJraOzINpEnckO
         jN0gM8uapBvme6QEwgpoeueXLiyAEAeVt3wof+0btlz7ADg59xEnSjuFqnHxdLkTikw5
         HtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=uYPaCoJiMNlNn9Lxh3i8jg4L3IE5Z/qU3il+3ojarwE=;
        b=DIJY0GULR393hiZHMeZcvPKHUJ4ynF6ktIn/3xSm3yxhgljbxMoi3HwQvAcQRDkrn2
         APbOlPRk8rWo1d6i/KdSg5TBk/luRlWNXKa+LRd+LikzWVGvkXMDo1sDaB8oNLy5tQDo
         r7YWBYfx82bETA8IqlODTmQVZNBuf5nYejBB4oVz06158yxxUdqzEhARiMSbTLPf2JC1
         TLxtvDlIwt3aR7A7+N5FDO1L/MEUuVgi+rb7kA+QWjFgLjSq8w8+HlJ53DUUI1cO4jro
         hyGr2z8VtEm9pXp6NcI39OavkkM5UM6h0+dYj+LSjfIKD4q/s3Dy1dUsY7rGv3iPy1lK
         +Ydw==
X-Gm-Message-State: APt69E2eSIG8W/anH3xyIuL+bKR6Hp/DPdVvtSZ2RthSV2zrSTRZjgKr
        SHRhLa5jkx+nvA8n+IacYW3uypjxK4A=
X-Google-Smtp-Source: AAOMgpduFkeZm/kiffYfbpGl9yyH1kcYaC9VI/h4l9zYfjhh88UKEzQyr/tPCDwa9l3vKD1GAm6i1w==
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr2139714jam.79.1530036131394;
        Tue, 26 Jun 2018 11:02:11 -0700 (PDT)
Received: from proserpina.cipafilter.local ([216.24.127.7])
        by smtp.gmail.com with ESMTPSA id g81-v6sm1005878iof.13.2018.06.26.11.02.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:02:10 -0700 (PDT)
From:   dana <dana@dana.is>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: [PATCH] rebase -i: Fix white space in comments
Message-Id: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is>
Date:   Tue, 26 Jun 2018 13:02:10 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a trivial white-space issue introduced by commit d48f97aa8
("rebase: reindent function git_rebase__interactive", 2018-03-23). This
affected the instructional comments displayed in the editor during an
interactive rebase.

Signed-off-by: dana <dana@dana.is>
---

Sorry if i've done any of this wrong; i've never used this work-flow
before. In any case, if it's not immediately obvious, this is the issue
i mean to fix:

BEFORE (2.17.1):

# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out

AFTER (2.18.0):

# If you remove a line here THAT COMMIT WILL BE LOST.
#
#	However, if you remove everything, the rebase will be aborted.
#
#	
# Note that empty commits are commented out

The 2.18.0 version is particularly irritating because many editors
highlight the trailing tab in the penultimate line as a white-space
error.

Aside: It's not a new thing, but i've always felt like that last line
should end in a full stop. Maybe i'll send a patch for that too.

Cheers,
dana

 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 299ded213..a31af6d4c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -222,9 +222,9 @@ $comment_char $(eval_ngettext \
 EOF
 	append_todo_help
 	gettext "
-	However, if you remove everything, the rebase will be aborted.
+However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
-- 
2.18.0

