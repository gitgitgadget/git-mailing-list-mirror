From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 19/48] i18n: git-submodule say + eval_gettext messages
Date: Sat, 21 May 2011 18:44:00 +0000
Message-ID: <1306003469-22939-20-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrB7-0000JJ-LN
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab1EUSpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50211 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab1EUSpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:20 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451108ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0ZgWOTiyfhzqOGmH+Ze2XSamR+hIu/d8npLa70/dG+0=;
        b=xvFJqeJxNbonstJDO2pHhbepgiiYyCeV3UjEFCy8vVm3rSBjsuaXySqyq5+mgcFfmP
         NIGQlAi++3Z6eGsuCzDy7lQoJPRj++kQLlCEou9yWCXzkpY3iaBOmePGoUzIbbUwk2Rw
         az+3740OxiRss3Efi4tWlRQkycf4l37jxAB+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vOPiLNgRzTlSH131cngqzDL/pARaim52GPmDCi96+YQRf6KrNgjcm6seZ7+gK1kQro
         q+IXBgLUZvhtxLWqHAoevTH6zjzOhEHT6ztAivw/D94RAcQoDfXo6vLRb21G35BLzx46
         S/gFfH17rfJKsSR41zTR0WbM92Dqrd9WDbmH4=
Received: by 10.213.32.4 with SMTP id a4mr617516ebd.40.1306003519625;
        Sat, 21 May 2011 11:45:19 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.18
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174126>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 547f5cb..f193aa6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -878,7 +878,7 @@ cmd_sync()
 			;;
 		esac
=20
-		say "Synchronizing submodule url for '$name'"
+		say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
 		git config submodule."$name".url "$url"
=20
 		if test -e "$path"/.git
--=20
1.7.5.1
