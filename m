X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 13:27:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
 <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 12:27:47 +0000 (UTC)
Cc: gpermus@gmail.com, hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061206.105251.144349770.wl@gnu.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33441>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrvsH-0001K7-3S for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760549AbWLFM1m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760551AbWLFM1m
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:27:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:59006 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760549AbWLFM1m
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:27:42 -0500
Received: (qmail invoked by alias); 06 Dec 2006 12:27:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp016) with SMTP; 06 Dec 2006 13:27:40 +0100
To: Werner LEMBERG <wl@gnu.org>
Sender: git-owner@vger.kernel.org


It really is an important concept to grasp for people coming
from CVS. Even if it is briefly mentioned, it is not obvious
enough to sink in.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Wed, 6 Dec 2006, Werner LEMBERG wrote:
	
	> It took me a while to realize that a git repository, as soon as 
	> you've cloned it, is *self-contained*, and that commiting to the 
	> repository and synchronizing with a different git repository are 
	> two completely different things (contrary to CVS).  This should 
	> be pronounced more in the CVS->git guide.

 Documentation/cvs-migration.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 6812683..8e610c7 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -24,6 +24,11 @@ First, note some ways that git differs from CVS:
     single shared repository which people can synchronize with; see below
     for details.
 
+  * Since every working tree contains a repository, a commit will not
+    publish your changes; it will only create a revision. You have to
+    "push" your changes to a public repository to make them visible
+    to others.
+
 Importing a CVS archive
 -----------------------
 
-- 
