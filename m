From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Documentation/git-merge.txt: fix formatting of example block
Date: Thu, 05 Sep 2013 17:12:45 +0200
Message-ID: <87sixjb8uq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 17:13:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHbEv-00012M-AQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 17:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IEPMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 11:12:53 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55630 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab3IEPMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 11:12:52 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cW54M1g1Gz3hhbp
	for <git@vger.kernel.org>; Thu,  5 Sep 2013 17:12:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cW54H35pmzbbnR
	for <git@vger.kernel.org>; Thu,  5 Sep 2013 17:12:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id PTf_gqQewo3M for <git@vger.kernel.org>;
	Thu,  5 Sep 2013 17:12:46 +0200 (CEST)
X-Auth-Info: i1Y1IWOzPY803KuDq8ceehaWk6c6gZ/PjQO1A0MkAnM=
Received: from igel.home (ppp-88-217-112-202.dynamic.mnet-online.de [88.217.112.202])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Thu,  5 Sep 2013 17:12:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 00CD52C0C0E; Thu,  5 Sep 2013 17:12:45 +0200 (CEST)
X-Yow: Yow!  I'm having a quadrophonic sensation of two winos
 alone in a steel mill!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233961>

You need at least four dashes in a line to have it recognized as listing
block delimiter by asciidoc.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-merge.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 8c7f2f6..a74c371 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -186,11 +186,11 @@ In such a case, you can "unwrap" the tag yourself before feeding it
 to `git merge`, or pass `--ff-only` when you do not have any work on
 your own. e.g.
 
----
+----
 git fetch origin
 git merge v1.2.3^0
 git merge --ff-only v1.2.3
----
+----
 
 
 HOW CONFLICTS ARE PRESENTED
-- 
1.8.4

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
