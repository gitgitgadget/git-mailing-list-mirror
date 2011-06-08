From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 17/48] merge-recursive: Correct a comment
Date: Wed,  8 Jun 2011 01:30:47 -0600
Message-ID: <1307518278-23814-18-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEs-0006q0-ON
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab1FHHbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1FHH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:29 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=3yv2GGIUfekaA9tBNRIOeAj/Xfl4asxxMaK3L40Ue54=;
        b=EAldbuyJSkWKURQKyUxsTiLhWlPdWe2JMco7vwdpWdlrzfSZoA7NsLPm66eJvRUWJ9
         yYZhBbjf88ntdwp+x2koP/qJuccGvHrHK2jPgDRJEBd98zQxVsXw1HP2roQnzjoZWQ30
         MzOAX+4oP+mmd0UyY0guboxWD1TsGPdkvSDkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k9dvwikboLxqiIZZVf5pOCgtSJ/bBiBsmrhY7KXuRhMfwVlGr+HkRqhkC6U/RtEQBb
         oMajKVaejLzotATxQ6DYsRHfMoG0WTQb4We2JNvOlJlm41uDsardSjjqXgCVhiq2O6op
         h/GZ3kpKdja/0fI3jtujAizAkAMb0H67TSV04=
Received: by 10.68.32.226 with SMTP id m2mr610135pbi.444.1307518169677;
        Wed, 08 Jun 2011 00:29:29 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.27
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175335>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3fcd0a5..3d464d9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1439,7 +1439,7 @@ static int process_df_entry(struct merge_options *o,
 		handle_delete_modify(o, path, new_path,
 				     a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
-		/* directory -> (directory, file) */
+		/* directory -> (directory, file) or <nothing> -> (directory, file) */
 		const char *add_branch;
 		const char *other_branch;
 		unsigned mode;
-- 
1.7.6.rc0.62.g2d69f
