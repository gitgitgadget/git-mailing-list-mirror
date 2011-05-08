From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 41/48] i18n: git-bisect echo + eval_gettext message
Date: Sun,  8 May 2011 12:21:13 +0000
Message-ID: <1304857280-14773-42-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30t-0004Hv-FW
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab1EHMWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1EHMWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:12 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/oCBg8FlWKaadk0fEfmZ/KEMNkTm3I3WbWV0Ft/+bWQ=;
        b=F8L/3760TuzlKONlBnzGYWkm8xa4r9us4hnpOVKMzuKPRkVjKSQfmjpAL2APN+JBlg
         Lk/lFGkfv0uK1zOXkNT9ndz3CidkdFy3QOkbAwrOd6lE/nOGpbRCM0xIVAEe8VOQzFn7
         5sCmz9zYS8g6JL8TFLqybiJcnpvLdwoXgEYeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DIesUMDc5fNBp7xvVHudRfHaD6eAzYi+MKSiVK9athTXrbeTr4gC9hEeLALj/q10Om
         PsqI0pKriaVS4TaZACo12SEWgsu3bTVDpbHdYPFNAkt9xWuG2/71vM5Wi8fDL3VxSLOd
         TGTEIP54J0HvTtYnPQXydUi3FKzEugED+29ZM=
Received: by 10.213.35.129 with SMTP id p1mr701281ebd.40.1304857331833;
        Sun, 08 May 2011 05:22:11 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.10
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173134>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 80607dc..e74be9c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -408,8 +408,8 @@ bisect_run () {
       fi
=20
       if [ $res -ne 0 ]; then
-	  echo >&2 "bisect run failed:"
-	  echo >&2 "'bisect_state $state' exited with error code $res"
+	  echo >&2 "$(eval_gettext "bisect run failed:
+'bisect_state \$state' exited with error code \$res")"
 	  exit $res
       fi
=20
--=20
1.7.4.4
