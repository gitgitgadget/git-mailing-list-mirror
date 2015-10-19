From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH] contrib/subtree: remove "push" command from the "todo" file
Date: Mon, 19 Oct 2015 14:06:45 +0200
Message-ID: <1445256405-26812-1-git-send-email-fabio.porcedda@gmail.com>
Cc: James Denholm <nod.helm@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Danny Lin <danny0838@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 14:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo9DW-0007Jo-2G
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 14:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbbJSMG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 08:06:56 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34513 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbJSMG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 08:06:56 -0400
Received: by padhk11 with SMTP id hk11so28665458pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 05:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vijGXJ0ubzEZKnPsjyS4doXWjVshsVqhsIOu00hSq8Q=;
        b=0DhvzmFbbH3eRMIPtgunMMQ0nU4EyQaP+wblCvEVHLLoLcKVZ5xd4PJGTBskg/AdUN
         mceYlh8e98z1Qb6SYFyxh9W/O9iHo9DJvEJ2cL4wuWDtj6qdxC4+5mlVFnrDspzBOKVu
         khaRKQ9CGYp1JqfVGjyPnnxvtW6AD/R4M0UYYz2naP32jXXPQmOfkXUUag3QqIeGmM9A
         vPHK2UZGiAmWNjMPe3W0DEFa297lL0uxJFe8+p/S+mtTeEMvWVLjoD9cEjKkcy/I3n73
         d9DLOjXyx/9VUNushOKiU6mu1odxfAuRKc+n4AF6yixJP57e4OlRf6r/AwHgya6hLtFj
         Id6A==
X-Received: by 10.66.234.227 with SMTP id uh3mr33726501pac.151.1445256415659;
        Mon, 19 Oct 2015 05:06:55 -0700 (PDT)
Received: from ld2077.tmt.telital.com ([213.205.6.118])
        by smtp.gmail.com with ESMTPSA id dy8sm36500300pab.38.2015.10.19.05.06.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 05:06:54 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279870>

Because the "push" command is already avaiable, remove it from the
"todo" file.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 contrib/subtree/todo | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/subtree/todo b/contrib/subtree/todo
index 7e44b00..0d0e777 100644
--- a/contrib/subtree/todo
+++ b/contrib/subtree/todo
@@ -12,8 +12,6 @@
 		exactly the right subtree structure, rather than using
 		subtree merge...)
 
-	add a 'push' subcommand to parallel 'pull'
-	
 	add a 'log' subcommand to see what's new in a subtree?
 
 	add to-submodule and from-submodule commands
-- 
2.6.2
