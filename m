From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: blame: Minimize vertical table row padding
Date: Thu, 5 Oct 2006 13:30:31 -0700 (PDT)
Message-ID: <20061005203031.33938.qmail@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-99531278-1160080231=:32588"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 22:34:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVZrh-0005Ir-4V
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 22:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWJEUad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWJEUad
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 16:30:33 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:7513 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932070AbWJEUac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 16:30:32 -0400
Received: (qmail 33940 invoked by uid 60001); 5 Oct 2006 20:30:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XFcJTTd8BjOuun4OG0RuC7zP/OLkSy/Gh/XscseuAHwzlbfFZy4rmK07yUMaKqKX7J8vtK3o/GEL9AHrnKuSGyo/BwqfGE5dBHscXcqRsRmEXEznRbPeB8Q41bq9PVuMSd9ZKOpZ2aJaCAmfRoTqTs15pkMwkGQErkV6i216pks=  ;
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Thu, 05 Oct 2006 13:30:31 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28361>

--0-99531278-1160080231=:32588
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Minimize vertical table row padding for blame only.  I
discovered this while having the browser's blame output
right next to my editor's window, only to notice how much
vertically stretched the blame output was.

Blame most likely shows source code and is in this way
more "spartan" than the rest of the tables gitweb shows.

This patch makes the blame table more vertically compact,
thus being closer to what you'd see in your editor's window,
as well as reusing more window estate to show more
information (which in turn minimizes scrolling).

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.css |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
--0-99531278-1160080231=:32588
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index eb9fc38..668e69a 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -173,6 +173,12 @@ table.blame {
 	border-collapse: collapse;
 }
 
+table.blame td {
+	padding: 0px 5px;
+	font-size: 12px;
+	vertical-align: top;
+}
+
 th {
 	padding: 2px 5px;
 	font-size: 12px;
-- 
1.4.2.3.gc45c-dirty


--0-99531278-1160080231=:32588--
