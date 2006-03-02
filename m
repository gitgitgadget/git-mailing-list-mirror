From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] annotate should number lines starting with 1
Date: Thu, 2 Mar 2006 15:27:31 -0800
Message-ID: <200603022327.k22NRVek023304@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Fri Mar 03 00:28:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExCp-0007CS-Qw
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 00:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWCBX1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 18:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCBX1c
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 18:27:32 -0500
Received: from fmr23.intel.com ([143.183.121.15]:58819 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751076AbWCBX1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 18:27:32 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k22NRVee008172
	for <git@vger.kernel.org>; Thu, 2 Mar 2006 23:27:31 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k22NRVEJ009016
	for <git@vger.kernel.org>; Thu, 2 Mar 2006 23:27:31 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id A313319F63
	for <git@vger.kernel.org>; Thu,  2 Mar 2006 15:27:31 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k22NRVek023304;
	Thu, 2 Mar 2006 15:27:31 -0800
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17120>

C programmers are well used to counting from zero, but every
other text file tool starts counting from 1.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/git-annotate.perl b/git-annotate.perl
index 08d479f..d93ee19 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -128,7 +128,7 @@ foreach my $l (@filelines) {
 	}
 
 	printf("%s\t(%10s\t%10s\t%d)%s\n", $rev, $committer,
-		format_date($date), $i++, $output);
+		format_date($date), ++$i, $output);
 }
 
 sub init_claim {
