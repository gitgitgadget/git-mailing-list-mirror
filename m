From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] status: document the -v/--verbose option
Date: Thu, 23 Apr 2015 14:27:46 +0200
Message-ID: <1429792070-22991-2-git-send-email-mhagger@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEf-0005l3-9w
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934416AbbDWM2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:28:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49334 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934298AbbDWM17 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:27:59 -0400
X-AuditID: 12074413-f79f26d0000030e7-b1-5538e54e3de3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 61.2D.12519.E45E8355; Thu, 23 Apr 2015 08:27:58 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfK011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:27:57 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqOv31CLUYEUfv0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfcaDzJUjCfvWL39MwGxm+s
	XYycHBICJhLfOh8yQthiEhfurWfrYuTiEBK4zChxe+cTJgjnOJPExDUzmUCq2AR0JRb1NIPZ
	IgJqEhPbDrGA2MwCDhKbPzeCTRIWsJWY0b0YaBIHB4uAqkTPzwCQMK+Ai8Sbrx/ZIJbJSZw/
	/pMZxOYUcJXYPr0NzBYCqvl85w77BEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVy
	M0v0UlNKNzFCAkV4B+Ouk3KHGAU4GJV4eF9kW4QKsSaWFVfmHmKU5GBSEuU9exMoxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYR3z22gHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoR
	TFaGg0NJglfxCVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgu4ouBkQGS4gHa
	WwnSzltckJgLFIVoPcWoy3Fnyv9FTEIsefl5qVLivBIgRQIgRRmleXArYGnhFaM40MfCvNog
	VTzAlAI36RXQEiagJTOXgi0pSURISTUwzj3Mb733/3wbD+4PbaeNTuzxs3B+IBEnzTl5x7GD
	d77315iL/7+5mO+7Xiaj2oKJ/HeOmj7qYts25bGqpNuG6TNVppl93nNkrU8Dp72ttsntXt/g
	b8lcu/XDCl6eT+lgkJjmbZLDtqHB795zOz0zzt0KTX0f/T7qd6zZyy11080zYxEb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267683>

Document `git status -v`, including its new doubled `-vv` form.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-status.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b3319f7..9ec5897 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -41,6 +41,15 @@ OPTIONS
 --long::
 	Give the output in the long-format. This is the default.
 
+-v::
+--verbose::
+	In addition to the names of files that have been changed, also
+	show the textual changes that are staged to be committed
+	(i.e., like the output of `git diff`). If `-v` is specified
+	twice, then also show the changes in the working tree that
+	have not yet been staged (i.e., like the output of `git diff
+	--cached`).
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
-- 
2.1.4
