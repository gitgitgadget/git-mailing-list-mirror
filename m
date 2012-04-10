From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] submodule: fix prototype of gitmodules_config
Date: Tue, 10 Apr 2012 21:10:26 +0200
Message-ID: <4F8485A2.2050708@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 21:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHgSX-0008Ah-5n
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 21:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835Ab2DJTK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 15:10:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:34928 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab2DJTK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 15:10:28 -0400
Received: from [192.168.2.105] (p4FFD8505.dip.t-dialin.net [79.253.133.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 6ADC62F806E;
	Tue, 10 Apr 2012 21:10:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195122>

Add void to make it match its definition in submodule.c.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 submodule.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 80e04f3..9c5e5c0 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,7 +13,7 @@ enum {
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
-void gitmodules_config();
+void gitmodules_config(void);
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
1.7.10
