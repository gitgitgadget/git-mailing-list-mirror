From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/diff: give --word-diff-regex=. example
Date: Fri, 20 Nov 2015 14:36:14 +0100
Message-ID: <6697f80b679b2bc910aa02a0fc945453be38c532.1448026505.git.git@drmicha.warpmail.net>
References: <vpq1tbq812p.fsf@anie.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 14:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzlrS-00012F-3I
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 14:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162791AbbKTNgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 08:36:17 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42532 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161920AbbKTNgR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 08:36:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 46DBF20AB0
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 08:36:16 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 20 Nov 2015 08:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=qgP53rJxiR5hW5hm6qdxBgdt8kw
	=; b=ZxQCvZEn1ZeHk4E2+7YJCZMlgDkX/pphhGrsaMfkE9RxYziXWQYT5zkknZk
	EdgHPAHD7dfOo7kcZT5MMVxWgOdTa2FF93N31O3hyaLE3m9eSseLToHe+FMkEQWN
	laTuAJc2cgj6/9k6VsAlQ4Q/0dAW/qCrrzCQdU47HAk/j48E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qgP5
	3rJxiR5hW5hm6qdxBgdt8kw=; b=qqsWn6b79I2GujJnsWuWeh66p0cEesooMh6g
	6IRClWsTkXlCCw2byiLBW4zuSHnHjgNTa/GXO4Csht3NNbb+dTWKZVCl4HGH/SOe
	IXs+tIsp2ni9pC6jBy++ZPEI5MLnI6/l5DXR7zioztaNx8WrVwenXBvNTOT12yFB
	U19UEyg=
X-Sasl-enc: zUJEM3Qf+HRMqnq08z4cV6udZaDski5uLuCcc4zjwfeR 1448026575
Received: from localhost (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D7F48C016F2;
	Fri, 20 Nov 2015 08:36:15 -0500 (EST)
X-Mailer: git-send-email 2.6.3.507.gca54332
In-Reply-To: <vpq1tbq812p.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281520>

It's just so useful.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d56ca90..306b7e3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -267,6 +267,9 @@ expression to make sure that it matches all non-whitespace characters.
 A match that contains a newline is silently truncated(!) at the
 newline.
 +
+For example, `--word-diff-regex=.` will treat each character as a word
+and, correspondingly, show differences character by character.
++
 The regex can also be set via a diff driver or configuration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
-- 
2.6.3.507.gca54332
