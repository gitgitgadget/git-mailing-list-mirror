From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC/PATCH 4/4] submodules: add bash completion for remotes.
Date: Wed,  8 Apr 2015 12:58:25 +0200
Message-ID: <1428490705-11586-5-git-send-email-ps@pks.im>
References: <1428490705-11586-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 13:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfnzA-0007tk-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbbDHLRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:17:19 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:50230 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbDHLRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:17:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=24J6rQDvYVhhAUDB98IMOrS6Yk2SeXIYLUjjJbrBdC6BgCJYnvRKmSmCoEJ9N7dkpC3ndWt5nIVl
    dQChy98am/RIse6OkefmyQ9h9YQuJh04dZTj3zXBs0FWGVZCIF7IxkKbhXumLLR+vMI1in67dyPz
    Yu9StGrXQNecQTyxgxQ=  
Received: from localhost (x5ce10f35.dyn.telefonica.de [92.225.15.53]) by mx.zohomail.com
	with SMTPS id 1428490772689399.1062548916668; Wed, 8 Apr 2015 03:59:32 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428490705-11586-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_18
X-ZohoMail-Owner: <1428490705-11586-5-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.15.53
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266957>

---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fbe5972..9d52bf0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2411,7 +2411,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update summary foreach sync"
+	local subcommands="add status init deinit update summary foreach sync remote"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		case "$cur" in
 		--*)
-- 
2.3.5
