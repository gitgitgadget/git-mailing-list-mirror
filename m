From: Yann Droneaud <yann@droneaud.fr>
Subject: [PATCH 4/4] t9129: use "$PERL_PATH" instead of "perl"
Date: Thu,  6 Jan 2011 15:22:17 +0100
Message-ID: <74b3db2e538abb4c06d7a0792dff9d78636e2758.1294312018.git.yann@droneaud.fr>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr> <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
Cc: Yann Droneaud <yann@droneaud.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 15:31:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaqsS-00024t-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 15:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab1AFObj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 09:31:39 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:40516 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1AFObj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 09:31:39 -0500
Received: from deela.quest-ce.net ([80.12.81.242])
	by mwinf5d25 with ME
	id sEPf1f00X5DhHAg03EPfyg; Thu, 06 Jan 2011 15:23:40 +0100
Received: from deela.quest-ce.net (localhost.localdomain [127.0.0.1])
	by deela.quest-ce.net (8.14.4/8.14.4) with ESMTP id p06ENK29031821;
	Thu, 6 Jan 2011 15:23:33 +0100
Received: (from ydroneaud@localhost)
	by deela.quest-ce.net (8.14.4/8.14.4/Submit) id p06ENJSt031820;
	Thu, 6 Jan 2011 15:23:19 +0100
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1294312018.git.yann@droneaud.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164635>

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index f3bbde4..6dda569 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -22,7 +22,7 @@ compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
 	LC_ALL=$GIT_LC_UTF8 svn log `git svn info --url` | \
-	    LC_ALL=$GIT_LC_UTF8 perl -w -e '
+	    LC_ALL=$GIT_LC_UTF8 $PERL_PATH -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
-- 
1.7.3.4
