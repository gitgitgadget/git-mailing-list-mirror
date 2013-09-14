From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] branch: trivial style fix
Date: Sat, 14 Sep 2013 01:38:33 -0500
Message-ID: <1379140717-12940-2-git-send-email-felipe.contreras@gmail.com>
References: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaO-0003XB-O6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3INGny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:43:54 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38206 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab3INGnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:43:53 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so1934757obb.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wi6oCrWo+m2Cb5UAJCUNrGZznbJIaTLz7Ra/rVlNADc=;
        b=SPYTylH7sA0ZBDy+Ex6opIN9NXEFkDLvDWrirycZcLNcVrxlBn+XKty+8Ji6Ic+PXJ
         zm3D/+kY/T+sTj93M/YbIcFeztIRrts8mNOHr82Sujrw8JbFQcERo4AfNKUVlAiXjIQ6
         Nuan6qzcme7ojNzsKJknUPBF37wj5J1AflzE/5eXWM7ypwBJ8cOrf28A5oALhJRuXDyZ
         wFfJ8B/Hhady1Jic2k+ZinDXthKnqi7JPtGscQDrYOCRAqUaEEjPXH+m+31eZrsRfBrW
         uTswaiNwfqYL6ey6v1eX6OVk5l5poF0NVtWnGFcPA3EsgH40AiNba/JfoPQHtjCszSkI
         mJHA==
X-Received: by 10.182.29.233 with SMTP id n9mr16103764obh.38.1379141033131;
        Fri, 13 Sep 2013 23:43:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm20426032obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:43:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234797>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..c5aa0ba 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -968,9 +968,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!branch_has_merge_config(branch)) {
+		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
-		}
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
-- 
1.8.4-fc
