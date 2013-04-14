From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 2/2] Doc: State the exact git version string
Date: Sun, 14 Apr 2013 15:27:26 +0100
Message-ID: <1365949646-1988-3-git-send-email-philipoakley@iee.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 14 16:27:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URNu8-00034e-O2
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 16:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3DNO12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 10:27:28 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25421 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab3DNO1Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 10:27:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhsMACu8alFZ8Yth/2dsb2JhbAAuIoMGgn2+dAQBgQIXdIIgAQVWMwhJOR4GE4gYuXONeoEkg0EDqBaDDDs
X-IronPort-AV: E=Sophos;i="4.87,471,1363132800"; 
   d="scan'208";a="68976723"
Received: from host-89-241-139-97.as13285.net (HELO localhost) ([89.241.139.97])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 14 Apr 2013 15:27:22 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221139>

Provide the regular expression that matches the
'git --version' strings.

Scripts in the wild, including 'git gui', check the git version.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

Should the string be described by a regular expression?

How to format the regular expression for asciidocs - it doesn't
get made correctly - I'm not sure what special magic incantation
is needed here.

 Documentation/git.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7efaa59..627e462 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -365,6 +365,10 @@ OPTIONS
 -------
 --version::
 	Prints the Git suite version that the 'git' program came from.
+	The version string is a single line that matches the extended
+	regular expression
+	'^git version [0-9]+\.[0-9]+\.[0-9]+.*'
+	and is less than 80 characters.
 
 --help::
 	Prints the synopsis and a list of the most commonly used
-- 
1.8.1.msysgit.1
