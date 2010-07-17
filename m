From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git add: Add --ignore-missing to SYNOPSIS
Date: Sat, 17 Jul 2010 15:33:15 +0000
Message-ID: <1279380795-15118-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 17 17:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa9Oh-0002e9-Jn
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033Ab0GQPde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 11:33:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56386 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0GQPdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 11:33:33 -0400
Received: by eya25 with SMTP id 25so750454eya.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 08:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zGY1pNo2t7CScU+CvBVmHT/hzSZJXtwP9eN9Ha3v+r8=;
        b=bRb7PSNAWV7KSefcF4D/0if6Oxl3P+SnQQ53HwFpCg/F4x/SewMKeBiMV5m1NKEikM
         YhjnVSG+pu2qgGtl6fyLK6/rErjsLp+Q7nGU0H3/gpApq+MhIPCer9EQaefIKadFpCnH
         kWCROxhAxs+u5t5lF7YARXLu1L+uO0qLRVke0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZnjNdhxEbt9IhaeJmY6YmzvyhTt0b8M5UUkZV3ogu6r9jvohOpiOPZ5yayHW0A0+K3
         LTxAymA42d16s7uEJMLF0vn8AplrypUiMWgzbF3ySRbd7razE5ApfkQHF4D6c7ugQLs7
         JZpor1nUe9DdworNQ12/pkG6YGEbu7Vk+uL5w=
Received: by 10.213.15.197 with SMTP id l5mr732860eba.95.1279380811227;
        Sat, 17 Jul 2010 08:33:31 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-233-160.pools.arcor-ip.net [88.67.233.160])
        by mx.google.com with ESMTPS id a48sm28797308eei.19.2010.07.17.08.33.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 08:33:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151187>

All the git add options were listed in the synopsis until the
--ignore-missing option was added. Change that so that the git add
documentation now has the complete listing.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-add.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index bfea2c2..e22a62f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
-	  [--refresh] [--ignore-errors] [--] [<filepattern>...]
+	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
+	  [<filepattern>...]
=20
 DESCRIPTION
 -----------
--=20
1.7.0.4
