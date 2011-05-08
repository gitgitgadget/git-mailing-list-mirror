From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 19/48] i18n: git-submodule say + eval_gettext messages
Date: Sun,  8 May 2011 12:20:51 +0000
Message-ID: <1304857280-14773-20-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ308-0003rg-DS
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab1EHMWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1EHMVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:50 -0400
Received: by eyx24 with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ILnrsI2pWgo/k2igN5xqolAz8w9Q6nS50MYfTmYplXs=;
        b=J652lG5kNkE2dLkPxmLvSfP8Ffvw3sVW0icVlg0ulNi0vsO14mBn9HulIlry6DVr6t
         2W6fxm+s5p8Qdd0WjBkEK6s5Ed9DvIvQ0an3oLoff/jECbRYJ6rv34ri5CInnBpOzYLm
         flulQCN1nUGFy0y+CW9jyzgfz9ymKAgfVCvn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Um1NnBeMgC9QQaEhN2fX4hqoMmnbXJ9evy5JJNjXJePuHYs7z18/yJS786VeNbP3VU
         qlQ6/x4bSpL0XUilEssDmaMBmaa4PYXZ3NbQbMgK2edpsMBSNiROtnO4Bo7BqwHtq1y9
         Ys/DGBD9knBqiJxNzm9kM/SLsmWipdFB1+OcI=
Received: by 10.14.9.224 with SMTP id 72mr2770331eet.95.1304857309336;
        Sun, 08 May 2011 05:21:49 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.48
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173124>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 34c33a9..52e604a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -875,7 +875,7 @@ cmd_sync()
 			;;
 		esac
=20
-		say "Synchronizing submodule url for '$name'"
+		say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
 		git config submodule."$name".url "$url"
=20
 		if test -e "$path"/.git
--=20
1.7.4.4
