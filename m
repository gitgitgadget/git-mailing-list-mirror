From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] git-bundle.txt: Clarify rev-list-args restrictions
Date: Mon, 23 Aug 2010 11:02:39 +0200
Message-ID: <4a2d0ecb46d274f6143caab6982535bfb678d10e.1282553586.git.git@drmicha.warpmail.net>
References: <cover.1282553585.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 11:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSwC-0002Eq-H9
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab0HWJCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:02:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52565 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616Ab0HWJCt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 05:02:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AC56945D;
	Mon, 23 Aug 2010 05:02:48 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 23 Aug 2010 05:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=kElUQ3gX0GbWDykLzH6M3W8lXTo=; b=UQjNdLkeiRQvF+d+Apr1Lcmy4v5qQwj56ZQAT7PkVI8fpKgg3lGxzl3QvOCwZBCP+AQJntX30VcJK+8TkAE0Frx5k6YsvY2DjNH4NiADW5LHdQ04wdVhECFox8eLutPtsNCfoO7BGqnm1g9sOHHSE77/dNNzgTnL2FCxQ9NsVgk=
X-Sasl-enc: sgzJRT3nWabcWBfoxjQoM8aiT4qjiyH6ZH0h+mxJvbet 1282554168
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FF825EB465;
	Mon, 23 Aug 2010 05:02:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
In-Reply-To: <cover.1282553585.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154213>

Currently, one could think that 'git bundle create' groks
any 'git rev-list' expression. But in fact it requires a named reference
to be present. Try and make this clearer.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bundle.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3cdbc72..38e59af 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -59,7 +59,8 @@ unbundle <file>::
 
 <git-rev-list-args>::
 	A list of arguments, acceptable to 'git rev-parse' and
-	'git rev-list', that specifies the specific objects and references
+	'git rev-list' (and containg a named ref, see SPECIFYING REFERENCES
+	below), that specifies the specific objects and references
 	to transport.  For example, `master{tilde}10..master` causes the
 	current master reference to be packaged along with all objects
 	added since its 10th ancestor commit.  There is no explicit
-- 
1.7.2.1.52.g7f7860
