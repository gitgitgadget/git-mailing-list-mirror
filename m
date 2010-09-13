From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 7/8] gettextize: git-pull "[...] not currently on a branch" message
Date: Mon, 13 Sep 2010 19:35:57 +0000
Message-ID: <1284406558-23684-8-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpQ-0005HT-OS
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab0IMTgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37998 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab0IMTgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:23 -0400
Received: by ewy23 with SMTP id 23so2859821ewy.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TYwoA8BUzIWrJS4dsFoJpG0aFOown/bvZC4jPTk/4f8=;
        b=tR1r4EjsIHrrali7oe/xfEGsFzCUfxP1MvVI/4IkFv7aXZtYmyo+4lfbqc3YI29Jck
         UhXCDWowmvE2q6fZ+LxxyImAkmEp/6P/P/GZ151XP/AVwe9YOc+ZP9xDlZAN8FhDZDFo
         a5N1jP1sMatm9ZiZwpZac+RWgeZ0GqQOy5w2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IgyLpmVJG34rLXUW/PM+QlZcHly9vJtA3nkcW1z4o+g+KTGzQuntRX+PAe7ouc6p2E
         txaaFjcn0go+MtSX7tBxoa2a5VhJv3ImrM/v51pU1kWfPAHJTpyO9oCupK/lX5NznRJs
         Aneq9tViZ2VsPuZP7NTLC1W4/AVsSsysJJAQ8=
Received: by 10.216.174.143 with SMTP id x15mr2973509wel.105.1284406582085;
        Mon, 13 Sep 2010 12:36:22 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156116>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 6ab09b6..ec37d1c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -163,11 +163,11 @@ matches on the remote end."; echo
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
1.7.3.rc1.110.g6776a.dirty
