From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] config: Rummage through ~/.gitrc as well as the repository's config.
Date: Fri, 03 Feb 2006 20:33:32 +0000
Message-ID: <20060203203332.2718.13451.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:34:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57cf-0007rv-R5
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWBCUdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBCUdf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:33:35 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:15924 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751461AbWBCUde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:33:34 -0500
Received: (qmail 2739 invoked from network); 3 Feb 2006 20:33:32 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?Haaf7LKV8QrMpgEhv7er9+dWQO8VsdMv?@127.0.0.1)
  by localhost with SMTP; 3 Feb 2006 20:33:32 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15550>

From: Mark Wooding <mdw@distorted.org.uk>

I'm fed up of setting user.email in every repository I own.  I want to
put this somewhere central, and I shouldn't have to log in again to make
it take effect.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 Documentation/git.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e8ef3ef..eab3d46 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -468,6 +468,10 @@ people.  Here is an example:
 Various commands read from the configuration file and adjust
 their operation accordingly.
 
+You can also have a global configuration file, in exactly the same
+format, in the file `.gitrc` in your home directory.  This is a handy
+place to put your name and email address.
+
 
 Identifier Terminology
 ----------------------
