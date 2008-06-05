From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2 1/2] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu,  5 Jun 2008 13:57:04 +0300
Message-ID: <1212663425-20064-1-git-send-email-tlikonen@iki.fi>
References: <20080605105204.GA17979@mithlond.arda.local>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 12:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4DAW-0007Vt-T1
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYFEK5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbYFEK5J
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:57:09 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:52242 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754538AbYFEK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:57:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F005ACC73; Thu, 5 Jun 2008 13:57:06 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4D9V-0005Dw-E2; Thu, 05 Jun 2008 13:57:05 +0300
X-Mailer: git-send-email 1.5.6.rc1.15.g99b92
In-Reply-To: <20080605105204.GA17979@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83902>

Commands "git", "git --help" and "git help" did not list the subcommand
"help" as one of the most commonly used git commands. Yet "git help" is
advertised as the help command of git so this patch adds "help" the
list.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 command-list.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 3583a33..510ac69 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,7 +47,7 @@ git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help				ancillaryinterrogators
+git-help				ancillaryinterrogators common
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
-- 
1.5.6.rc1.17.gfc76f
