From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 44/51] i18n: git-bisect echo + eval_gettext message
Date: Sun,  3 Apr 2011 16:46:08 +0000
Message-ID: <1301849175-1697-45-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTM-0005RJ-SR
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab1DCQrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1DCQrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:16 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=10k2NQHaMpRSanc+MWA7N9rtS/+XhLoCVCwmaebCHcU=;
        b=cLTG7PF2d7NY4u7tVIiYPJBgCOQCdmDBckgxtVIsuBLHdINe04rMQ8fSnmJxiIO0ft
         jTVJ/GP5WQzfZ27k7aFsJ19eD1YvqtHA5GsX6PheO6RhanUJ1TC9gORtrVKTCnqR9Zpf
         UwNnOodwn/v6h+9DnHpGrpO1PRrjnsoA0DQHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wNtw/8sQhf6H/j5S4E0XNdrypHjEZ/55ikuzEvii01Yo8yAsJxVFQwwG15Yc+wQIrt
         qnvyF2UfS02gcdZ6yUEnWrJTO6eHpNOJ/ueH8oRJVWItASuHoWwWB3DMHorOw6YIbk6K
         NIaXRGHQvTr0l1gQ10t1cahOmgbpCnVmnKiZo=
Received: by 10.213.107.17 with SMTP id z17mr3169228ebo.100.1301849236086;
        Sun, 03 Apr 2011 09:47:16 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.15
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170727>

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
1.7.4.1
