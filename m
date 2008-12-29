From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-config.txt: clarify order of option reading
Date: Mon, 29 Dec 2008 14:13:22 +0800
Message-ID: <87myef33wd.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 07:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHBOq-0004H9-O7
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 07:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbYL2GN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 01:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbYL2GN1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 01:13:27 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:59903 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750818AbYL2GN0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 01:13:26 -0500
Received: from jidanni.org (122-127-43-85.dynamic.hinet.net [122.127.43.85])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 56E0ED26BD
	for <git@vger.kernel.org>; Sun, 28 Dec 2008 22:13:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104071>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-config.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 19a8917..34041b1 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -176,6 +176,8 @@ $GIT_DIR/config::
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
 
+Options found earlier in this sequence override those found later.
+
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
-- 
1.5.6.5
