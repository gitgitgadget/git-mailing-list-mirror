From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] Mark gitk script executable
Date: Thu, 6 Jan 2011 20:14:41 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 02:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb0up-0002FF-GL
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 02:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab1AGBOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 20:14:45 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:62309 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754970Ab1AGBOp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 20:14:45 -0500
X-AuditID: 12074425-b7c98ae000000a04-6b-4d266904117c
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 04.DB.02564.409662D4; Thu,  6 Jan 2011 20:14:44 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p071EhGC026627;
	Thu, 6 Jan 2011 20:14:44 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p071Ef46027394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Jan 2011 20:14:43 -0500 (EST)
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164691>

The executable bit on gitk-git/gitk was lost (accidentally it seems) by 
commit 62ba5143ec2ab9d4083669b1b1679355e7639cd5.  Put it back, so that 
gitk can be run directly from a git.git checkout.

Note that the script is already executable in gitk.git, just not in 
git.git.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 gitk-git/gitk

diff --git a/gitk-git/gitk b/gitk-git/gitk
old mode 100644
new mode 100755
-- 
1.7.4-rc0
