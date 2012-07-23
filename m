From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 1/5] Sort the list of tools that support both merging and
 diffing alphabetically
Date: Mon, 23 Jul 2012 09:17:10 +0200
Message-ID: <500CFA76.3060600@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StD1D-0005dW-3L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab2GWHZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:25:22 -0400
Received: from plane.gmane.org ([80.91.229.3]:57963 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab2GWHZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:25:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StD0r-0005EW-A3
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:25:05 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:25:05 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:25:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CF9D2.30102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201917>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5be9dee..f2c4894 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1325,8 +1325,8 @@ _git_diff ()
 	__git_complete_revlist_file
 }
 
-__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
+__git_mergetools_common="araxis bc3 diffuse ecmerge emerge gvimdiff
+			kdiff3 meld opendiff p4merge tkdiff vimdiff xxdiff
 "
 
 _git_difftool ()
-- 
1.7.11.msysgit.2
