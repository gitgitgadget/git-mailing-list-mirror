From: Pranit Bauva <pranit.bauva@zoho.com>
Subject: [PATCH] SubmittingPatches : WIP tag in patches
Date: Fri, 26 Feb 2016 14:05:22 +0000
Message-ID: <56D05BA2.1090502@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDH1-0001LY-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbcBZH5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:57:06 -0500
Received: from sender153-mail.zoho.com ([74.201.84.153]:22818 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbcBZH5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:57:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=to:from:subject:message-id:date:mime-version:content-type; 
  b=H4K8Y1cva88C31TZonSyDAvTQFOuJcEgdiIhAaEHL2QHP4ubGkj+w7J1AjJDaGB22DrqXI54W9j+
    L0CiQnF18ZuivcG5M1QA1jQLOAadKyAfHSr98FkiUohDwcIHb6Ei  
Received: from 127.0.0.1 (exit1.torproxy.org [89.187.142.208]) by mx.zohomail.com
	with SMTPS id 1456473423637811.8733788255757; Thu, 25 Feb 2016 23:57:03 -0800 (PST)
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287544>


---
 Documentation/SubmittingPatches | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches
b/Documentation/SubmittingPatches
index 98fc4cc..b2c7664 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -168,7 +168,9 @@ the closing bracket to mark the nature of the patch
is also
 encouraged.  E.g. [PATCH/RFC] is often used when the patch is
 not ready to be applied but it is for discussion, [PATCH v2],
 [PATCH v3] etc. are often seen when you are sending an update to
-what you have previously sent.
+what you have previously sent. [PATCH/WIP] is often used when some
+work is yet left to be done on the patch but you want to get the
+review on the completed part of the patch.

 "git format-patch" command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
-- 
2.1.4
