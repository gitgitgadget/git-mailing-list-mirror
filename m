From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 01/10] .gitattributes: specify the language used
Date: Thu, 27 Mar 2014 14:50:47 -0400
Message-ID: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOi-0004oC-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206AbaC0SvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50315 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137AbaC0SvX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:23 -0400
X-AuditID: 1207440d-f79d86d0000043db-3b-5334732a9191
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.36.17371.A2374335; Thu, 27 Mar 2014 14:51:22 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TJ013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:21 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsUixO6iqKtVbBJs8HShhMXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4Mo4PeU0U8EktorJL6+wNjBOYe1i5OSQEDCRWPz5EZQtJnHh3no2EFtI4DKjxJodhV2M
	XED2SiaJ5geHWEASbALOEpt+7WcCsUUExCXeHp/JDlLELLCQUeLtnsnMIAlhAQeJjqdzwKay
	CKhKbDi9FizOKxAlMbdxKxPENgOJT8/OgMU5geonz98IZHMAbbOX+LjUdgIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYISHFu4Px/zqZQ4wCHIxKPLwOFibBQqyJ
	ZcWVuYcYJTiYlUR45xYAhXhTEiurUovy44tKc1KLDzFKc7AoifOqLVH3ExJITyxJzU5NLUgt
	gskycXBKNTD68jTsvmaQZr5qruurtLtKE8/UKZ18WNPrpb7hzuFvHY+vGszZa/H1dbiKwtLv
	0/7mV3xUTfIrcNt+z+mTvSm7+NqG/F/+70Nuzq+JefbB47SqZXDH2c1rahm8Vv97dW2jiefH
	mcXdMfPXh+brK1fssHUMm7EvNm/Sg0liZZla+8997slicz2nxFKckWioxVxUnAgAWROfLiUC
	AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245309>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

Since git can intelligently emit diff hunk headers based on the
programming language of each file, assuming that the language is
specified in .gitattributes, it makes sense to specify our own
language (cpp) in our own .gitattributes file.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 5e98806..320e33c 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,3 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space
+*.[ch] whitespace=indent,trail,space diff=cpp
 *.sh whitespace=indent,trail,space
-- 
1.7.12.4 (Apple Git-37)
