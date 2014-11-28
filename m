From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] for-each-ref: correct spelling of Tcl in option description
Date: Fri, 28 Nov 2014 19:00:11 +0100
Message-ID: <1417197611-22418-1-git-send-email-ralf.thielow@gmail.com>
Cc: hartmut_henkel@gmx.de, gitster@pobox.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 19:00:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuPqC-0004qC-AN
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 19:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbaK1SAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 13:00:20 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47780 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaK1SAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 13:00:19 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so19286781wiw.8
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U9nqYnPmGA7TMkD0t3goT06NdpPZyVdUIXQuOBLheS4=;
        b=vFohU8Lb4OkyP1YRQ0UHqfIQ4fe9vTTr107MBh5OSg8UiQV3WhEdpjlHIpF2Wn5++d
         9rcQYRCFFN6MoOcUoeYSbYDnCW9AUA6EEJFtPF1IpwXit488X78DBD8SkPgbyTzcwM4K
         J0ZLUM5SlPpYXuUed1EAYdz4siXRtWTgbJcMhm1+q+d5nGHzjA4+Dcw9FxS+2mllbNCR
         ww7c3lhIKd12vZmg7f7ARv3WNac6NNu0moqvmm2dPLkWcI5tXMXE1vHnQXH3deiM36jC
         WTKIoWrKAYyv4H9lxtQy2UeJg/qPYl/iSvyDG+AxCXN/N+iVTdPjP04/K9d7lR6VX8p5
         2h8A==
X-Received: by 10.194.184.199 with SMTP id ew7mr72735047wjc.85.1417197618287;
        Fri, 28 Nov 2014 10:00:18 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id l10sm30470458wif.20.2014.11.28.10.00.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Nov 2014 10:00:17 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260373>

Tcl is conventionally spelled "Tcl". The description of
option "--tcl", however, spells it "tcl". Let's follow
the convention.

Reported-by: Hartmut Henkel <hartmut_henkel@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 603a90e..f3ce004 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1075,7 +1075,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0 , "python", &quote_style,
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &quote_style,
-			N_("quote placeholders suitably for tcl"), QUOTE_TCL),
+			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
-- 
2.2.0
