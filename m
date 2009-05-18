From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 7/8] t9301: use ISO8859-1 rather than ISO-8859-1
Date: Mon, 18 May 2009 18:44:44 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpD_AmxNUeXbQUOa7RCzy3RyTmaiqpcJHJcp9eR8w363qcg0oZzieLd0@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpPhpa6XnDlrUaNKPjrH6NYGZK9NzwH2STGreDnkCUEwiMxu0BD6uSgk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKMgDQvtEffFhDQ5lsZU861rwPvLMbXRKufUbP1Cj7yuYKrGcvxDsnU@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CWl-0003iT-FG
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZERXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbZERXpI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50121 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZERXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:59 -0400
Received: by mail.nrlssc.navy.mil id n4INitKW024906; Mon, 18 May 2009 18:45:00 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpKMgDQvtEffFhDQ5lsZU861rwPvLMbXRKufUbP1Cj7yuYKrGcvxDsnU@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:56.0043 (UTC) FILETIME=[A5DBDBB0:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119477>

Some ancient platforms do not have an extensive list of alternate names for
character encodings.  For example, Solaris 7 does not know that ISO-8859-1
is the same as ISO8859-1.  Modern platforms do know this, so use the older
name.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Feel free to squash.


 t/t9301-fast-export.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 8da9ce5..8c8a9e6 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -68,7 +68,7 @@ test_expect_success 'fast-export master~2..master' '
 
 test_expect_success 'iso-8859-1' '
 
-	git config i18n.commitencoding ISO-8859-1 &&
+	git config i18n.commitencoding ISO8859-1 &&
 	# use author and committer name in ISO-8859-1 to match it.
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 	test_tick &&
-- 
1.6.3.1.24.g152f4
