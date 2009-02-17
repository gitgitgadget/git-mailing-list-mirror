From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/8] config: Codestyle cleanups.
Date: Tue, 17 Feb 2009 02:54:53 +0200
Message-ID: <1234832094-15541-7-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-6-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGi-0008Gx-33
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZBQAzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZBQAzT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:19 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:43168 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZBQAzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:11 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so6405830fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B+X4LAIr3yzXKk7kjHL/bqkN7JCTcXQfnDVwznbiOzo=;
        b=r0us2ql0cZoiALYMPU0trR0iIh729tG3EufK9sgoSVX9Fc9958RExJ4o2WWrbeXnza
         A1+3M60Vkmi9u2IFxDhWCdnzAUXcc0vo7LC9RVZ8/PMvUbBll0g56a9x56ARdjXSVO4N
         ZWEviW5qQrOces02aX8nemgMSjPjCGCVtxNAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uYzrU746b+kmVS3XeUjppac56nNLtFxgpC5JTBsBuvcCJbByyCIrU5sYwyBBqdH6kz
         H7Pw3qhyQ346CoyG20dl6DvXCqd1WbsfE6RD3LEPbXdo9OvAfbdDWH/jjoZu3IgXkl1b
         Fl/+LQQ+aRamuhJpDQI682p0/T/H5dcZA/XkA=
Received: by 10.103.2.14 with SMTP id e14mr3284305mui.48.1234832110180;
        Mon, 16 Feb 2009 16:55:10 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id s10sm7015904muh.52.2009.02.16.16.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:55:09 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110281>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 5891a4e..ff9e029 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -86,7 +86,7 @@ static int show_all_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_, void *cb)
+static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -133,7 +133,7 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
@@ -306,7 +306,7 @@ static int get_colorbool(int print)
 int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit;
-	char* value;
+	char *value;
 	const char *prefix = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
-- 
1.6.1.3
