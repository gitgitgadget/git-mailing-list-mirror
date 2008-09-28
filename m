From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash completion: Add --[no-]-validate to "git send-email"
Date: Sun, 28 Sep 2008 07:51:21 +0300
Message-ID: <20080928045121.GA3208@mithlond.arda.local>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, spearce@spearce.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 06:53:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjoHw-0003Fc-0V
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 06:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYI1Evq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 00:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYI1Evq
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 00:51:46 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:46445 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbYI1Evq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 00:51:46 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48DA300B002C387A; Sun, 28 Sep 2008 07:51:22 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KjoFd-0000xv-F4; Sun, 28 Sep 2008 07:51:21 +0300
Content-Disposition: inline
In-Reply-To: <1222564196-84202-4-git-send-email-mfwitten@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96943>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

    If your patch is to be applied let's also add the options to bash 
    completion.

 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93f0881..7284c3b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1141,7 +1141,8 @@ _git_send_email ()
 			--no-suppress-from --no-thread --quiet
 			--signed-off-by-cc --smtp-pass --smtp-server
 			--smtp-server-port --smtp-ssl --smtp-user --subject
-			--suppress-cc --suppress-from --thread --to"
+			--suppress-cc --suppress-from --thread --to
+			--validate --no-validate"
 		return
 		;;
 	esac
-- 
1.6.0.2.371.g15dc6
