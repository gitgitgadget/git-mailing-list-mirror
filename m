From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 21/51] i18n: git-submodule echo + eval_gettext messages
Date: Sun,  3 Apr 2011 16:45:45 +0000
Message-ID: <1301849175-1697-22-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSJ-00055g-3w
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1DCQqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1DCQqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:51 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GA2Jd5lcQqMJQiUzlzq1hXqLrRsM301Ac2LHTFwUJZo=;
        b=bqLbgvaDR2sgKkLXJUMIWtcWoCXCRUcioNrtYD/f6nW6YsZ2a0/F11YytVpxxzPeFE
         ZEUeBE0WOG0SDDwQaDMy0hYL/dOEnsq3I4NYKzr+sQuNRUCM0pAJAJnl2TQOLNrLJxGg
         oX0x7mL7WWxDjRztmq9ExKoMR0tceVsZevzlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IKYkl9F22t9ltVCS9RMaxtgeGw35KJwnouMw54NQSsfWgE3E1s5KbyahXw/HeO7lQk
         BDvd/ux9MW/qQ4ZpG2L6lPo/63Id1fSXjOU4Me9m0163BA6bsu8STtHH1m052noCzYXW
         WAAr8ihPD/i02MfrnvUPtcKWzXWaCe6cic6ss=
Received: by 10.14.131.143 with SMTP id m15mr3053140eei.10.1301849210674;
        Sun, 03 Apr 2011 09:46:50 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.49
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170719>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1d128f0..7a10a01 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -217,7 +217,7 @@ cmd_add()
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			echo "Adding existing repo at '$path' to the index"
+			echo "$(eval_gettext "Adding existing repo at '\$path' to the index=
")"
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
@@ -629,7 +629,7 @@ cmd_summary() {
 				;; # removed
 			*)
 				# unexpected type
-				echo >&2 "unexpected mode $mod_dst"
+				echo >&2 "$(eval_gettext "unexpected mode \$mod_dst")"
 				continue ;;
 			esac
 		fi
--=20
1.7.4.1
