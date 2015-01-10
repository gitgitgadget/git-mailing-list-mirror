From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 1/2] Documentation/githooks: mention pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 01:49:57 -0500
Message-ID: <1420872598-9609-2-git-send-email-rhansen@bbn.com>
References: <1420872598-9609-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 07:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9psQ-0004lS-On
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 07:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbbAJGuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 01:50:21 -0500
Received: from smtp.bbn.com ([128.33.1.81]:13298 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbbAJGuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 01:50:19 -0500
Received: from socket.bbn.com ([192.1.120.102]:35716)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y9psE-00018d-00; Sat, 10 Jan 2015 01:50:14 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id AAAD93FF9A
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420872598-9609-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262258>

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
