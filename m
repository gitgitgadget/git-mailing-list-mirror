From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] stash: git stash create and git stash store added to git stash usage synopsys
Date: Tue, 13 Jan 2015 23:54:06 +0600
Message-ID: <1421171646-12113-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB5fZ-00008Q-QF
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 18:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbAMRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 12:54:14 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45458 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbAMRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 12:54:13 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so3925154lbv.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=giZKr/ornjuvhHFEOOsbvzo/xMaBOPVpCHRLgAmcilU=;
        b=ng+JgQp3ghRvUYNdvtbgAlrNDmHxROLl6xe0gEIDWbZMkopVBL3s1jx3s14iXpuoLu
         F96/SaIwuXYAEJj6xHjJycpcTLJz20dj1xiP/vLftfS66SMnn3mD3V6EvDDy4XGCMxac
         xZUY+H4qH/zhL1Lmpq6v1HtKCVQZGZUK9fndzvI1t6F/eitu2HpY4FlhERWnAdmwpzKb
         isv8MZoKwyFP4OXJg4VkA5ZeyuKcEVwt94sIInCAYDEOhS6yxXT7cycUYHuG6Qfncb2j
         dNFSw4VlwCGDCjLPirC1FQB0sswYYMp3wJNkYgJR+nJLDvkoiQJo+umcrGeT8S7nHnXh
         PVFw==
X-Received: by 10.152.23.98 with SMTP id l2mr43226580laf.46.1421171651526;
        Tue, 13 Jan 2015 09:54:11 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.47])
        by mx.google.com with ESMTPSA id fb5sm5156260lbc.34.2015.01.13.09.54.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jan 2015 09:54:10 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.239.g0ae1f56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262341>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-stash.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 6846b18..6e30380 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -9,7 +9,9 @@ USAGE="list [<options>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
-   or: $dashless clear"
+   or: $dashless clear
+   or: $dashless create [<message>]
+   or: $dashless store [-m|--message <message>] [-q|--quiet] <commit>"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-- 
2.3.0.rc0.239.g0ae1f56.dirty
