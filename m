From: Tim Chase <git@tim.thechases.com>
Subject: [PATCH] minor diff between gitweb docs and actual template for $GIT/description
Date: Thu, 10 Jan 2013 18:33:12 -0600
Message-ID: <50EF5DC8.1000500@tim.thechases.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070806000202010903070703"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 02:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtT7j-0001mP-G5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 02:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab3AKBJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 20:09:10 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:38367 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841Ab3AKBJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 20:09:09 -0500
X-Greylist: delayed 2230 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2013 20:09:09 EST
Received: from adsl-68-90-202-221.dsl.rcsntx.swbell.net ([68.90.202.221]:41697 helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1TtSXO-0004gw-4z
	for git@vger.kernel.org; Thu, 10 Jan 2013 18:31:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213163>

This is a multi-part message in MIME format.
--------------070806000202010903070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The documentation for gitweb gives one description of the default 
content for the $GIT/description, the description template has other 
text.  One of these two patches should be applied to bring them into 
order (applying both would just reverse the problem).  Or, both 
could be changed to the same new text.

-tkc
(not subscribed to the actual git ML, just git-users@googlegroups.com)



--------------070806000202010903070703
Content-Type: text/plain; charset=us-ascii;
 name="git_change_gitweb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git_change_gitweb.diff"

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 168e8bf..7c4cb69 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -227,7 +227,7 @@ description (or `gitweb.description`)::
 	repository).  Plain text file; HTML will be escaped.  By default set to
 +
 -------------------------------------------------------------------------------
-Unnamed repository; edit this file to name it for gitweb.
+Unnamed repository; edit this file 'description' to name the repository.
 -------------------------------------------------------------------------------
 +
 from the template during repository creation, usually installed in

--------------070806000202010903070703
Content-Type: text/plain; charset=us-ascii;
 name="git_change_template.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git_change_template.diff"

diff --git a/templates/this--description b/templates/this--description
index 498b267..c6f25e8 100644
--- a/templates/this--description
+++ b/templates/this--description
@@ -1 +1 @@
-Unnamed repository; edit this file 'description' to name the repository.
+Unnamed repository; edit this file to name it for gitweb.

--------------070806000202010903070703--
