From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 18/48] i18n: git-submodule echo + eval_gettext messages
Date: Sun,  8 May 2011 12:20:50 +0000
Message-ID: <1304857280-14773-19-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ306-0003rg-Q0
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab1EHMWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1EHMVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:49 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DGY1HnhO/JEXq/9GjkH+yfwY/4+qAzpPjgkkeYSAi8M=;
        b=sq3tvhtJin+VVd7QT13CDpt3FhF/t57dwiBIEyO0Jrzg3hXx6wDZeMQhEuNVBKMjyH
         n4T7FqFicii2EbkkbQS/C/V+TBPhJlvoljfMcauzu1F4N08ATdpsM19sVzQKS7dmMTCE
         eW++bC69Avdb+i2kGLnttEfKI2HnhxImlYK8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OW8dzfDHO3rqzjgmVIjds8r66FL24rf10o1g0cpacV57JOhS0cRBztVDjSf8bp3M//
         buqgjxvCTUGUmBGUw3ojMSbodrP6YmTxE8Cn9fVD30JUG4VJNFv396qwl1efyw43UCqO
         yrkJqrgKd285L1QH8c2M+1miHW/0DlHdq8mr0=
Received: by 10.14.43.19 with SMTP id k19mr2709059eeb.187.1304857308456;
        Sun, 08 May 2011 05:21:48 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.47
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173115>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 816ab3d..34c33a9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -234,7 +234,7 @@ cmd_add()
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			echo "Adding existing repo at '$path' to the index"
+			echo "$(eval_gettext "Adding existing repo at '\$path' to the index=
")"
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
@@ -658,7 +658,7 @@ cmd_summary() {
 				;; # removed
 			*)
 				# unexpected type
-				echo >&2 "unexpected mode $mod_dst"
+				echo >&2 "$(eval_gettext "unexpected mode \$mod_dst")"
 				continue ;;
 			esac
 		fi
--=20
1.7.4.4
