From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/6] git-format-patch.txt: Add to Thunderbird configuration
Date: Sun, 06 Oct 2013 21:51:31 +0100
Message-ID: <5251CD53.10204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvIf-0007HT-FC
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab3JFUvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:51:33 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:38222 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753756Ab3JFUvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:51:33 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 83C166FBB19;
	Sun,  6 Oct 2013 21:51:32 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 55C8E6FBABE;
	Sun,  6 Oct 2013 21:51:32 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:51:32 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235749>


The Thunderbird section of the 'MUA-specific hints' contains three
different approaches to setting up the mail client to leave patch
emails unmolested. The second approach (configuration) has a step
missing when configuring the composition window not to wrap. In
particular, the "mailnews.wraplength" configuration variable needs
to be set to zero. Update the documentation to add the missing
setting.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Documentation/git-format-patch.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9e0ef0e..5c0a4ab 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -438,7 +438,8 @@ Edit..Preferences..Composition, wrap plain text messages at 0
 In Thunderbird 3:
 Edit..Preferences..Advanced..Config Editor.  Search for
 "mail.wrap_long_lines".
-Toggle it to make sure it is set to `false`.
+Toggle it to make sure it is set to `false`. Also, search for
+"mailnews.wraplength" and set the value to 0.
 
 3. Disable the use of format=flowed:
 Edit..Preferences..Advanced..Config Editor.  Search for
-- 
1.8.4
