From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] push: add '--delete' flag to synopsis
Date: Mon, 14 Dec 2015 16:23:03 +0100
Message-ID: <1450106584-22313-1-git-send-email-ps@pks.im>
Cc: ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 16:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Uy9-0000pT-EM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbLNPXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:23:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39344 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248AbbLNPXN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:23:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 4B6C2209EB
	for <git@vger.kernel.org>; Mon, 14 Dec 2015 10:23:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 14 Dec 2015 10:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=veUwROy8FuxXBkzFCivHk3ZFoC
	E=; b=bfa8IYKr6H2z4jiX+MTwPdOXHxyMAf97KS4mNB4p3+zAySsUv3Pxcsv0gI
	Ii67MJM98hf/cYaNFSxU5Sf02rfV0bPVww+O8w1y44IZLC7Q2isncgOQ+hEtyld8
	qOCpJj5AzV9glARWMR+aiUPVFQCvcEXC9jf7kdJHygSv4a4A0=
X-Sasl-enc: nfOPIAgP+UrToAcU8z7ZP/92kPGiN0jKJx+yaOKXAO/2 1450106589
Received: from localhost (p5dc155a9.dip0.t-ipconnect.de [93.193.85.169])
	by mail.messagingengine.com (Postfix) with ESMTPA id D1423C016F7;
	Mon, 14 Dec 2015 10:23:09 -0500 (EST)
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282364>

The delete flag is not mentioned in the synopsis of `git-push`.
Add the flag to make it more discoverable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 85a4d7d..e830c08 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [--delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream]
 	   [--[no-]signed|--sign=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
-- 
2.6.4
