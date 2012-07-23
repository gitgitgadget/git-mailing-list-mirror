From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 3/5] Explicitly list all valid diff tools and document --tool-help
 as an option
Date: Mon, 23 Jul 2012 09:18:57 +0200
Message-ID: <500CFAE1.3070304@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDFg-00028q-HR
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2GWHkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:40:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:38610 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab2GWHkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:40:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StDFQ-0001uB-AC
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:40:08 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:40:08 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:40:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CF9D2.30102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201922>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 31fc2e3..5dd54f1 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -36,9 +36,12 @@ OPTIONS
 
 -t <tool>::
 --tool=<tool>::
-	Use the diff tool specified by <tool>.  Valid values include
-	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
-	for the list of valid <tool> settings.
+	Use the diff tool specified by <tool>.  Valid diff tools are:
+	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kcompare, kdiff3,
+	meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
+
+--tool-help::
+	List the supported and available diff tools.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
-- 
1.7.11.msysgit.2
