From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] build: do not install git-remote-testpy
Date: Fri, 24 May 2013 21:41:06 -0500
Message-ID: <1369449666-18879-7-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Rr-0000Of-2f
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab3EYCnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:43:06 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45935 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3EYCnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:43:03 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so6327823obb.32
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6WPUzxbWX5pjKW0SJP++AQ7hKFcAstamsjVekr3XxLk=;
        b=V9Ra0dnif6T3jAtCvXW92BB39ui++FA7hl/byKDkSVSt2u8MLc20Sup3+rURiNhHxM
         oOCLW4NvpfK3a8O/QEmdtsfIM+1MeFMzV9PBURILz7bP6mU1iWcTgnkX7Drs6VBcpq0O
         Q35CuRdPXAbGjxselBV27jfi9GgGMneZSidI2iBd0N9uJtvdQ9ysO4bLTuCPd0AsE4fb
         6DpKlxDQ5hjYvWOxRbYn4cZI5w9Np8flgBTkuVRqlSXYjhIKQgkuY5bmTxZfxWRLjcqi
         ONBdNIsW16Kd+JeSGzl8G66YNtPojMxgJOG9lLjF+fhstgQOKLxAxvuw4Y4lDVr+6ton
         RAqg==
X-Received: by 10.60.56.107 with SMTP id z11mr13196473oep.99.1369449782439;
        Fri, 24 May 2013 19:43:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm20045653obb.14.2013.05.24.19.43.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:43:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225473>

It's only meant for testing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 333b5d3..ad70d45 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,8 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
+NO_INSTALL += git-remote-testpy
+
 # Generated files for scripts
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
-- 
1.8.3.rc3.312.g47657de
