From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] symbolic-ref: trivial style fix
Date: Sat, 21 Sep 2013 11:29:53 -0500
Message-ID: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 18:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNQ9m-0006tq-1F
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 18:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab3IUQfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 12:35:25 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:57515 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3IUQfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 12:35:24 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so2007819obc.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ymOMKZ503sjrE/AgTxXVPnilohebMHDCgUJuRDwWFDI=;
        b=nhSysx8cb31+6IdekibGV6h9fFV9pxdg2sl4qU1BB/kNgZQKwj6TykYUwkYKp3cSGr
         SHolHm7au3nVNqfpmJ1EPhjkLOYPiDXqPicqmZbZkZEwWUlY7oMfoOGI8jUiQeB5turR
         dPSAYxNCdinyEEP4NvwlQzGkTlYJo2GsT4nftqunHn9vnqObeVPm1vug7qRM+bH24vgf
         +NCpXFZWutOnx6S0t7UyOfb+EccjvrL89/VhiSdl1i8d0N0Wr7Bch3Z2XWHdwrYYh/tz
         NcGgk8QWwtGcFKRq400n9lAauUVlcEWc5S1RhQ18jiKmxbvNZ57gJhLdWUf1L1+4AlfV
         7UfQ==
X-Received: by 10.60.65.227 with SMTP id a3mr11227816oet.13.1379781324314;
        Sat, 21 Sep 2013 09:35:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm7670693oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 09:35:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235129>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/symbolic-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index f481959..71286b4 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -47,7 +47,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
-	if (msg &&!*msg)
+	if (msg && !*msg)
 		die("Refusing to perform update with empty message");
 
 	if (delete) {
-- 
1.8.4-fc
