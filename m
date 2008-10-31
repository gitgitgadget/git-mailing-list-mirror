From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: add doubledash to "git show"
Date: Fri, 31 Oct 2008 01:04:46 +0100
Message-ID: <200810310104.47201.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 31 01:05:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhWH-0007uH-1p
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYJaAE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbYJaAE2
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:04:28 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57945 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYJaAE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 20:04:27 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id D000BF57A896;
	Fri, 31 Oct 2008 01:04:25 +0100 (CET)
Received: from [91.19.59.109] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KvhV3-0006C0-00; Fri, 31 Oct 2008 01:04:25 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX189cyq1CgQhRrEtaRE6EG/yr/Nh+e51/U4XAxgz
	yoUGicnvDJbBtRHO2XnZueRNlpT6LtV10OklMwu74ELXM0LGJk
	HyCao7iUaLLwEp/SqQOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99537>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eebe734..de193ba 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1398,6 +1398,8 @@ _git_shortlog ()
 
 _git_show ()
 {
+	__git_has_doubledash && return
+
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=*)
-- 
1.6.0.3.524.g3adb7d
