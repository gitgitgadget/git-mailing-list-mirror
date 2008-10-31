From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] git send-email: make the message file name more specific.
Date: Fri, 31 Oct 2008 13:36:47 +0100
Message-ID: <1225456609-694-2-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225456609-694-1-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 13:38:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvtGX-00007v-UG
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 13:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYJaMgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYJaMgy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 08:36:54 -0400
Received: from pan.madism.org ([88.191.52.104]:54659 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbYJaMgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 08:36:52 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 198F73B57D;
	Fri, 31 Oct 2008 13:36:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 355BA5EE23B; Fri, 31 Oct 2008 13:36:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.763.g0275.dirty
In-Reply-To: <1225456609-694-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99581>

This helps editors choosing their syntax hilighting properly.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 65c254d..4ca571f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -127,7 +127,7 @@ sub unique_email_list(@);
 sub cleanup_compose_files();
 
 # Constants (essentially)
-my $compose_filename = ".msg.$$";
+my $compose_filename = ".gitsendemail.msg.$$";
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-- 
1.6.0.3.763.g0275.dirty
