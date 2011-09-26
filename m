From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 2/2] templates/hooks--*: don't refer to contrib hooks
Date: Mon, 26 Sep 2011 12:59:32 +0000
Message-ID: <20110926125932.27854.qmail@804c778e7e6607.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 14:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8AmX-0007T2-5N
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 14:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1IZM7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 08:59:34 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:45697 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958Ab1IZM7e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 08:59:34 -0400
Received: (qmail 27855 invoked by uid 1000); 26 Sep 2011 12:59:32 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182108>

Simplify the sample post-receive hook to not refer to some location of a
contrib hook that might be installed in different locations on different
systems.  Instead simply provide a sample file that does nothing just as
the post-commit sample hook.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--post-receive.sample |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
index 7a83e17..5b1771f 100755
--- a/templates/hooks--post-receive.sample
+++ b/templates/hooks--post-receive.sample
@@ -2,14 +2,6 @@
 #
 # An example hook script for the "post-receive" event.
 #
-# The "post-receive" script is run after receive-pack has accepted a pack
-# and the repository has been updated.  It is passed arguments in through
-# stdin in the form
-#  <oldrev> <newrev> <refname>
-# For example:
-#  aa453216d1b3e49e7f6f98441fa56946ddcd6a20 68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
-#
-# see contrib/hooks/ for a sample, or uncomment the next line and
-# rename the file to "post-receive".
+# To enable this hook, rename this file to "post-receive".
 
-#. /usr/share/doc/git-core/contrib/hooks/post-receive-email
+: Nothing
-- 
1.7.6.3
