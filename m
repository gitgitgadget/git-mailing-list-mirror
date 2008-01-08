From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: config: add 'help.*' and 'instaweb.*'
 variables.
Date: Tue, 8 Jan 2008 04:55:14 +0100
Message-ID: <20080108045514.1a506761.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 04:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC5Sx-0006QZ-6N
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 04:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbYAHDtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 22:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbYAHDs7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 22:48:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:38693 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbYAHDs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 22:48:59 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3BFB21AB2B5;
	Tue,  8 Jan 2008 04:48:57 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 04FFC1AB2AF;
	Tue,  8 Jan 2008 04:48:56 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69836>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e1eaee9..c9895dc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -585,6 +585,15 @@ specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+help.browser::
+	Specify the browser that will be used to display help in the
+	'web' format. See gitlink:git-help[1].
+
+help.format::
+	Override the default help format used by gitlink:git-help[1].
+	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
+	the default. 'web' and 'html' are the same.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see gitlink:curl[1]).  This can be overridden
@@ -642,6 +651,25 @@ i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
 	running `git-log` and friends.
 
+instaweb.browser::
+	Specify the program that will be used to browse your working
+	repository in gitweb. See gitlink:git-instaweb[1].
+
+instaweb.httpd::
+	The HTTP daemon command-line to start gitweb on your working
+	repository. See gitlink:git-instaweb[1].
+
+instaweb.local::
+	If true the web server started by gitlink:git-instaweb[1] will
+	be bound to the local IP (127.0.0.1).
+
+instaweb.modulepath::
+	The module path for an apache httpd used by gitlink:git-instaweb[1].
+
+instaweb.port::
+	The port number to bind the gitweb httpd to. See
+	gitlink:git-instaweb[1].
+
 log.showroot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
@@ -843,4 +871,8 @@ receive.denyNonFastForwards::
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
+
+web.browser::
+	Specify a web browser that may be used by some commands.
+	Currently only gitlink:git-instaweb[1] and gitlink:git-help[1]
+	may use it.
-- 
1.5.4.rc2.38.gd6da3
