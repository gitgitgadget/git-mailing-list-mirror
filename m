From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] for-each-ref: remove unused variable
Date: Mon, 30 Dec 2013 21:58:55 +0530
Message-ID: <1388420935-14030-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 17:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxfhi-0008A7-U3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 17:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab3L3Q2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 11:28:30 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:60061 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab3L3Q23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 11:28:29 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so11778402pbb.9
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=7p6mVUX11d8CcLOV73fLDQmMy+ynPjJITjt0NDuIDE4=;
        b=hrAHH/w/hz0jQYr6WUgm4eDTCmUoMi7/tMXIlriOJVIeRnpdZgEC06jf7lQUGECVww
         23gMDVY5H647fofFgkje1XP9twbxOBRx7ZoL7gDUY/mJV8mAaQu4oHMHAXKVOafgQ7yB
         VV42cGWy8qx6o/mOxdGRkA9tfO9rdqpE3TnmJvSxm4J6nizMnOF3PNEQosoxTISsk0rI
         dj0+DOJY6Tvr5fSFFPU2KfpsmGNAIJyX5SOeWO5nAYZm1b1f8E80sNGbrrGi9PiLeW6A
         tvl/7flmlTA4UOQuZPvKWr83jHJSodXKWWZaq0b+1usH695kyqnxCrcDZaWQ9tbqcihj
         vsYA==
X-Received: by 10.68.108.194 with SMTP id hm2mr70455181pbb.22.1388420907793;
        Mon, 30 Dec 2013 08:28:27 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id pa1sm108196551pac.17.2013.12.30.08.28.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 08:28:27 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239808>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6551e7b..51798b4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -92,7 +92,7 @@ static struct {
  */
 static const char **used_atom;
 static cmp_type *used_atom_type;
-static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
+static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
 /*
@@ -1105,7 +1105,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!sort)
 		sort = default_sort();
-	sort_atom_limit = used_atom_cnt;
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
-- 
1.8.5.2.227.g53f3478
