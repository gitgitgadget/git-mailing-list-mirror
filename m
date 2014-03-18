From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 7/7] run-command: mark run_hook_with_custom_index as deprecated
Date: Tue, 18 Mar 2014 11:00:56 +0100
Message-ID: <1395136856-17225-7-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
 <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqq5-0003wX-W1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbaCRKBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:37 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:38104 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaCRKBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:35 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so5536176wes.6
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7jvnbhQK5C24zzot95UlHBN9QaKV3667nEJd66aPPX4=;
        b=TEbYJL4Rez4mDi+DKLw/19YwGlz2fKFGulESjipyLcRxZLB23UDa0blfiVFAo6FfKK
         rArNsqyaN/2n97sCT2OpyiauRR8nViThNmqSmMJp71+/LKBmed+iBs/eh2SJ0i2c/ILi
         kllERb0AA0alSs7r224g6+T2wr/3lsmRCTlp5GVZv66VB1M/aR88gzAhxccNBCDivA18
         4HhjgMwQ3V0JAqbRPZZvW+VI36MJrvl+HBJXYCqeUyJEytQZYlocYNf7myxv0cG344LT
         cN4YJ09b8DhHxFbGEAeQq814667GwDoVpLjFgGDVgAR+2+zbuur8JHQCp3Conn4Yskqs
         zdOw==
X-Received: by 10.180.82.37 with SMTP id f5mr13355881wiy.6.1395136894495;
        Tue, 18 Mar 2014 03:01:34 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id pm2sm40225106wic.0.2014.03.18.03.01.33
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244347>

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
