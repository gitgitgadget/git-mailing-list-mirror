From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [PATCH] git-completion: Add git help completion for aliases
Date: Mon, 21 Mar 2011 10:25:06 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D871972.7080008@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
	lee.marlow@gmail.com, markus.heidelberg@web.de, szeder@ira.uka.de,
	spearce@spearce.org, bebarino@gmail.com, ted@tedpavlic.com,
	tlikonen@iki.fi, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 10:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bMa-0003sH-5R
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1CUJZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:25:19 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:40420 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1CUJZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:25:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 9F6EA1B4B9C;
	Mon, 21 Mar 2011 10:25:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXOBJy0L5Y-f; Mon, 21 Mar 2011 10:25:09 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 42C7C1B4B9B;
	Mon, 21 Mar 2011 10:25:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169563>

Enable bash completion for "git help <alias>", analogous to "git
<alias>", which was already implemented.

Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
---
  contrib/completion/git-completion.bash |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 893b771..f9a74d3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1506,7 +1506,7 @@ _git_help ()
  		;;
  	esac
  	__git_compute_all_commands
-	__gitcomp "$__git_all_commands
+	__gitcomp "$__git_all_commands $(__git_aliases)
  		attributes cli core-tutorial cvs-migration
  		diffcore gitk glossary hooks ignore modules
  		repository-layout tutorial tutorial-2
-- 
1.7.0.4
