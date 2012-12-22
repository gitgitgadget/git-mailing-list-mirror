From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] git-subtree: ignore git-subtree executable
Date: Sat, 22 Dec 2012 15:45:40 +0100
Message-ID: <50D5C794.4070400@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmQVc-0006tS-GH
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 15:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2LVO4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 09:56:46 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:56855 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab2LVO4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 09:56:45 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2012 09:56:45 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 04691DE062
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 15:50:31 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1EPJSfUpEwT for <git@vger.kernel.org>;
	Sat, 22 Dec 2012 15:50:30 +0100 (CET)
Received: from [192.168.1.3] (p5DD1564E.dip.t-dialin.net [93.209.86.78])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id DE29CDE05B
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 15:50:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212053>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 contrib/subtree/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 7e77c9d..91360a3 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,4 +1,5 @@
 *~
+git-subtree
 git-subtree.xml
 git-subtree.1
 mainline
-- 
1.8.1.rc2.333.g912e06f.dirty
