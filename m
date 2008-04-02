From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: Add a missing OPT_END().
Date: Wed, 2 Apr 2008 05:47:41 +0200
Message-ID: <20080402054741.24d95299.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 05:43:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgtsG-0005XM-KP
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 05:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYDBDmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755017AbYDBDmN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 23:42:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49664 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbYDBDmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 23:42:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 30EDC1AB2BC;
	Wed,  2 Apr 2008 05:42:11 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 9A2C51AB2BD;
	Wed,  2 Apr 2008 05:42:10 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78677>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

	Some comments in "parse-options.h" say it is needed,
	though I did not see a crash without it.

diff --git a/help.c b/help.c
index ecaca77..10298fb 100644
--- a/help.c
+++ b/help.c
@@ -30,6 +30,7 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, "show info page",
 			HELP_FORMAT_INFO),
+	OPT_END(),
 };
 
 static const char * const builtin_help_usage[] = {
-- 
1.5.5.rc2.6.gf58d
