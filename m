From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 4/7] http-backend: minor style fix
Date: Fri, 23 Jan 2015 17:08:17 +0600
Message-ID: <1422011297-4116-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc6I-0001hu-VH
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbbAWLIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:25 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57526 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbbAWLIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:22 -0500
Received: by mail-lb0-f177.google.com with SMTP id p9so6433984lbv.8
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oc7PkvThYE5L2O+1Iht2/ETIpE9Z3QxeGfR8QnQMTk8=;
        b=xcIc7vDDsO5bgzNbN09JPQN5GIJlxtH7p+lTPP9PiMf8lTKLKLz4I60zaUM917AHJ6
         Kcn/TjRx+TODccdJigptpJmj5246UneUK+W9ceT6TkB6b+9dvTzwxsq0h8NerkAaRBe+
         LS+lq5MYhNFfNW261msGIOPOlNEOG2pQs59/RXucAl5J2ZS8g/8f0IwH7Eb3JDrMcp2V
         WnI3dVds4LZAM5AWMdykbzxUKMOobkaPi7oN2O0XOk3oVaxIKQ8yY57lcvzWnIbs6SW4
         mlnDSdQ2qMb5IBJSTbOBvUokGv2N5niYlCY2SAkf2CnLENQ5hLWDAdjtEoPR0YnbBSCd
         TtGA==
X-Received: by 10.112.235.67 with SMTP id uk3mr6692613lbc.48.1422011301273;
        Fri, 23 Jan 2015 03:08:21 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id db7sm369533lad.16.2015.01.23.03.08.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:20 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262909>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 http-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index b6c0484..7b5670b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -515,7 +515,7 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 	exit(0); /* we successfully reported a failure ;-) */
 }

-static char* getdir(void)
+static char *getdir(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *pathinfo = getenv("PATH_INFO");
--
2.3.0.rc1.275.g028c360
