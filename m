From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 3/4] Header Includes Cleanup Part 2
Date: Tue, 31 Mar 2009 02:45:20 -0700
Message-ID: <1238492721-92484-4-git-send-email-nathaniel.dawson@gmail.com>
References: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-2-git-send-email-nathaniel.dawson@gmail.com>
 <1238492721-92484-3-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaZ7-0007cn-TN
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbZCaJph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZCaJpf
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:45:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbZCaJpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:45:33 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2938874rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KWWDkoHSKf+gj2J2TNoOInwCt2G8WhsiZ6XdqpmkieA=;
        b=ZIfXeK0c9rUa/nZQMe6gkpt1F7rC8LTMglpIAW54ibXJGtcmrOWCSiV6NnTtGs+9W0
         oh6y8SsaQtwFr2Pp1Ba18XxPNJ02EKRKRKXga0rtd1t7ZUD/PQ9Sb0+56DDnBtB2P4MW
         T5MigkTcJDeT9PyS23WLuJRoY4tfS3YMiSI3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LkzJ7z4MCcWh4kgoOvVpxDFOCsineuP//hsSaUFVr57qRFjQxZ37X1DGznpAsUKVQ3
         bfJBl9b7bYGRrtGM8cZstU6zN0ySQNBiq2OVIUpjG100pjmwZRSbH+/oxJ2jHhtRZ0Q8
         Vyxz++4DJofRdFYCNHTj/wXppJhPj6oM1BJK8=
Received: by 10.141.62.9 with SMTP id p9mr3380511rvk.80.1238492732113;
        Tue, 31 Mar 2009 02:45:32 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id g14sm16450022rvb.19.2009.03.31.02.45.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 02:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238492721-92484-3-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115242>

Deleted includes of string-list.h where merge-recursive.h was included
since it includes string-list.h.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 merge-recursive.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 370151e..40d636f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -10,11 +10,10 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "unpack-trees.h"
-#include "string-list.h"
+#include "merge-recursive.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "attr.h"
-#include "merge-recursive.h"
 #include "dir.h"
 
 static struct tree *shift_tree_object(struct tree *one, struct tree *two)
-- 
1.6.1.3
