From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git-stash: document options for git stash
	list
Date: Wed, 20 Feb 2008 12:31:35 +0100
Message-ID: <20080220113135.GL31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 12:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRnC2-0007Az-Gj
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 12:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbYBTLcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 06:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbYBTLcA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 06:32:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48794 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbYBTLb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 06:31:59 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JRnAv-0008Os-8t
	from <vmiklos@frugalware.org>; Wed, 20 Feb 2008 12:31:56 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 91DB2119019F; Wed, 20 Feb 2008 12:31:35 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.3
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2491]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74510>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Noticed by dooglus on IRC.

 Documentation/git-stash.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index cd0dc1b..48e6f5a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -43,7 +43,7 @@ save [<message>]::
 	subcommand is given. The <message> part is optional and gives
 	the description along with the stashed state.
 
-list::
+list [<options>]::
 
 	List the stashes that you currently have.  Each 'stash' is listed
 	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1}` is
@@ -55,6 +55,9 @@ list::
 stash@{0}: WIP on submit: 6ebd0e2... Update git-stash documentation
 stash@{1}: On master: 9cc0589... Add git-stash
 ----------------------------------------------------------------
++
+The command takes options applicable to the linkgit:git-log[1]
+command to control what is shown and how.
 
 show [<stash>]::
 
-- 
1.5.4
