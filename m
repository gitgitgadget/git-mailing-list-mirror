From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote: fix remote set-url usage
Date: Mon,  7 Nov 2011 05:36:57 +0200
Message-ID: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 04:37:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNG1J-0000KP-80
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 04:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab1KGDhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 22:37:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48118 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab1KGDhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 22:37:06 -0500
Received: by bke11 with SMTP id 11so3278038bke.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 19:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5GhNHS0DQrzJU2mXSQERlAiRYsie+JKNroeeJTJLbfk=;
        b=fHArDcuYG4NbQJqmwIGn0+TsL4KYFEZ2+sop0niUUg2BNFG+up0DIk6qn3iprj03yc
         0bk+B5iws4X04jExcto08vyiFkM4sjekT9buJKQyvw0WkMo/I5mBQFJHXd+x3tmSbWS6
         +Kcgu/VCAs8/+M9qwbGAVj55L86avAzOXsYys=
Received: by 10.204.154.156 with SMTP id o28mr17741957bkw.12.1320637023979;
        Sun, 06 Nov 2011 19:37:03 -0800 (PST)
Received: from localhost (cs27007082.pp.htv.fi. [89.27.7.82])
        by mx.google.com with ESMTPS id z13sm12758379bkw.8.2011.11.06.19.37.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:37:02 -0800 (PST)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184944>

Bad copy-paste.

Otherwise the help would be for a different command:
 git remote set-url --help

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index e1285be..2add79a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1427,7 +1427,7 @@ static int set_url(int argc, const char **argv)
 			    "delete URLs"),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_seturl_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (add_mode && delete_mode)
-- 
1.7.7
