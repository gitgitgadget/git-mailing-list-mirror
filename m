From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] log --raw: Don't descent into subdirectories
Date: Tue, 27 Jun 2006 16:27:51 +0300
Message-ID: <20060627162751.7801d17d.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 15:28:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvDbk-00053p-9P
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 15:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWF0N1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 09:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWF0N1y
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 09:27:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:39124 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932258AbWF0N1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 09:27:54 -0400
Received: by nf-out-0910.google.com with SMTP id m19so728276nfc
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 06:27:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uhL/+abPEL6hPjbmeatDjnPIsUt2t5WhnKNCO2M31zD2MYG3V0MLn7sXLK0OcwJbNfjiEsVB+5QuimgUal4NDPsvzp1UrX8OgMEZf7GxsBW27IQkc/LHntRekjMAwgt4gSyhZCvCm/K4m9rDmFUHW2lEDN4vcfuDxxk/AHtx6nY=
Received: by 10.49.19.11 with SMTP id w11mr5623939nfi;
        Tue, 27 Jun 2006 06:27:52 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id a24sm5474779nfc.2006.06.27.06.27.51;
        Tue, 27 Jun 2006 06:27:52 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22738>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-log.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 28cd8bf..7075987 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -79,7 +79,6 @@ int cmd_log(int argc, const char **argv,
 
 	init_revisions(&rev);
 	rev.always_show_header = 1;
-	rev.diffopt.recursive = 1;
 	cmd_log_init(argc, argv, envp, &rev);
 	return cmd_log_walk(&rev);
 }
-- 
1.4.1.rc1.g8637
