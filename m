From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix a typo in checkout.sh and cleanup one-line help messages
Date: Tue, 11 Dec 2007 17:36:32 +0100
Message-ID: <475EBC90.1060606@viscovery.net>
References: <20071211160925.GF15448@artemis.madism.org> <20071211161305.GH15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J286N-0006gd-2b
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbXLKQgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXLKQgh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:36:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32051 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbXLKQgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:36:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2857-0005hQ-99; Tue, 11 Dec 2007 17:35:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 18166546; Tue, 11 Dec 2007 17:36:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071211161305.GH15448@artemis.madism.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67884>

This also shortens option descriptions to fit in 80 columns.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Pierre Habouzit schrieb:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
> 
>   Woops there was another typo in the usage, fix it at the same time.
> 
>  git-checkout.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Funny, I had this in my tree since a few days, although embarassingly,
I hadn't spotted the "git-branch" typo :-/

-- Hannes

 git-checkout.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f6d58ac..5621c69 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -2,13 +2,13 @@

 OPTIONS_KEEPDASHDASH=t
 OPTIONS_SPEC="\
-git-branch [options] [<branch>] [<paths>...]
+git-checkout [options] [<branch>] [<paths>...]
 --
 b=          create a new branch started at <branch>
-l           create the new branchs reflog
-track       tells if the new branch should track the remote branch
+l           create the new branch's reflog
+track       arrange that the new branch tracks the remote branch
 f           proceed even if the index or working tree is not HEAD
-m           performa  three-way merge on local modifications if needed
+m           merge local modifications into the new branch
 q,quiet     be quiet
 "
 SUBDIRECTORY_OK=Sometimes
-- 
1.5.3.7.1079.gecca
