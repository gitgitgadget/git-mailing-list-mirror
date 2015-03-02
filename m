From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-remote.txt: describe behavior without --tags and --no-tags
Date: Mon,  2 Mar 2015 14:08:09 +0100
Message-ID: <932c9cd452718ad5e88677fc90985ef7fafd5078.1425301543.git.git@drmicha.warpmail.net>
References: <54F431E8.3050009@gmail.com>
Cc: Francis Moreau <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQ52-0002qY-GB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbbCBNIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:08:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58004 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662AbbCBNIL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 08:08:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E99C20990
	for <git@vger.kernel.org>; Mon,  2 Mar 2015 08:08:09 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 02 Mar 2015 08:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=F02LjiZsBC3s0R
	CFL4bZS6IfHbU=; b=j/ZAwGePFy/+JwkOqGrIbDlyGfRcD/Rz+0uEphZJJ9gwwp
	gs7ivjCMd+Xuliq5laPe6KQXGEIc/gVdQ0c3zwNWaBcKa+nV/wQTL0UcZvz0hSSf
	s7bnioqBX7yL1+WzOLx+V/s8CJh3UtDVkX1B+49UrzhyghJJcbpdnn1McexbE=
X-Sasl-enc: ZVG7HcD556fjHbzP1YlkbI5n9ZBtuVu+pJKhtgArSjIz 1425301690
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2C7BE680175;
	Mon,  2 Mar 2015 08:08:10 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54F431E8.3050009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264592>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-remote.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a77607b..f3f6f0d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -56,7 +56,10 @@ With `--tags` option, `git fetch <name>` imports every tag from the
 remote repository.
 +
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
++
+By default, only tags on fetched branches are imported
+(see linkgit:git-fetch[1]).
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-- 
2.3.1.303.g5174db1
