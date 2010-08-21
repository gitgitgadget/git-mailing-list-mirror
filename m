From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] Tell ignore file about generate files in /gitweb/static
Date: Sat, 21 Aug 2010 12:18:37 -0400
Message-ID: <4C6FFC5D.2090506@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 18:26:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmquB-0007Hn-L0
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab0HUQ0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 12:26:42 -0400
Received: from googpilot.uwaterloo.ca ([129.97.128.141]:34377 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751089Ab0HUQ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 12:26:41 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Aug 2010 12:26:41 EDT
Received: from karakura.local (bas1-toronto01-1177657567.dsl.bell.ca [70.49.160.223])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id o7LGIbng028507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Aug 2010 12:18:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
X-UUID: acd1f995-6daf-44e1-93a5-7f1e39543c7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154143>


Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---

Noticed this while compiling today.

 .gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1a928c3..20560b8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,7 +158,7 @@
 /gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
-/gitweb/gitweb.min.*
+/gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
 /test-date
-- 
1.7.2.2.537.g0cead.dirty
