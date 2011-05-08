From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 31/48] i18n: git-stash say + gettext messages
Date: Sun,  8 May 2011 12:21:03 +0000
Message-ID: <1304857280-14773-32-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31O-0004a3-21
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab1EHMXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1EHMWC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:02 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DIFmD0+CuekxBGQc17goB7S+gvs9E0IfvKFgZqLdY2U=;
        b=TQleiVnEBF/YHlPNvFD+q7nkj8cAK5XT8UK4NVjX+fMTf23cQwbuLqP5Xt9e+CDa17
         49U5qID/CPVm8d1wn3QEOMe/XfuCzOCx9qtf32bct/1rq5KRb2Q3tVnHHBQ9EaqTJ3fk
         z74fl+EFDO7ZIsxzZQtjTV8ehu9M+2TLy+ufY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kpgl9GS9ivAZjJKXinIIG7nO1vGNhQip//aplad1+TQ+8v836HSqBdlsscnD/16JMw
         kRn9FXunZLJ7jNtpxzExQXGPEjuIXAin51x0AiWqrBoHyWpPITet9qbBX4jdAUoRleUC
         RYWYOCuNBPdRFxQGSrRbtEdfCA0KhABVo5Ka4=
Received: by 10.213.21.28 with SMTP id h28mr1959828ebb.118.1304857322123;
        Sun, 08 May 2011 05:22:02 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.01
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173145>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f3bb3c5..cf22c90 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -168,7 +168,7 @@ save_stash () {
 	git update-index -q --refresh
 	if no_changes
 	then
-		say 'No local changes to save'
+		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -485,7 +485,7 @@ branch)
 	case $# in
 	0)
 		save_stash &&
-		say '(To restore them type "git stash apply")'
+		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
 		usage
--=20
1.7.4.4
