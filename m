From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/3] diff-options.txt: describe --stat-{width,name-width,count}
Date: Fri, 27 May 2011 14:36:42 +0200
Message-ID: <116faa98951a64770efeb44d54adc4b0da359f57.1306499600.git.git@drmicha.warpmail.net>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 14:37:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPwHs-0005Sa-U7
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 14:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab1E0Mgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 08:36:53 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56607 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714Ab1E0Mgu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 08:36:50 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 38DAE20520;
	Fri, 27 May 2011 08:36:50 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 27 May 2011 08:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=/fd2bG82jN8q7/JxoP3ZUU3bP/8=; b=OaJL8j1BUsvXPL6OD5+ayzLYcnCFiLy8IrfmCmdTkhW5LouR/fffzCEur6ZvBTraZMyOtEPPMt3Q1cMd1ewIKrUpWUoFrUznux0KfK5ueGAUhoMGOCpUkz3WU2QGIzZBbvMbsh2XwfP6TMIqBv9Tc6InWYoE0YZU5eolGkIqQH4=
X-Sasl-enc: pNeoDX8J1ZsomRsnFeLXsZ1I43G/KsdfHODcBdQlInCx 1306499809
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4B57401558;
	Fri, 27 May 2011 08:36:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.657.g62c2
In-Reply-To: <4DC0FD3D.9010004@drmicha.warpmail.net>
In-Reply-To: <cover.1306499600.git.git@drmicha.warpmail.net>
References: <cover.1306499600.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174613>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 000eae0..f6c046a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -56,6 +56,9 @@ endif::git-format-patch[]
 	By giving a third parameter `<count>`, you can limit the
 	output to the first `<count>` lines, followed by
 	`...` if there are more.
++
+These parameters can also be set individually with `--stat-width=<width>`,
+`--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
 --numstat::
 	Similar to `\--stat`, but shows number of added and
-- 
1.7.5.2.657.g62c2
