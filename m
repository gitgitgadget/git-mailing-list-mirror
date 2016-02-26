From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/6] Documentation/git-worktree: spell --detach correctly
Date: Fri, 26 Feb 2016 17:39:41 +0100
Message-ID: <f0c859d9736058736a58d8c9898c9b5417a63b8c.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLRN-0001Jy-Px
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbcBZQkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:40:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55636 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754730AbcBZQju (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 641BB20AB1
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:49 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 26 Feb 2016 11:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=bkFUVCtK2+3sjiPLFui/8h5w5Ww
	=; b=YjDleje1DOW1S5N6OtWRmHVHfAMtVg3wLLJb2di24MRQugpAjWneCBrT3rW
	m8eCjZObKCYTrDOx/UQUwDlyabIIo1jgbWUVET8qyoTKwcH61hFgiTOI9PrEFDWg
	yGUr5sdD5dbkYT++uEIVPDTjirkW2wB59UH9EwSxC9jIASVM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bkFU
	VCtK2+3sjiPLFui/8h5w5Ww=; b=Ll4GITGs4V5/5mRGh8G92Ssf1oDhmY1dBwc6
	ZVH2xVWTmqW4HNLwDWFDVX6XsOaHIMob9x49GGtNXF7Jr/XuG4PixAH8YPJ3upBl
	VIDxGWY/Kc1Jzle8G61CO9NU1595kA1M5mIwMx4co/KtHhGt7zjc30XEwvnRAtu5
	BJm/1EQ=
X-Sasl-enc: WPMkQ6W51Q0mXtn+A4nQ9IuR3HMszrVTOHnY0i0AruBa 1456504789
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 00728680180;
	Fri, 26 Feb 2016 11:39:48 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287587>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 62c76c1..51a2ea0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -50,7 +50,7 @@ Create `<path>` and checkout `<branch>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
+If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
 
-- 
2.7.2.618.g7a61b68
