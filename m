From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 42/51] i18n: git-bisect gettext + echo message
Date: Sun,  3 Apr 2011 16:46:06 +0000
Message-ID: <1301849175-1697-43-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTR-0005RJ-G3
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab1DCQrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45462 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab1DCQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:15 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1503007eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=m/OZlNpw5CYzdpw3Olfp7sEh2JQgX9Q605XgYW//Upw=;
        b=GZMm1SfWlQTInAa8KG/7JoTyVHbUNGkyx51dMi4Xc6ilv6qOB4DlX3kUubZtNFPiUx
         k6CGUTqQFmE41LxDqX4F8bps7H7vv1ksNCl8RUlDvhuXHeAkUXiyqN3JxtXxseqU9nBK
         ARp7mYfhvtTSFW3O21EGzLhJCxDqqUJ1ZD4AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=of9P330wdgi5xcS6Nc4uTljYKQ+qrGMSdz/ZNvBWeEZhCstu54Cl+IsgeMqWkytoFG
         WF0JJcF3Cd7k6ytiKCuA1k+w/NSy8SCrfPRAOAFBeMEdMdFmt0+cDwo06pif6DLlkiWF
         StnSRnGxcmMq5XwXBeELu+NNrFeUTE7WS4DbU=
Received: by 10.213.113.140 with SMTP id a12mr1170235ebq.98.1301849234394;
        Sun, 03 Apr 2011 09:47:14 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.13
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170739>

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
1.7.4.1
