From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] add gitignore entry to description about how to write a
 builtin
Date: Wed, 3 Aug 2011 20:06:17 +0200
Message-ID: <20110803180617.GB13057@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:06:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qofpn-0000TF-TR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab1HCSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:06:20 -0400
Received: from darksea.de ([83.133.111.250]:48855 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754636Ab1HCSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:06:19 -0400
Received: (qmail 29971 invoked from network); 3 Aug 2011 20:06:17 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 3 Aug 2011 20:06:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178603>

If the author forgets the gitignore entry the built result will show up
as new file in the git working directory.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/technical/api-builtin.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 5cb2b05..b0cafe8 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -49,6 +49,8 @@ Additionally, if `foo` is a new command, there are 3 more things to do:
 
 . Add an entry for `git-foo` to `command-list.txt`.
 
+. Add an entry for `/git-foo` to `.gitignore`.
+
 
 How a built-in is called
 ------------------------
-- 
1.7.6.353.g02057.dirty
