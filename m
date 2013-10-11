From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] howto/setup-git-server-over-http.txt: Fix asciidoc formatting
Date: Fri, 11 Oct 2013 20:38:36 +0100
Message-ID: <525853BC.7090501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 21:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUiY2-0002uX-3M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 21:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab3JKTin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 15:38:43 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:52765 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756637Ab3JKTik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 15:38:40 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C95507C1E6;
	Fri, 11 Oct 2013 20:38:38 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 9A0007C1CF;
	Fri, 11 Oct 2013 20:38:38 +0100 (BST)
Received: from [192.168.254.8] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Fri, 11 Oct 2013 20:38:38 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235921>


The text contains two 'grep' invocations which include the 'start
of line' regular expression character '^'. Asciidoc mis-interprets
this use of '^' as a superscript request. In order to fix this
formatting problem, use backticks (`) to quote the text of the
affected 'grep' command invocations.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan,

    $ git grep '\^' Documentation/howto

pointed me to some other candidates, but only this one needed a
similar fix ... :-D

ATB,
Ramsay Jones

 Documentation/howto/setup-git-server-over-http.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 7f4943e..981cbdd 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -81,8 +81,8 @@ Initialize a bare repository
     $ git --bare init
 
 
-Change the ownership to your web-server's credentials. Use "grep ^User
-httpd.conf" and "grep ^Group httpd.conf" to find out:
+Change the ownership to your web-server's credentials. Use `"grep ^User
+httpd.conf"` and `"grep ^Group httpd.conf"` to find out:
 
     $ chown -R www.www .
 
-- 
1.8.4
