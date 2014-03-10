From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 7/7] run-command: mark run_hook_with_custom_index as deprecated
Date: Mon, 10 Mar 2014 19:49:37 +0100
Message-ID: <1394477377-10994-8-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HF-0005To-6q
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbaCJSuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:50:05 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:63115 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbaCJSuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:50:01 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so9222401wes.28
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XdHNhcyo4zmcXDpU3eF7zhNpcxyVs57yv3Q8IV9MLi8=;
        b=Hhi8AehQEYepmNC8dlIDB6dV+3/itH7KPBDCLOsfKCatTNfrb4qRdFLmVu/We3FBeP
         ubc5zwY1mauW//vqqcQ5dKByJgpL479pBsx40PDl06RqeY5WI1JrfZa6Bf05/dgDH4iE
         dsMnBQTOX0XAG4EMhCKGubpkHewPIOLRTAdvYPTiFD3Y0Z69ckfg1Jee0OLmHGeJRRpo
         YMht4VRh2xCxaH1xNJKjaTei36UWLshbE+WKkQIVeyy3wr6PyUd1C0ORnM6AN4vDg+X4
         HMtncb82RE9EkkvsScJm2J2MUlgM7iG98G4QrDKd+nyil3b25hKj5gK8v446ezt2hTv4
         gd3A==
X-Received: by 10.194.204.199 with SMTP id la7mr29344315wjc.4.1394477400643;
        Mon, 10 Mar 2014 11:50:00 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id 12sm54370395wjm.10.2014.03.10.11.49.59
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:50:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243792>

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
