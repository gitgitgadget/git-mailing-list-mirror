From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] CodingGuidelines: Add a note to avoid assignments inside if()
Date: Fri, 23 May 2008 01:26:09 +0200
Message-ID: <1211498769-26871-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzKBa-0006Mt-KW
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 01:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372AbYEVX0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758407AbYEVX0K
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 19:26:10 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37222 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758363AbYEVX0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 19:26:09 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 2DC901DDC5B;
	Fri, 23 May 2008 01:26:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B8B85185E19; Fri, 23 May 2008 01:26:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82671>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I just had to ask Dscho about this. Better if it's documented, I
suppose.

 Documentation/CodingGuidelines |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 994eb91..d2a0a76 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -89,6 +89,8 @@ For C programs:
    of "else if" statements, it can make sense to add braces to
    single line blocks.
 
+ - We try to avoid assignments inside if().
+
  - Try to make your code understandable.  You may put comments
    in, but comments invariably tend to stale out when the code
    they were describing changes.  Often splitting a function
-- 
1.5.5.1.357.g1af8b.dirty
