From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add more option completions for 'git log'
Date: Sun, 4 May 2008 14:06:15 +0300
Message-ID: <20080504110615.GA20660@mithlond.arda.local>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 13:07:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsc3o-0005mL-P2
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 13:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbYEDLG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 07:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbYEDLG2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 07:06:28 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:39527 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752447AbYEDLG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 07:06:27 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 48178931003BF115; Sun, 4 May 2008 14:06:26 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jsc2p-0005O2-10; Sun, 04 May 2008 14:06:15 +0300
Content-Disposition: inline
In-Reply-To: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81168>

Options added: --graph --stat --numstat --shortstat --decorate
--diff-filter= --color --no-color --color-words

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I have found these bash completions useful with 'git log'. This patch
also includes the '--graph' option recently introduced by Adam Simpkins.


 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 23db664..d7a8545 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -758,6 +758,10 @@ _git_log ()
 			--pretty= --name-status --name-only --raw
 			--not --all
 			--left-right --cherry-pick
+			--stat --numstat --shortstat
+			--decorate --diff-filter=
+			--color --no-color --color-words
+			--graph
 			"
 		return
 		;;
-- 
1.5.5.1.139.g8c42a
