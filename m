From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v2] Smart-http documentation: add example of how to execute from userdir
Date: Sun, 27 Dec 2009 23:46:52 -0500
Message-ID: <1261975612-67101-1-git-send-email-tarmigan+git@gmail.com>
References: <905315640912272018r1282394fh62d37b5c9e91a234@mail.gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 05:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP7Xb-000897-29
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZL1ErO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 23:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZL1ErO
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:47:14 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:40111 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZL1ErN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 23:47:13 -0500
Received: by qyk30 with SMTP id 30so4679021qyk.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0M6YCOSCyRMYDpqT6Dwmx/8U8VkKZvQF9kDXuGI/vyk=;
        b=S/jGlR0dOESkHdz7HEfvE0ShJQaB5CRig9bf+RZdcm6yxl0y39PWTFJcQnws/5xOD2
         4OZwZmcAxt9DgDhLz1qmX6HJ0gpzbFVQwHdZJNKVPRD4LKkGi15dRCd/Y4MHOQSaQ2zV
         s/MtzY5x92/WpCYf3J1p/dy8VaBV7UJzSDT3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=fTmt/7zXfHyEiKDpjidJoTL33bzvb2wnR4KvdscV3wrNjIbjfmM8ymkw1Lb9KWWP7U
         PWIm6GOrdaj1GJd2n6iJiQVDklarua3rwAnyDWlOE34FBI6V9ea7lDgzCRMLQ7Auo+q8
         uGvF5tdsTwPoCrrzr4bgLfzj4RDHhJgiK/rZM=
Received: by 10.229.102.165 with SMTP id g37mr6433436qco.65.1261975632673;
        Sun, 27 Dec 2009 20:47:12 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 21sm10145879qyk.8.2009.12.27.20.47.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 20:47:11 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.g8eede.dirty
In-Reply-To: <905315640912272018r1282394fh62d37b5c9e91a234@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135727>

Smart-http may be an attactive and easy way for people to setup git
hosting on shared servers whose primary web server configuration they
do not control.  To facilite this, provide an example of how it may be
done.

cc: Tay Ray Chuan <rctay89@gmail.com>
cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
Looking at the 
	s/update/updates/
suggestion again, I decided not to make that change because I think
the original is grammical even if a little bit awkward.  The first
'updates' is the noun, so the verb should be 'update' without an 's'.

I also tried rephrasing that sentence completely, but did not end up
with something better.  Suggestions welcome.

 Documentation/git-http-backend.txt |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..fdff2d3 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -60,8 +60,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
-All of the following examples map 'http://$hostname/git/foo/bar.git'
-to '/var/www/git/foo/bar.git'.
+Unless otherwise noted, the following examples map
+'http://$hostname/git/foo/bar.git' to '/var/www/git/foo/bar.git'.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
@@ -144,6 +144,33 @@ ScriptAliasMatch \
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
+In the following example, a repository at
+'/home/$username/devel/foo/bar.git' will be accessible at
+'http://$hostname/\~$username/cgi-bin/git/foo/bar.git'
+
+From UserDir on Apache 2.x::
+       One way to configure 'git-http-backend' to execute and serve
+       from a user directory (for example, on a shared hosting
+       provider), is to have a symbolic link named 'git' that points
+       from the cgi directory to the 'git-http-backend' executable in
+       libexec.  The advantage of the symbolic link is that any updates
+       to the installed version of 'git-http-backend' also update the
+       version that is run in the userdir.
++
+----------------------------------------------------------------
+SetHandler cgi-script
+Options +SymLinksIfOwnerMatch
+SetEnv GIT_PROJECT_ROOT /home/$username/devel
+----------------------------------------------------------------
++
+Also add any needed authentication to the .htaccess file as discussed
+in earlier examples.
++
+If the web server does not follow any symbolic links, the
+'git-http-backend' executable may be copied into the cgi-bin directory
+and renamed to 'git' to acheive the same effect, but it will also need
+to be manually updated whenever a new version of 'git-http-backend' is
+installed.
 
 ENVIRONMENT
 -----------
-- 
1.6.6.1.g8eede.dirty
