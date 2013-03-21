From: Max Nanasy <max.nanasy@gmail.com>
Subject: [PATCH v2] diff.c: diff.renamelimit => diff.renameLimit in message
Date: Thu, 21 Mar 2013 15:14:38 -0700
Message-ID: <1363904078-98433-1-git-send-email-max.nanasy@gmail.com>
References: <7va9pwa3h9.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Max Nanasy <max.nanasy@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 23:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UInmN-0003Wo-68
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 23:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab3CUWPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 18:15:43 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:40160 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3CUWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 18:15:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so2569152pbc.17
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pmj8aEkb6yEQSfjO6N/6J0V96q9BpZx5IvJB7RUM7rw=;
        b=e5iFigpdWg6niQlYdbymlHPo4As6TSjaVd3GmGKfSnB9kc8qs6A7qqT6o5puzTJ+91
         Q4Cw5G25IKubpNQUN00hvz6RffmuiZZGQblFpMfthC0OuSO5xNf9Qn+ywFAGK+nTuTXs
         oAZdTV7g7ahZos2NTbJgSdsZ0fCsSJJCVOJ4+YyaQUfW2NnZqNjHaqtaLPJ8TgJZJEnH
         29ehRzmlG4Yedf1fh3WJrNZ3oFui3YoggE6Q/WE8J0JBAwLshL2J22S97WBndk2sG7c8
         NgmjVXz0NwcpQFsVgQ0Kd7dSpU8WQialvbrW1jaCEmvhUI1JkLBqH/jU/YW/A4fLKWhC
         UQnA==
X-Received: by 10.66.241.106 with SMTP id wh10mr17111792pac.143.1363904142521;
        Thu, 21 Mar 2013 15:15:42 -0700 (PDT)
Received: from mnanasy.local (pool-71-177-75-113.lsanca.fios.verizon.net. [71.177.75.113])
        by mx.google.com with ESMTPS id pb3sm7477202pbc.7.2013.03.21.15.15.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 15:15:41 -0700 (PDT)
Received: by mnanasy.local (Postfix, from userid 501)
	id 4B3CB6807A3C; Thu, 21 Mar 2013 15:15:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
In-Reply-To: <7va9pwa3h9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218769>

In the warning message printed when rename or unmodified copy
detection was skipped due to too many files, change "diff.renamelimit"
to "diff.renameLimit", in order to make it consistent with git
documentation, which consistently uses "diff.renameLimit".

Signed-off-by: Max Nanasy <max.nanasy@gmail.com>
---

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> The patch is severely whitespace damaged.  If you plan to keep
> contributing to Git, I'd like to make sure that your mail toolchain
> is sane, so that we do not have to keep hand-adjusting patches
> submitted by you before applying.
> 

I composed the first patch through the GMail web interface, which converted
tabs to spaces.  I'm retrying this one through git send-email.

 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 156fec4..052974e 100644
--- a/diff.c
+++ b/diff.c
@@ -4662,7 +4662,7 @@ int diff_result_code(struct diff_options *opt, int status)
 {
 	int result = 0;
 
-	diff_warn_rename_limit("diff.renamelimit",
+	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
 	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
-- 
1.8.1.3
