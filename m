From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/8] git-show-branch.txt: cleanup example description
Date: Thu, 23 Apr 2009 02:37:58 -0700
Message-ID: <1240479482-31366-5-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
 <1240479482-31366-4-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvQ8-0001FG-Um
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZDWJiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbZDWJiW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbZDWJiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=yK97m2Ra1vBRGcc3Ii9Ho2dmCZQ93vY6gOlrsidRZXk=;
        b=xaCZP2eyEEdSvPxh84Xg3YLI82XpbsIC/HmSrRR7sFNKJckkvu2iJEfsf8eZbh8jYj
         ph/QIYOhu+M1m/QuZclu5hvdproLMa5J6LHGhd1dMuRmrVhoFESvVQc/GLu9RXOipnvT
         bJtUTLTvnT5BIrF0WgrThI18OvJzPdu1jRNAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sAGVUSP9ePw+DJG4pdWcLSw4Qnd3TsdCLcNbPGQdCDpbPX/uDr081Xn7FcyCyzPEfk
         Cf26OEscBe5QZb43sKsDmCzeuSZ5ZGozyD11rRVoSrZ5+TBLxztepwTmrhifcQ9LdXma
         oVN5Mk+JZ24TBn/uWkCwry4nGOAwKuF6Z4ERE=
Received: by 10.114.150.1 with SMTP id x1mr386708wad.93.1240479499905;
        Thu, 23 Apr 2009 02:38:19 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n30sm1332843wag.63.2009.04.23.02.38.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:19 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:16 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117319>

Add a missing quote and properly escape the ' character so docs don't
look odd. Add 'the' to make some sentences more gramatically correct.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-show-branch.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7e9ff37..51a4e9d 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -148,9 +148,10 @@ $ git show-branch master fixes mhf
 ------------------------------------------------
 
 These three branches all forked from a common commit, [master],
-whose commit message is "Add 'git show-branch'.  "fixes" branch
-adds one commit 'Introduce "reset type"'.  "mhf" branch has many
-other commits.  The current branch is "master".
+whose commit message is "Add \'git show-branch\'". The "fixes"
+branch adds one commit "Introduce "reset type" flag to "git reset"".
+The "mhf" branch adds many other commits. The current branch
+is "master".
 
 
 EXAMPLE
-- 
1.6.2.3
