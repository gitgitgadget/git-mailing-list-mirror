From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/20] symbolic-ref: trivial style fix
Date: Sat, 12 Oct 2013 02:07:09 -0500
Message-ID: <1381561636-20717-14-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOg-0005u7-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab3JLHNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:51 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51096 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:50 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so3443266obc.41
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ymOMKZ503sjrE/AgTxXVPnilohebMHDCgUJuRDwWFDI=;
        b=tysmeGVOvftk2KcAu6M33lV2LvNi1Aj40B7y+BHtlGg1i8sglAxapTCx63MrV6VMyM
         ddCRqlkF8jluNqjld7tReoAwoUY9h4wwh++WBLY1hM7bY0YMfzMb6FVmu1k3FnFVKvtC
         mv11M4ejYbz+Rzwx3Y84MM6e72+eTkptLeQj5DG1+NL2jdjWeMtk/d9z/XUguVA5i/gS
         5AdDT+S9szW+V+NZaMVyywT+8eUqsJjqTUL8U7L4P1nUZoycdizCP7G8e+jzdX2W5/QI
         sgpDjMP2qGJpz9/2i/WezT+LJwVLN7vA3X4rWLoFfI98o9X1LPhq3Majxj9EZjlY1jQp
         LEXQ==
X-Received: by 10.60.56.3 with SMTP id w3mr13744375oep.37.1381562029754;
        Sat, 12 Oct 2013 00:13:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm101393252oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236021>

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
