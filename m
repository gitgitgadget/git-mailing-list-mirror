From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] commit-tree: remove unused #define
Date: Sun, 24 Jan 2010 23:05:43 -0800
Message-ID: <1264403143-11320-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 08:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZJ1E-0005TW-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 08:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab0AYHFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 02:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923Ab0AYHFs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 02:05:48 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57187 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0AYHFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 02:05:47 -0500
Received: by yxe17 with SMTP id 17so2538241yxe.33
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vp+L5+V6wrXGeXRQyFCMAuLW9jENDvc1k5Y96SgdzA4=;
        b=EE1dwA1SZTT9Ix667BbM+QsBHqMSclL+uGHaxlyZjZdpCX6M6PphYq5fBiz8H4nHby
         MIdItx2LrJDaZqUmA+iJTHAxiTaiIfdj6E38uhZn437FkeZZCBMZ3IeO6/7iAwDADabT
         oNctF/E9YVwvnJ1Ny9feYkecojI8A9GLcjIZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CCgWkreHO4eIxkCDaZV6Jg+caBLEOySsYROvqWfwDxropKEU8rniJ9XFS+UYFOF8+d
         TDUiUNguD0f0BUcFgH0VgUHKSH2lRL7uYy2UECjUcW7J+kYYNKd0EtUMapFEoR7RYoQa
         4izCD6RB97BuafmoInWJJk5FZtji/oAQRR/ZA=
Received: by 10.150.48.5 with SMTP id v5mr3628910ybv.103.1264403146974;
        Sun, 24 Jan 2010 23:05:46 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm1559890yxg.12.2010.01.24.23.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 23:05:46 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137938>

---

The fixme looks very suspicious too...

 builtin-commit-tree.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ddcb7a4..90dac34 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -9,8 +9,6 @@
 #include "builtin.h"
 #include "utf8.h"
 
-#define BLOCKING (1ul << 14)
-
 /*
  * FIXME! Share the code with "write-tree.c"
  */
-- 
1.6.6.1.436.gaba7d
