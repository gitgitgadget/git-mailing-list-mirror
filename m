From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 05/12] MINGW: config.mak.uname: allow using cURL for non-msysGit builds
Date: Tue, 29 Apr 2014 13:11:59 +0400
Message-ID: <1398762726-22825-6-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf476-0006xI-R2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbaD2JMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:20 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45024 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbaD2JMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:19 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45I-0006BN-7K; Tue, 29 Apr 2014 13:12:16 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247544>

Is it absolutely valid and possible to have cURL in generic
MinGW environment. Building Git without cURL is still possible
by passing NO_CURL=1

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 config.mak.uname | 2 --
 1 file changed, 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index faddb82..a626410 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -519,8 +519,6 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
-else
-	NO_CURL = YesPlease
 endif
 endif
 ifeq ($(uname_S),QNX)
-- 
1.9.1
