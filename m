From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9301-fast-export.sh: don't unset config variable while we're
 skipping test 4
Date: Mon, 18 Aug 2008 18:20:12 -0500
Message-ID: <kbCw6MBjduXNz0eWrsdfGIVr60qjr7cf1eJqhd4l-UzDfHEk1LrlkA@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE2J-00067i-IU
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbYHRXUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYHRXUP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:20:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60929 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbYHRXUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:20:14 -0400
Received: by mail.nrlssc.navy.mil id m7INKDqH026612; Mon, 18 Aug 2008 18:20:13 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:20:12.0718 (UTC) FILETIME=[F6F4ACE0:01C90188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92758>

---


This is necessary if t9301.4 is included in the GIT_SKIP_TESTS
environment variable.

-brandon


 t/t9301-fast-export.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index c19b4a2..475aadd 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -190,7 +190,6 @@ export GIT_COMMITTER_NAME='C O Mitter'
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
-- 
1.6.0.13.ge1c8
