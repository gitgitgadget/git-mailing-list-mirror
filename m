From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/4] backup_file dummy function
Date: Wed,  7 Aug 2013 16:00:47 +0200
Message-ID: <1375884049-14961-3-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 16:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74Iz-0003tU-0r
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab3HGOBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 10:01:09 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:46839 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab3HGOBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:01:04 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so869140eak.18
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AkpKgmcQgyTIitU4cseG1MlHmS/3Zn8OL0bXL8mSTGk=;
        b=PfKX26CjuS7O7Hno7ePDlEE4XKXK254WHyufqikPj+ps76sb07i5Fh0LQ+Fa08qe/Q
         eIUqnoQc3ptSWySABZ65+zUK5XwKzGGZVwthgOCP10fNTWy6dStktCelN6IQFeheoijo
         jtszI8vvNzVO3VUtJDEQmO0/x+n5LyXtZoTNE2MT1SANdbfPL5O6tl8gLZYrt/t8xwHh
         ZkWR2ll7gTcBd3apSNW0FC+y/xx54FdxFII0NFUMYF4lLXxN1RurPCe8o62uVD0w+YM6
         ecdf73V+mC/x1FPc9hxK3DJFLCVuKnDf88sWmKEELycgkTZPeoWG8Wn+YqMCjcIAFpnu
         AYDw==
X-Received: by 10.14.115.133 with SMTP id e5mr3315307eeh.27.1375884058287;
        Wed, 07 Aug 2013 07:00:58 -0700 (PDT)
Received: from localhost (eduroam-69-67.uni-paderborn.de. [131.234.69.67])
        by mx.google.com with ESMTPSA id bp43sm9916129eeb.4.2013.08.07.07.00.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 07:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.g2793d0a
In-Reply-To: <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231825>

---
 pack-write.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index e6aa7e3..b728ea2 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -344,6 +344,11 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 	return sha1fd(fd, *pack_tmp_name);
 }
 
+void backup_file(char *filename)
+{
+
+}
+
 void finish_tmp_packfile(char *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
-- 
1.8.4.rc1.25.g2793d0a
