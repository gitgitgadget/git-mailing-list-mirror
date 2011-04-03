From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 34/51] i18n: git-stash say + gettext messages
Date: Sun,  3 Apr 2011 16:45:58 +0000
Message-ID: <1301849175-1697-35-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSM-00055g-Cu
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab1DCQrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab1DCQrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:03 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Kr5jAoZVdsVjlrxssltXVvwVpUO9sW/9hEq0bhL3S8I=;
        b=OVbGrdn8AgWfs+FgWe9m+Uv1XaEz7V4HYpZsX4P7aXE9lWVWlTM6Xu0eRlzov+61J7
         ZlCCNe0TB+Z/4oCMl/VIoFBMEa248QzFGjO64bOhOACyqVqFxI/z3H64igQ98PkVKvMT
         xIcD2E6mk3OkrEsb5kPj2Jx2GUnxlE+UyQHaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tbIjsOcYVtbqP4yR15OUGQnYnsXdp9zMfR0f11S5oxeOHBj2wwTO2VrzWj6Lk2dRsh
         ZjXf3JiTi8O+fz9HIPPNKsurjaOTo4u7TcJdP7ZW0ac3cN1cU29Vz8IyY1GMRGjFY9Zp
         PzNEp2RqUnSznXGoBnktli5V70QTepBh+y9UY=
Received: by 10.213.10.193 with SMTP id q1mr1176258ebq.17.1301849222843;
        Sun, 03 Apr 2011 09:47:02 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.01
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170720>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9259f13..1fe8918 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -167,7 +167,7 @@ save_stash () {
 	git update-index -q --refresh
 	if no_changes
 	then
-		say 'No local changes to save'
+		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -496,7 +496,7 @@ branch)
 	case $# in
 	0)
 		save_stash &&
-		say '(To restore them type "git stash apply")'
+		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
 		usage
--=20
1.7.4.1
