From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Thu,  7 Apr 2011 00:16:48 +0530
Message-ID: <1302115611-1950-2-git-send-email-artagnon@gmail.com>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:48:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Xm4-0006xn-2T
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab1DFSsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:48:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58050 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab1DFSsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:48:03 -0400
Received: by iwn34 with SMTP id 34so1707472iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hUOTHGyjn5I3eReYFqvt/XbklRwrc9qTMOO2xdIUOgs=;
        b=cMgpWYlIWL/GAdgYRg9m6/JPEWCg/5FA6qiq9uZbiyTYSxvkTgUXA0OxdnGhxAOuOS
         ZPWVLUmD24fn9dSJNzKqt50Lq6l9y1tFnfUKpDJdIof4qosjNUNziRxCOYdGDYpYTYUb
         f8GKYslATiyK+xfrax9T1JthSm4jZO4lBVs3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gCva+SiFlDFlIU5Aj7xAt88obd/0mJYQJ9XbDPjIO2khLHHsWLKeXICBFQ63pLhDS3
         /UQuRHOTj0uR8Ngp0w26VKyJt1fOg4okjbI1qAtYpdvMRYSd+S4vJrEsvjpZwS3C6oX4
         7U6ipt1kahxyN2kOvr6GiMkFbbmfdLW3bCIxQ=
Received: by 10.42.135.1 with SMTP id n1mr1623242ict.93.1302115683001;
        Wed, 06 Apr 2011 11:48:03 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id vr5sm495851icb.0.2011.04.06.11.47.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:48:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171001>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..d3de3d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -977,6 +977,16 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+filter.<driver>.clean::
+	The command which is used to convert the content of a worktree
+	file to a blob upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	The command which is used to convert the content of a blob
+	object to a worktree file upon checkout.  See
+	linkgit:gitattributes[5] for details.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-- 
1.7.4.rc1.7.g2cf08.dirty
