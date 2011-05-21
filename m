From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 15/48] i18n: git-pull eval_gettext + die message
Date: Sat, 21 May 2011 18:43:56 +0000
Message-ID: <1306003469-22939-16-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCp-0001Bj-Lq
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab1EUSrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab1EUSpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:16 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bgMIQQ6arosjY1BAhEQdLc8ZmgnBUJmYWzY/GbehomI=;
        b=RuoWGySDDFCAGQ1v5u30LuEXXriQluH50xZdxIGfQ2bTPtkQdMQYYRDu5cNHYAvjpY
         phN7xpdXlBtTTZWJ+YejQ/yr6a7SgxjF619gwAEcIiYJFB7QjPN942C0OusOeB8JlrHq
         z04epD8CPwPk2gyLmezo11r565WiD0ysBFM5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Rd5v9cFVfcKSCTSmzBMTDtahhHOrem+THgavFOqtiQTAysVXqHHkKsj0LqXiyONT0k
         d+t2qd5h5gGMIKGB+xgFXvlSoMQVmuTFDN44AVLSskp/BMBC3VRdS0laHdoQJ0KeR1EU
         PxnOARJtY+lhWYQKCe4zDKMyTmJZHZZq7Veys=
Received: by 10.213.99.137 with SMTP id u9mr587274ebn.34.1306003515921;
        Sat, 21 May 2011 11:45:15 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.15
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174154>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index acb0c37..06dcd81 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -222,12 +222,12 @@ then
 	echo >&2 "Warning: commit $orig_head."
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die 'Cannot fast-forward your working tree.
+		die "$(eval_gettext "Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-$ git diff '$orig_head'
+$ git diff \$orig_head
 output, run
 $ git reset --hard
-to recover.'
+to recover.")"
=20
 fi
=20
--=20
1.7.5.1
