From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 39/48] i18n: git-bisect gettext + echo message
Date: Sat, 21 May 2011 18:44:20 +0000
Message-ID: <1306003469-22939-40-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC3-0000od-Lw
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118Ab1EUSqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970Ab1EUSpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:39 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444635eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=l4MPXDrvWmiUv41eF597M22+chVqQaHSS7YimOUBdHA=;
        b=DGF+O0hR5+psb/dSgX0EKAlmfxyfVuR6M8hAdiHjZ3eUhtSAX0eEIdyD44+7ws6GLL
         p26qy2xURD7nLcpAI0WUwOjT4l1FaH3WRLDCghFGzMFmexZTTJZ0s0NQWcfOIq5mwXv/
         6sHy1arR9CRwkJe1gteF8OoKjpz7I6A54d65E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BAtzUWX9RdictP+i64v6h6R0bpV2Itz+CVLvL3Xm8msmsvdYUlEqTn3d0msCaHQuXx
         cpNQbv5KiQ+eYeIn/3MpmATpbNgQNaifuX+mBlOSklWNOzmZYh6ihOZaCpPqatlX2a1E
         iInSVAfVVrMrSry+y257kqfF4hnHP3+MXAnoo=
Received: by 10.213.9.5 with SMTP id j5mr579263ebj.22.1306003539019;
        Sat, 21 May 2011 11:45:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.38
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174142>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 751c733..4420b46 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -308,7 +308,7 @@ bisect_visualize() {
=20
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo "We are not bisecting."
+		gettext "We are not bisecting."; echo
 		return
 	}
 	case "$#" in
@@ -414,7 +414,7 @@ bisect_run () {
       fi
=20
       if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /=
dev/null; then
-	  echo "bisect run success"
+	  gettext "bisect run success"; echo
 	  exit 0;
       fi
=20
--=20
1.7.5.1
