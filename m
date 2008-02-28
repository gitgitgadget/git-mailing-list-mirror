From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: configure Getopt::Long to bundle options
Date: Thu, 28 Feb 2008 11:18:24 +0100
Message-ID: <1204193904-3652-5-git-send-email-book@cpan.org>
References: <>
 <1204193904-3652-1-git-send-email-book@cpan.org>
 <1204193904-3652-2-git-send-email-book@cpan.org>
 <1204193904-3652-3-git-send-email-book@cpan.org>
 <1204193904-3652-4-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 11:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfrV-0005MG-45
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 11:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbYB1KS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 05:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbYB1KS7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 05:18:59 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:34197 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbYB1KS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 05:18:56 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfs6-0007qK-C2; Thu, 28 Feb 2008 11:20:14 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfqj-0000af-KN; Thu, 28 Feb 2008 11:18:49 +0100
X-Mailer: git-send-email 1.5.4.2.187.gfc276
In-Reply-To: <1204193904-3652-4-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75380>

---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f138a01..47f116f 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -112,7 +112,7 @@ sub read_repo_config {
 
 my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
 read_repo_config($opts);
-Getopt::Long::Configure( 'no_ignore_case' );
+Getopt::Long::Configure( 'no_ignore_case', 'bundling' );
 
 # turn the Getopt::Std specification in a Getopt::Long one,
 # with support for multiple -M options
-- 
1.5.4.2.187.gfc276
