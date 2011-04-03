From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/51] i18n: git-am "Apply?" message
Date: Sun,  3 Apr 2011 16:45:33 +0000
Message-ID: <1301849175-1697-10-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUW-0005ya-4G
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab1DCQql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab1DCQqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:39 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=QMnKQ98nbCy7kyXmyNkzU3NSPQNFR1dXetJC/24plUI=;
        b=QPqLtiGcMjqxzI7TkpFC5Hv7hdvgYK5PFYptOTPfOIXMlGsQYTBZ8khl8b38zpIBS0
         UOV76/smT0Z5P5r2N7Zl7cPqS+SAfMJDeZmmUCKLbE+rG2Ogb+quioFUjnGmJIf0pgtP
         YHNAQ4qaM4NZRWBdr+6Bru19jdzGe+Pd2hFfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BR5hOWimIMTnmeUSX8qZho05BNXIQ0vsYoxZOtEXg2ZSQbKxGxAfpCdkDd8gzSNzaQ
         GsuDeol9hJf7EquDeF2EowzUEIQW81Zp/B+zEzQk3TsysnZrlMzeDD2OCPAqpk9vn2N3
         CSNYMvjZlId0Mv0HMAWnylDl/3K8rYAuGTvdk=
Received: by 10.14.10.69 with SMTP id 45mr3059924eeu.33.1301849199119;
        Sun, 03 Apr 2011 09:46:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.37
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170746>

Make the "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all" message
translatable, and leave a note in a TRANSLATORS comment explaining
that translators have to preserve a mention of the y/n/e/v/a
characters since the program will expect them, and not their
localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ed48673..2c8770b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -700,7 +700,10 @@ To restore the original branch and stop patching r=
un \"\$cmdline --abort\"."; ec
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		# TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+		# in your translation. The program will only accept English
+		# input at this point.
+		gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 		read reply
 		case "$reply" in
 		[yY]*) action=3Dyes ;;
--=20
1.7.4.1
