From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] merge-recursive: Remove miss leading comment
Date: Tue, 23 Sep 2014 16:55:50 +0200
Message-ID: <1411484150-18025-1-git-send-email-stefanbeller@gmail.com>
References: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 23 16:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWRVc-0003Xp-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 16:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbaIWOzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 10:55:55 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43406 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbaIWOzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 10:55:53 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so4793914wgg.6
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jUKBv8XHz89qwg8WPT4ulp1xc5wVclJ66aVEpTQ6J5Q=;
        b=Fu41FSex/CKFrtU/LFOLDyC7gb0hXCUREWx1KbxdrCNs1Ndjhutk/kmwKhmmWJiSuP
         mlmX6kxdP19r7DXMlCKdUmPpgj2DW6NvxrLgxBMg6Qfd2wNrGTrDEOBsx0p8z1QyVvhA
         hO7TOLB16Jon657qM1yiRKwiakw9hi8qqW7Cu4sa9VbWa+LthguBGrzOoGaD/Taa/aDI
         y46DlbtAY7HL4ZlMfrH7q/98J0lfACv30WsUTrfwNwPMIdhJ1Fk+JEBp2QbuSvavQNJm
         I/uuqKTIe5pQtbNPq1YpZDSYBYBRu7xGV70ZB3uZ4Ogn6GPfkv0PSAkErQWd1pZSchvD
         9BhA==
X-Received: by 10.180.186.230 with SMTP id fn6mr23805843wic.44.1411484152270;
        Tue, 23 Sep 2014 07:55:52 -0700 (PDT)
Received: from localhost (p5B095AC8.dip0.t-ipconnect.de. [91.9.90.200])
        by mx.google.com with ESMTPSA id hm5sm16209456wjb.2.2014.09.23.07.55.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 07:55:51 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
In-Reply-To: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257420>

Commented code, which doesn't even compile, is of no use any more?

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---

To be applied on top of sb/merge-recursive-copy-paste-fix


 merge-recursive.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d63524c..8ad4be8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1686,10 +1686,6 @@ static int merge_content(struct merge_options *o,
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
 {
-	/*
-	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
-	print_index_entry("\tpath: ", entry);
-	*/
 	int clean_merge = 1;
 	int normalize = o->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
-- 
2.1.0.238.gce1d3a9
