From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 1/2] Documentation/githooks: mention pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 18:11:42 -0500
Message-ID: <1420931503-22857-2-git-send-email-rhansen@bbn.com>
References: <54B0E1EE.2020301@kdbg.org>
 <1420931503-22857-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: 6t@kdbg.org
X-From: git-owner@vger.kernel.org Sun Jan 11 00:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA5CP-0001v6-Tg
	for gcvg-git-2@plane.gmane.org; Sun, 11 Jan 2015 00:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbAJXMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 18:12:00 -0500
Received: from smtp.bbn.com ([128.33.1.81]:13815 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbAJXMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 18:12:00 -0500
Received: from socket.bbn.com ([192.1.120.102]:35762)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1YA5CI-0003ht-8E; Sat, 10 Jan 2015 18:11:58 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D27923FF9A
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420931503-22857-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262280>

Document that hooks are run from the top-level directory and that
GIT_PREFIX is set to the name of the original subdirectory (relative
to the top-level directory).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/githooks.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..c08f4fd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -26,6 +26,12 @@ executable by default.
 
 This document describes the currently defined hooks.
 
+Hooks are executed from the top-level directory of a repository, which
+may not necessarily be the current directory.
+The 'GIT_PREFIX' environment variable is set as returned by running
+'git rev-parse --show-prefix' from the original current directory.
+See linkgit:git-rev-parse[1].
+
 HOOKS
 -----
 
-- 
2.2.1
