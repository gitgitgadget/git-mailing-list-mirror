From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 13/20] gettextize: git-bisect echo + eval_gettext message
Date: Tue, 14 Sep 2010 13:52:13 +0000
Message-ID: <1284472340-7049-14-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVx7-0004Wc-VP
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0INNx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0INNx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:27 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1Wnv6prh1eNHImTSH7mSKMKzBcZg3V02gBexkPV2cVk=;
        b=OW+8F76RL1xqJpWhPGB3jsq4u4Lb0zXWn59f61HrScKg3PClyGgXC+snv9bHyts5Eq
         47PIO40LYu4IlpSQmRkE6IVUGkE0rpjrBqViolxWOtgfrwzc1JUWa6bO3rbGGVNNLu0h
         j5MaSTWSvwB+qPiiRbXdPtTlXn9ehE8dktqjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XNHl+L4lZ/amXymIvr2h7vgO3UMYlAUcM1TpdXxz/qkrBpNKaQ+lqfHZiSdlLCYx2m
         QcjcSmx6Cr9ze7JSnrbwKqIva1aGHdDzA19PfsZyxip3+UjUGyYuyBRHaGau/UGA0dSP
         DR240EAmJV6k70X9Rey+y36RZiiffTP0re484=
Received: by 10.216.231.26 with SMTP id k26mr5794014weq.3.1284472405579;
        Tue, 14 Sep 2010 06:53:25 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156183>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4920878..c294819 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -400,8 +400,8 @@ bisect_run () {
       fi
=20
       if [ $res -ne 0 ]; then
-	  echo >&2 "bisect run failed:"
-	  echo >&2 "'bisect_state $state' exited with error code $res"
+	  echo >&2 "$(eval_gettext "bisect run failed:
+'bisect_state \$state' exited with error code \$res")"
 	  exit $res
       fi
=20
--=20
1.7.3.rc1.234.g8dc15
