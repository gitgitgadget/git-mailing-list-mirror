From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/51] i18n: git-am one-line gettext $msg; echo
Date: Sun,  3 Apr 2011 16:45:26 +0000
Message-ID: <1301849175-1697-3-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUV-0005ya-JJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab1DCQqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1DCQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:32 -0400
Received: by ewy4 with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tH5PZu0d/J0LNBK3rrlk7PkRijAbi3SzAOVM9OXiMtA=;
        b=R22X3b91lx4PhD2INNG31rWpaFkoRIGE0CUJtyksmEWpXLqBgGKLjT31fUuBKyjFzL
         bkwU9SxwK521hc/iFh4ZjeICiR8Uh9LJUZ+WaU/amSthrG2ZuF96Qqzi3oX0nYmp35ZI
         N5cEphsziYXNg9B/9rfzMeK6KSzD7tqdIhTdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=t0rIqQZ9Z09qKOb7aSeEk0m0QWKDa6K4Pmtm24IepmvFkMQKxw5NBauCRu97oirluh
         UZ2AcY9+LkglVnrdx7BNgRik9lwjCh+TE8+7KR2NXSyTouh1PuTWr1GB7JwDQgVRglvl
         O6l26V+WnfGczoBSVDlQ9G+FZkECOZcdqO62U=
Received: by 10.14.48.7 with SMTP id u7mr2939475eeb.221.1301849191737;
        Sun, 03 Apr 2011 09:46:31 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.30
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170745>

One-line `gettext $msg; echo' messages are the simplest use case for
gettext(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 79c5ea2..f54f13d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -115,7 +115,7 @@ go_next () {
=20
 cannot_fallback () {
 	echo "$1"
-	echo "Cannot fall back to three-way merge."
+	gettext "Cannot fall back to three-way merge."; echo
 	exit 1
 }
=20
@@ -645,7 +645,7 @@ do
=20
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		echo "Patch does not have a valid e-mail address."
+		gettext "Patch does not have a valid e-mail address."; echo
 		stop_here $this
 	fi
=20
@@ -696,7 +696,7 @@ do
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
-		echo "Commit Body is:"
+		gettext "Commit Body is:"; echo
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
--=20
1.7.4.1
