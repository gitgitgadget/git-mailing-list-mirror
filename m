From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 7/7] git-tag.txt: list all modes in the description
Date: Mon, 14 Feb 2011 16:10:35 +0100
Message-ID: <496c871d087c0677ddd3374d432e56c891375025.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp088-0002oe-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab1BNPN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53195 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755603Ab1BNPNw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:52 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2687120182
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:52 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 14 Feb 2011 10:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=NWWp1KXFssQEdvIFvgDB5idlFQU=; b=nLqPLD4tUhvM5e+F8lR5V5gHvxScc2QyIIpZkK0lPLSE9gEWxgKsT4Ny4P9MVRiSqPAIL5P88CUC/jX5vwPRCKVO4y1JIZMe3JpktggJOQA2rV+41297whZCv46cwoZoGsP/NpBdZobHHgDRwN/Xwxn5FCP8XR2MK7SKhUWhO6c=
X-Sasl-enc: +FeTUB4/8e52IfeBvF7I4pT5yvLFCUtP5KS1//hSnQyI 1297696431
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A725A4048DB;
	Mon, 14 Feb 2011 10:13:51 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166725>

Currently, the description sounds as if it applied always, but most of
its content is true in "create tag mode" only.

Make this clearer by listing all modes and qualifying the main part.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-tag.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..c503f60 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Adds a tag reference in `.git/refs/tags/`.
+Without `-d/-l/-v`: Adds a tag reference in `.git/refs/tags/`.
 
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
@@ -39,6 +39,12 @@ A GnuPG signed tag object will be created when `-s` or `-u
 committer identity for the current user is used to find the
 GnuPG key for signing.
 
+With `-d`: Deletes a tag.
+
+With `-l`: List tags.
+
+With `-v`: Verify tags.
+
 OPTIONS
 -------
 -a::
-- 
1.7.4.1.74.gf39475
