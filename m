From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 04/10] Correct a comment
Date: Mon, 21 Mar 2011 12:30:58 -0600
Message-ID: <1300732264-9638-5-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmk-0000RW-QR
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab1CUSYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62978 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1CUSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:45 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so5291756vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=s4EKx/StAtVDRxx3Z4NUC1lsVOiSjdD1PUIhzBKk1WA=;
        b=g+ipduHCzFgcmH/cwhjnGowb49OHI+jHsqX9oZIhMBRzLJuPl8qBJAvs48tzGpCSY7
         S7tvoo41uD1VZYm8LrMlloM/BqYw70KqqntsyiQ2Z1lPX2Ep3ze4WZt0zvv7yNyYPV6S
         Gjq31uh89+UcR8loghcTRvASsMCH9bQmgKWmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aPAKFF/2rdvdvfOSUxfCOTFQSnfIQhM3jjQws7tcCXmPGFgI8ehw/eU4BjYAuPryuS
         mYZa6pOrp/4wEYGAP5cpPujYXLQ7+Zlm1VdT+wrx81CPl+TNA+a/b6chZyw07NhZrQvB
         Ew21cBREEcGtGX/Oft2WwDal091u/cydfjmAY=
Received: by 10.220.199.2 with SMTP id eq2mr1300233vcb.68.1300731884682;
        Mon, 21 Mar 2011 11:24:44 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.42
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169626>

---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fde9f9e..1da385c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1464,7 +1464,7 @@ static int process_df_entry(struct merge_options *o,
 		handle_delete_modify(o, path, new_path,
 				     a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
-		/* directory -> (directory, file) */
+		/* directory -> (directory, file) or <nothing> -> (directory, file) */
 		const char *add_branch;
 		const char *other_branch;
 		unsigned mode;
-- 
1.7.4
