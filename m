From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 18/51] i18n: git-pull "[...] not currently on a branch" message
Date: Sun,  3 Apr 2011 16:45:42 +0000
Message-ID: <1301849175-1697-19-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUY-0005ya-Sh
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab1DCQsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab1DCQqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:48 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vRSqDJu2tP5Dk6nLvgYvMm+Q078Ey6IjQ+gh1hY0SII=;
        b=BWESze9cz9uouAcQGyMfICwY6uLEgqMmh3x9YVAK/A5CKr7v8SPAJiD84/aO+/BOhI
         bXXTvYYH3Uq6n6W221LRCW81RUDSdewGspj/BS6T21nxy8N1yknRdBv65jwEEb4YQWia
         PuGUOEyIgqP+qMwVRu1YHhMpQmZW8r6Juc6fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=M2G9iclQyWgkQvwNB9f//n2XvA4S2aQr8CUhurf058gvxk+m7mQJFKRYNJ0HZOAawD
         yf6kdF4BKMkb7Vr4odBntAKGQOlPSWd5ILtaGljP6yEl8z9usYNYt8GTGVky3y93jwLy
         vgQe23Utsf0lU1XMfNgqSGBZ8+qysRFjfaNCI=
Received: by 10.14.136.73 with SMTP id v49mr3019981eei.235.1301849207529;
        Sun, 03 Apr 2011 09:46:47 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.46
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170755>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 821c48d..14d9eb5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -171,11 +171,11 @@ matches on the remote end."; echo
 a branch. Because this is not the default configured remote
 for your current branch, you must specify a branch on the command line=
=2E"; echo
 	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the comm=
and"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
+		gettext "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which remote branch you want to use on the command
+line and try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details."; echo
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
--=20
1.7.4.1
