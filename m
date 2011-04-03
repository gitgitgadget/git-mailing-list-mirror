From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 32/51] i18n: git-stash add git-sh-i18n
Date: Sun,  3 Apr 2011 16:45:56 +0000
Message-ID: <1301849175-1697-33-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTK-0005RJ-2i
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab1DCQrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1DCQrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8gu3KZxuliEhITPxORkdS+IJAOQyMB3OX+2LbAl1+rE=;
        b=u9+hd9i2npRUKJcB5B+4BGTttXOfmWn/HcK2nNrOeqvDa+USES3b7hAkGI5UPQUDeI
         7KyAjamqI9wpwEA5SBIdoY5eBwfJQLyRLD+IEC5UucxkD2G9Sbt50Xl3z19xt6iew5bP
         uLF8OaoV8rSQUEcLP+EP5iCF3Tn+lOS4SXPrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GieQS2EaKNsFyRvyxQ4WQyiEYTmKe95SSZG2r3l91dcYgx+t12UmaglNcqxpHSZAHl
         plUJxHwcoUTASwgEK6Dr1hSfcGXE3tgl5JRxTEOsR+4+tms+ZQsVmQ8nQLEbd9Fd3I81
         6P/ppGmkhGCFaBqI7Vw2Qr6t8yV8Ogic5DkBU=
Received: by 10.14.123.143 with SMTP id v15mr2890277eeh.218.1301849221129;
        Sun, 03 Apr 2011 09:47:01 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.00
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170732>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a305fb1..ff18364 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -14,6 +14,7 @@ SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 START_DIR=3D`pwd`
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
 cd_to_toplevel
=20
--=20
1.7.4.1
