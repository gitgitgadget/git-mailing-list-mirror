From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 31/48] i18n: git-stash say + gettext messages
Date: Sat, 21 May 2011 18:44:12 +0000
Message-ID: <1306003469-22939-32-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBU-0000TI-Rg
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab1EUSpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab1EUSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:31 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=lEfubYwG5JJJCCmbPQQsrqKi8vJhTB0dbDNSriGsp3U=;
        b=BIs19BfYzcpKcBZ3XlEUmzMzPIYC5wSgVlWgn1Qlp3Ja6ikztdM42iYYPixkcVhk8Q
         EAycs+WYxEYXyx6Gbp20nznHwl2R84gCargb/XGLTEVSOip23tLF1dqGK9DcB3k1hSpQ
         PLlLS51UzgSVhV44tiuO4nLfvWy5mOk4SZbbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZdlXPeTnI4iNnSpNl0bxAgDwRQh7zIdVrAM++3r7HTfaiS1BEyx9qH+k5oxVfDeudZ
         1IWHMggUFlx/+/TII/5IYXR+ZDmH+prf2V1vWMcDzXhLSsUiTaiscLUuAg/2x2YYiI7r
         J02LwvOEZzDPmInXayn/jiNWSUZWqSN76mf7E=
Received: by 10.14.17.103 with SMTP id i79mr275582eei.13.1306003530876;
        Sat, 21 May 2011 11:45:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.30
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174132>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index d720554..c3ca7a1 100755
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
@@ -488,7 +488,7 @@ branch)
 	case $# in
 	0)
 		save_stash &&
-		say '(To restore them type "git stash apply")'
+		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
 		usage
--=20
1.7.5.1
