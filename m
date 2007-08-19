From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Add the word reflog to Documentation/config.txt:core.logAllRefUpdates
Date: Sun, 19 Aug 2007 23:38:57 +0200
Message-ID: <46C8B871.9030408@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 00:03:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMsrW-0006De-J3
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 00:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbXHSWDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Aug 2007 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXHSWDG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 18:03:06 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:43060 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbXHSWDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 18:03:05 -0400
X-Greylist: delayed 1444 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2007 18:03:05 EDT
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id C1C38E523;
	Sun, 19 Aug 2007 23:38:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56156>

This makes it easier to find out how to enable the reflog
for a bare repository by searching the documentation for
"reflog".

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

I had to read config.c before I found the variable.

 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index de9e72b..46f40ad 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -192,7 +192,7 @@ core.worktree::
 	variable and the '--work-tree' command line option.
=20
 core.logAllRefUpdates::
-	Updates to a ref <ref> is logged to the file
+	Enable the reflog. Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
 	SHA1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
--=20
1.5.3.rc5
