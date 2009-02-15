From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] config: Codestyle cleanups.
Date: Sun, 15 Feb 2009 11:01:00 +0200
Message-ID: <1234688460-9248-8-git-send-email-felipe.contreras@gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuH-0000wm-Pg
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbZBOJBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZBOJBh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:37 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54154 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZBOJBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:21 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so4790431fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8pNzVVmlgk8m9OGyLJ8VPmz+cd0seYaFug5qVdSPXQ8=;
        b=VVFvuvJHl043EBkybMZldpbCqm0k6UbG/HMRXyvALkfi2eDi12hgO7vhszpUVNWq++
         6Sxc+Hbl9Atnndh0VUYwBygJ6ipfuIlPBn2apyTiMy/dkjf9eHkDOzOmUjSMmM0tctMM
         PydRyVP9Bkj/PoZvRuvuh7LEDpWJrIg9DN0oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bhlP82nDo3RYOp6h+ix4zF3hqsKEeWbGQPrHQwIluQ7xB5zn7WCacHZ4eAS7AV86Xx
         TE8SQEFe8u9xRhw6aGMSYLHu81L0nQIOt7Pxe1W6P833YuRUzYvMn2Hgnrt7Id0+4Y/V
         t5f+j6589AN9qSs292EUAre64rAoaRWKoaY+Y=
Received: by 10.181.61.7 with SMTP id o7mr1477589bkk.31.1234688480711;
        Sun, 15 Feb 2009 01:01:20 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p17sm5669793fka.30.2009.02.15.01.01.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:20 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109978>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 677ae3f..4d1805b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -87,7 +87,7 @@ static int show_all_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_, void *cb)
+static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -134,7 +134,7 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
@@ -307,7 +307,7 @@ static int get_colorbool(int print)
 int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit;
-	char* value;
+	char *value;
 	int ret = 0;
 	const char *prefix = setup_git_directory_gently(&nongit);
 
-- 
1.6.1.3
