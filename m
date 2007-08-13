From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Improved hint on how to set identity
Date: Tue, 14 Aug 2007 00:05:50 +0200
Message-ID: <1187042750257-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 00:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKi2x-0000YB-Cp
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 00:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760524AbXHMWFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760529AbXHMWFy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 18:05:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:47270 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760383AbXHMWFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 18:05:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7DM5o7K005784
	for <git@vger.kernel.org>; Tue, 14 Aug 2007 00:05:50 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7DM5ofe023831;
	Tue, 14 Aug 2007 00:05:50 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55791>

Users typically want to set the default for their account. Thus,
start the hint with how to achieve that; and only later explain
how to restrict identity to a single repository.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 ident.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

I watched someone setting up git, who never used it before.
The hint was leading him into the wrong direction. He
certainly wanted to set a global default. Let's give users
the right hint first.

    Steffen

diff --git a/ident.c b/ident.c
index 6612d17..9b2a852 100644
--- a/ident.c
+++ b/ident.c
@@ -185,11 +185,11 @@ static const char *env_hint =
 "\n"
 "Run\n"
 "\n"
-"  git config user.email \"you@email.com\"\n"
-"  git config user.name \"Your Name\"\n"
+"  git config --global user.email \"you@email.com\"\n"
+"  git config --global user.name \"Your Name\"\n"
 "\n"
-"To set the identity in this repository.\n"
-"Add --global to set your account\'s default\n"
+"to set your account\'s default identity.\n"
+"Omit --global to set the identity only in this repository.\n"
 "\n";
 
 const char *fmt_ident(const char *name, const char *email,
-- 
1.5.3.rc4.96.g6ceb
