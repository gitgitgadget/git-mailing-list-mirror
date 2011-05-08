From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/48] i18n: git-pull eval_gettext + die message
Date: Sun,  8 May 2011 12:20:47 +0000
Message-ID: <1304857280-14773-16-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ306-0003rg-7g
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab1EHMV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab1EHMVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:46 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=5HO7ISGLCUuRoq4rNQjctHzmlOsgLVgXASiueC5xJwY=;
        b=kv5UvYWoDxyZ9KrzvUOlr1/uz+2zwZXoAxAHK13FYg1bja5OUX9uMEcexreufEWYkK
         3f8PMHz1x+pDq1C0updBtiJKOVMZrpPvpzDR4C39e9IO5INDNyhkLL7w+1cuFBLm36U0
         Z+voW3Z0nNDm5b74Nkt73ZKJEufzSV2V2iW+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YLu9vVL5skt89DhiUxu0NkQiI1+bwjoUDUJP9q14OnhVzl7ZU25zFFS68h8tf/wqw/
         GNoHeVG/LtzxNb+zwIdJFpTSSksrDps9xairAQSzKT+01cgdjHoLNXEqBfeKQlaKy9Hp
         qdCuE8f069XEpdXWftT6pe06ZEl8sVlapVQl4=
Received: by 10.213.99.69 with SMTP id t5mr672171ebn.14.1304857305478;
        Sun, 08 May 2011 05:21:45 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.44
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173116>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index acb0c37..06dcd81 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -222,12 +222,12 @@ then
 	echo >&2 "Warning: commit $orig_head."
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die 'Cannot fast-forward your working tree.
+		die "$(eval_gettext "Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-$ git diff '$orig_head'
+$ git diff \$orig_head
 output, run
 $ git reset --hard
-to recover.'
+to recover.")"
=20
 fi
=20
--=20
1.7.4.4
