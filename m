From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 22/51] i18n: git-submodule say + eval_gettext messages
Date: Sun,  3 Apr 2011 16:45:46 +0000
Message-ID: <1301849175-1697-23-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUY-0005ya-AN
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1DCQsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1DCQqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:52 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6/hNVM9ZGl3l7DgvR0HU4dyoupDS3lXDXKERHSHAKlA=;
        b=xrxWfRJQAJ9yknA0XdLDi2L3zyaIkXEBv5JtIVazkro9KDFe/TLnB0DShiRj8tq97F
         oT5jYCZibNPNN7LrNxM/Pw+jfW63Hjd+i8Z7WwyOf6tYUaSDi7v5Ph9CdtftMDUp4LHW
         FKdL9z9pyC8h5eHJMsXzbY9JHW+1usVoM/EME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cDKZRiNZaaoI+vVdyY4BRMh8GPKrW1bw8epLVO0zosq1BBx3VCZ5fbEuL/45UKfE4o
         38waJgqneV0YIAna1LI/bIZESgsctUGrTQA5U+XJA6hYjKYCrObgkluBXCn/TGl9xKfc
         4pAWjzll0hs1c7+V/Kq/YZfzqBPgeZrkwCxVA=
Received: by 10.14.13.194 with SMTP id b42mr3111853eeb.31.1301849211479;
        Sun, 03 Apr 2011 09:46:51 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.50
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170749>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7a10a01..ba80b22 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -841,7 +841,7 @@ cmd_sync()
 			;;
 		esac
=20
-		say "Synchronizing submodule url for '$name'"
+		say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
 		git config submodule."$name".url "$url"
=20
 		if test -e "$path"/.git
--=20
1.7.4.1
