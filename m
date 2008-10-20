From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add 'workflows' to 'git help'
Date: Mon, 20 Oct 2008 11:31:38 -0600
Message-ID: <1224523898-11161-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:44:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krych-0006Ho-TF
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 19:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYJTRbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 13:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYJTRbm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 13:31:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:58036 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYJTRbl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 13:31:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2085534wfd.4
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QhVqinZv9jz32X/brE0gRCvt1UlHXwuplRq2M1XXrtA=;
        b=fZRnAXf6K1vkyS+c/ucjX+UWsfbSYEI8pBQVPY04d0exeyG1ACG4g1w9D8u8mvgaQU
         OhEIMEXUSUG8DEWKPVp1LKDBFbtBprQY1x8NBNpIzIXwssSqPFHX9vxXJquMDta2Bc3R
         Brg1TQjeCi+GEAco9uR/7nU0KhgqAQasLKyt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DtR9x/04BMIf3vy102HnrYUTqVabNDcpdwwfxSs+a2O5bdifHajoUi+mhQnzXYWTnL
         Is8dEqh/3tfpP+KH1rSB9Ow1F3fHzxqOqiYu9TlbjZMhag8wQwhtlHolxEvbtRgPLClc
         KZHjwKF/EDDQ+pMcvJ96wgUtDWardlie70AM0=
Received: by 10.141.129.14 with SMTP id g14mr5025253rvn.56.1224523901132;
        Mon, 20 Oct 2008 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (c-75-71-41-234.hsd1.co.comcast.net [75.71.41.234])
        by mx.google.com with ESMTPS id g22sm370211rvb.8.2008.10.20.10.31.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 10:31:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.588.g3102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98714>

Completion for new workflow documentation introduced in f948dd8

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d192927..eebe734 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -881,6 +881,7 @@ _git_help ()
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2
+		workflows
 		"
 }
 
-- 
1.6.0.2.588.g3102
