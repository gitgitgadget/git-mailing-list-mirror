From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-pull documentation: fix linkgit in the --rebase option
	description.
Date: Mon, 11 Feb 2008 14:28:00 +0100
Message-ID: <20080211132800.GV25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:28:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYiM-0001br-IL
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbYBKN2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 08:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbYBKN2T
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:28:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33397 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbYBKN2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 08:28:18 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JOYhe-0004cE-G0
	from <vmiklos@frugalware.org>; Mon, 11 Feb 2008 14:28:16 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 878EA1190498; Mon, 11 Feb 2008 14:28:00 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0155]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73530>

We do not have newlines before NOTEs at other places either, like git clone -s
documentation and removing that newline turns 'linkgit:git\-rebase[1]' to
'\fBgit-rebase\fR(1)' properly.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-pull.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 4cc633a..b9bc6ed 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -39,7 +39,6 @@ include::merge-strategies.txt[]
 	there is a remote ref for the upstream branch, and this branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
-
 	*NOTE:* This is a potentially _dangerous_ mode of operation.
 	It rewrites history, which does not bode well when you
 	published that history already.  Do *not* use this option
-- 
1.5.4
