From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: show-files is now called git-ls-files
Date: Sun, 10 Jan 2010 13:11:49 +0100
Message-ID: <c4e1adc765525b4ac6c63677a27035661462d2b8.1263125504.git.trast@student.ethz.ch>
References: <201001101310.21455.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTweW-0007Gk-EZ
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab0AJMMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660Ab0AJMMN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:12:13 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:30514 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab0AJMMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:12:12 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:12:11 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:11:49 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <201001101310.21455.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136572>

Amazingly, a reference to 'show files' survived from the core command
documentation introduced in c64b9b8 (Reference documentation for the
core git commands., 2005-05-05)!

However, the tool is now called git-ls-files.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-ls-files.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 7faba23..a84cc37 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -140,7 +140,7 @@ OPTIONS
 
 Output
 ------
-show files just outputs the filename unless '--stage' is specified in
+'git ls-files' just outputs the filenames unless '--stage' is specified in
 which case it outputs:
 
         [<tag> ]<mode> <object> <stage> <file>
-- 
1.6.6.218.g502b0
