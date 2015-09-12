From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Documentation/config: fix formatting for branch.*.rebase and
 pull.rebase
Date: Sat, 12 Sep 2015 16:26:53 +0200
Message-ID: <87zj0r4ssy.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 16:27:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zalm7-0002qA-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 16:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbbILO1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 10:27:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54909 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbILO1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 10:27:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nCx9C6SzZz3hjQ4
	for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:26:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nCx9C2Nxbzvk93
	for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:26:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id chnZzcv3C1-z for <git@vger.kernel.org>;
	Sat, 12 Sep 2015 16:26:54 +0200 (CEST)
X-Auth-Info: 8+op4HUFfE2QSWNf0RlrFd1osvY8Tvb16x9MP7UDM9IWHlcPvog1DXKvIm0DwyQq
Received: from igel.home (host-188-174-212-64.customer.m-online.net [188.174.212.64])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:26:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id F27082C1B3D; Sat, 12 Sep 2015 16:26:53 +0200 (CEST)
X-Yow: I request a weekend in Havana with Phil Silvers!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277726>

Don't format the second paragraph as a literal block.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c351b9..e0bd703 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -865,7 +865,7 @@ branch.<name>.rebase::
 	instead of merging the default branch from the default remote when
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
-+
+	+
 	When preserve, also pass `--preserve-merges` along to 'git rebase'
 	so that locally committed merge commits will not be flattened
 	by running 'git pull'.
@@ -2137,7 +2137,7 @@ pull.rebase::
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
-+
+	+
 	When preserve, also pass `--preserve-merges` along to 'git rebase'
 	so that locally committed merge commits will not be flattened
 	by running 'git pull'.
-- 
2.5.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
