From: Lapshin Dmitry <lapshin.dv@mail.ru>
Subject: [PATCH] Fixed typo in Doc/gitrepository-layout
Date: Tue, 22 Sep 2015 19:19:22 +0000
Message-ID: <0000014ff67f014e-399b2fe8-e757-4a1c-8915-3f2291f951dc-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 21:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTNy-000849-4E
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595AbbIVThu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:37:50 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:44177
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934060AbbIVTht (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 15:37:49 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2015 15:37:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1442949562;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=EsgYgPCOC9K6BtbanOyR36ixSmHOFhEO6YHoJbP1jUI=;
	b=MOJ6bGRjoKz7kGkipZC0t/kHHcX0bdpes7GqSc+FU/mNJLM5fa/9NSkqvz8+3JAO
	iLZZtbGiCH7uwGO8esmLXBZfOxRbqmA3NzoKXtT00z9si9oLXsOVHM5k2OuCT/vO62Y
	+R34vEtB/roiHS0yn1TyOc/OPZpIxm79yoplNKh8=
X-SES-Outgoing: 2015.09.22-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278421>

From: LDVSOFT <lapshin.dv@mail.ru>

gitrepository-layout.txt: In description of `info' directory,
    note about `$GIT_COMMON_DIR' was referencing `index'
    instead of `info'.

Signed-off-by: LDVSOFT <lapshin.dv@mail.ru>
---
 Documentation/gitrepository-layout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 7173b38..e9c5411 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -177,7 +177,7 @@ sharedindex.<SHA-1>::
 info::
 	Additional information about the repository is recorded
 	in this directory. This directory is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/index" will be used instead.
+	is set and "$GIT_COMMON_DIR/info" will be used instead.
 
 info/refs::
 	This file helps dumb transports discover what refs are

--
https://github.com/git/git/pull/177
