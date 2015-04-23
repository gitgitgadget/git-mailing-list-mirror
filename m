From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] RelNotes: correct name of versionsort.prereleaseSuffix
Date: Thu, 23 Apr 2015 14:27:48 +0200
Message-ID: <1429792070-22991-4-git-send-email-mhagger@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEn-0005tW-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934427AbbDWM2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:28:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42377 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934419AbbDWM2B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:28:01 -0400
X-AuditID: 12074414-f797f6d000004084-5d-5538e55033e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B1.6D.16516.055E8355; Thu, 23 Apr 2015 08:28:00 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfM011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:27:59 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqBvw1CLU4NpEDouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Ydsyn4DNbxZJ1W5gbGG+z
	djFyckgImEhMebiTDcIWk7hwbz2YLSRwmVGiY71GFyMXkH2cSWLlljfMIAk2AV2JRT3NTCC2
	iICaxMS2QywgNrOAg8Tmz42MILawgLdE86MWMJtFQFViwr65YMt4BVwkTq5bzQixTE7i/PGf
	YDM5BVwltk9vY4ZY7CLx+c4d9gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW
	6KWmlG5ihASKyA7GIyflDjEKcDAq8fC+yLYIFWJNLCuuzD3EKMnBpCTKe/YmUIgvKT+lMiOx
	OCO+qDQntfgQowQHs5II757bQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQlexSdAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGguIgvBkYGSIoHaG8l
	SDtvcUFiLlAUovUUoy7HnSn/FzEJseTl56VKifPWgRQJgBRllObBrYClhVeM4kAfC/Nqg1Tx
	AFMK3KRXQEuYgJbMXAq2pCQRISXVwKhUsuHNzbBbUQt1Ej8UOe6+FmZsp9DtOCEli5fpYciR
	ujTJ2f8Xz1yufOdvs79Kx/YFE7YsXbtpTkRtiYhLgkXUvYz4NO/qmL4T/Ps5T81K+HdmPZeH
	jXzyO48DYvc/fP7oxRmj28ZufOjV7bN3O7Ydulp4yOGcc57ylzMmL/4E8qkVr7Oc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267687>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/RelNotes/2.4.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
index a0ee37d..c02de8d 100644
--- a/Documentation/RelNotes/2.4.0.txt
+++ b/Documentation/RelNotes/2.4.0.txt
@@ -109,8 +109,8 @@ UI, Workflows & Features
    "cd ''" which silently behaves as a no-op.
    (merge 6a536e2 kn/git-cd-to-empty later to maint).
 
- * The versionsort.prerelease configuration variable can be used to
-   specify that v1.0-pre1 comes before v1.0.
+ * The versionsort.prereleaseSuffix configuration variable can be used
+   to specify that v1.0-pre1 comes before v1.0.
 
  * A new "push.followTags" configuration turns the "--follow-tags"
    option on by default for the "git push" command.
-- 
2.1.4
