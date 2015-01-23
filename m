From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 5/7] refs: minor style fix
Date: Fri, 23 Jan 2015 17:08:25 +0600
Message-ID: <1422011305-4170-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc6T-0001pq-2b
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbbAWLIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:32 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:44157 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbbAWLIb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:31 -0500
Received: by mail-la0-f49.google.com with SMTP id gf13so2497736lab.8
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y5v3CvbR8QZbhOH5XF658Pwjv+BcFfq3o+qoPzy3IPk=;
        b=fjybJxXfqbfS+TDqfGbmLa6LG0tB4exNoaYNOJnAuxrCFg49JY/kKonxAbSV6WYRva
         tDVlSomKOCT7vyBlznIzeY1CwMDgv6Sivbh4LJZezvCfci2+MNqA+MkaOBDNkvdKP85p
         CpPzM6DabblYzrjI+GDYDIoGfTt1lBUjHIDKTFPr+2PE2SSea2hb6jITE02ZC2HYTYnx
         UrYVzP9rBAaVNlJpqM/UPzZalKwfiIETRoVfQnPyV0Dvm2bW9ygV12xgoj9pDIkUGvHP
         YS8WQgbf1rrIhFtIBx7LAOObem8B0y5gqjJG89vBPh+H3uJfRcDqUJDSJCMm7GLurvFJ
         avkw==
X-Received: by 10.152.115.230 with SMTP id jr6mr6790168lab.2.1422011309535;
        Fri, 23 Jan 2015 03:08:29 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id y11sm372611lba.5.2015.01.23.03.08.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:28 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262910>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 refs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 425ecf7..bd8afe2 100644
--- a/refs.h
+++ b/refs.h
@@ -86,7 +86,7 @@ extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
-extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
+extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char *prefix, void *);

 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
--
2.3.0.rc1.275.g028c360
