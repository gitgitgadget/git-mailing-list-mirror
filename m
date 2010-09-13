From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 02/12] gettextize: git-submodule echo + eval_gettext messages
Date: Mon, 13 Sep 2010 22:09:08 +0000
Message-ID: <1284415758-20931-3-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHE0-0006se-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab0IMWJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:09:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0IMWJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:09:58 -0400
Received: by wyf22 with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HvSHDyKhWYqesZwDrby2s6DByjv9QnEwHqP6w9S3bJo=;
        b=ffqHvXv9gGzqE51lmfcU3drSh59xj1PY1cjyNOt7iYTvY3/l4I/jhxLSleZJ6oAsuD
         esAHE4iI4l3AhDuFd4ZBgW04EX5ldKgal4h4OAZCzWWvU6gTOOopwdcysc7DbOkQdgjS
         WsjrozfTuqJSSMrNlRTK4LVFKYSb/5Z8PD858=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eFozhog8uIbxkY89RWxCqSMl9+ofcwkDGlxsnkT2g7nn7TyozoRJSUwYtgo+OU3O4j
         OtbNzyYFU/nfRnmu+ZnEZHpOQ252tUpzq262YIcYmr9Pjz/32Dk8OKNVX+Ra4VXMOzOT
         lv0o65VFu/gTdmI+HXjMiAEmxWcnnj7R3Gpyw=
Received: by 10.216.234.93 with SMTP id r71mr3137931weq.104.1284415797307;
        Mon, 13 Sep 2010 15:09:57 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.09.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:09:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156135>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5ef3d0d..5a08fe6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -219,7 +219,7 @@ cmd_add()
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			echo "Adding existing repo at '$path' to the index"
+			echo "$(eval_gettext "Adding existing repo at '\$path' to the index=
")"
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
@@ -626,7 +626,7 @@ cmd_summary() {
 				;; # removed
 			*)
 				# unexpected type
-				echo >&2 "unexpected mode $mod_dst"
+				echo >&2 "$(eval_gettext "unexpected mode \$mod_dst")"
 				continue ;;
 			esac
 		fi
--=20
1.7.3.rc1.220.gb4d42
