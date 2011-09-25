From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] git-completion: offer references for 'git reflog'
Date: Sun, 25 Sep 2011 12:42:46 +0200
Message-ID: <4E7F05A6.30505@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 12:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7mBE-0003vI-Gb
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 12:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab1IYKnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 06:43:20 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:44178 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab1IYKnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 06:43:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 20C65DE08A
	for <git@vger.kernel.org>; Sun, 25 Sep 2011 12:43:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7bHHZvmXLB0 for <git@vger.kernel.org>;
	Sun, 25 Sep 2011 12:43:19 +0200 (CEST)
Received: from [192.168.1.101] (g231241231.adsl.alicedsl.de [92.231.241.231])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id DF1AADE014
	for <git@vger.kernel.org>; Sun, 25 Sep 2011 12:43:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182064>

'git reflog <ref>' is a valid command, therefore offer reference
completion.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..63d0f08 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1774,7 +1774,7 @@ _git_reflog ()
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
+		__gitcomp "$subcommands $(__git_refs)"
 	else
 		__gitcomp "$(__git_refs)"
 	fi
-- 
1.7.7.rc3
