From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 7/7] run-command: mark run_hook_with_custom_index as deprecated
Date: Sat, 15 Mar 2014 22:42:30 +0100
Message-ID: <1394919750-28432-7-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:43:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwMa-0002LZ-1o
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbaCOVnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:43:23 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57871 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:43:22 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so808048wiv.9
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7jvnbhQK5C24zzot95UlHBN9QaKV3667nEJd66aPPX4=;
        b=utpkkohYHnJ3jjZ7qmn4kB1AHdpk9FWYqNurV2YUSmGecUqgbF17t021oAVu7XkZAd
         nNie27qN4xf33Ko7FUOLXucTzzZ8a7O87iYlyRrhWiZWwsdqIZgcKSzOvXQcPJF8SPaW
         BPb4PqdnLURd8s9rRbMcMsYf1XVqbJcYlPMoz0yJbJI1LVXF2Kb3POXlL9Jhl9pZEyGe
         6suItV49qZPE8Xx5wBfN4PNMGo6NgF+iUAtCNA2JkPX/rdyAbBgb31WyGUqE94+XiIFY
         lEP6Ee5JASsgXgDpdcwIXlPpWdSn1gz5KIfUGa0IL4lZpjx/fZX3uD7tz8v7wzdS1Vix
         a20Q==
X-Received: by 10.181.13.40 with SMTP id ev8mr3660666wid.0.1394919801943;
        Sat, 15 Mar 2014 14:43:21 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id fs8sm9235794wib.8.2014.03.15.14.43.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:43:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244175>

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 run-command.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.h b/run-command.h
index 88460f9..3653bfa 100644
--- a/run-command.h
+++ b/run-command.h
@@ -51,6 +51,7 @@ extern int run_hook_le(const char *const *env, const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 LAST_ARG_MUST_BE_NULL
+__attribute__((deprecated))
 extern int run_hook_with_custom_index(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
-- 
1.9.0
