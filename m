From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2] bash: Add more option completions for 'git log'
Date: Fri, 20 Jun 2008 16:02:10 +0300
Message-ID: <20080620130210.GA4521@mithlond.arda.local>
References: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com> <20080619215842.GL11793@spearce.org> <20080619224012.GA6705@mithlond.arda.local> <20080619225552.GQ11793@spearce.org> <20080620063104.GA3307@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gHE-00038b-9l
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbYFTNCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYFTNCS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:02:18 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:42847 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753546AbYFTNCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:02:17 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F010F3EDC; Fri, 20 Jun 2008 16:02:12 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K9gFm-0001CJ-V8; Fri, 20 Jun 2008 16:02:10 +0300
Content-Disposition: inline
In-Reply-To: <20080620063104.GA3307@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85637>

Options added: --walk-reflogs --stat --numstat --shortstat
--decorate --diff-filter= --color-words

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

Here's a non-conflicting version.


 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 72575cf..f108ede 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -762,6 +762,9 @@ _git_log ()
 			--not --all
 			--left-right --cherry-pick
 			--graph
+			--stat --numstat --shortstat
+			--decorate --diff-filter=
+			--color-words --walk-reflogs
 			"
 		return
 		;;
-- 
1.5.6.2.g3c3a
