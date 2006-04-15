From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Fix a warning.
Date: Sat, 15 Apr 2006 12:50:14 +0900
Organization: CodeWeavers
Message-ID: <44406D76.1020102@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090701090507040900000205"
X-From: git-owner@vger.kernel.org Sat Apr 15 05:55:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUbsq-0004vf-HD
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 05:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWDODz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 23:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWDODz2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 23:55:28 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:61656 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1030229AbWDODz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 23:55:28 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FUbsX-0007Hw-9v
	for git@vger.kernel.org; Fri, 14 Apr 2006 22:55:27 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us, ko-kr
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18723>

This is a multi-part message in MIME format.
--------------090701090507040900000205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Mike McCormack <mike@codeweavers.com>


---

  diff-tree.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)


--------------090701090507040900000205
Content-Type: text/x-patch;
 name="2fa977d19bee245aef86d9beb307d742111890d7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2fa977d19bee245aef86d9beb307d742111890d7.diff"

2fa977d19bee245aef86d9beb307d742111890d7
diff --git a/diff-tree.c b/diff-tree.c
index 2b79dd0..7015b06 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -120,7 +120,7 @@ int main(int argc, const char **argv)
 	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
 		opt->diffopt.recursive = 1;
 
-	diff_tree_setup_paths(get_pathspec(prefix, argv), opt);
+	diff_tree_setup_paths(get_pathspec(prefix, argv), &opt->diffopt);
 	diff_setup_done(&opt->diffopt);
 
 	switch (nr_sha1) {


--------------090701090507040900000205--
