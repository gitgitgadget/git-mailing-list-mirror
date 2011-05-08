From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 40/48] i18n: git-bisect echo + gettext messages
Date: Sun,  8 May 2011 12:21:12 +0000
Message-ID: <1304857280-14773-41-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31M-0004a3-Cj
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1EHMXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab1EHMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NereHC5EdGjGx0OZleRsjYm1g/7AN0OheqnYakeEAII=;
        b=wYzo50vB+277QbCO5s/6zVnQBnjJpx4GC9Wagai3DM69mji8LlxQqEqOjGTv8Nrs5m
         lR2QX+4Cpu1Z1xzSPpUBwacwjmozTSOAa9V5IvHk+GkIJUN/+t/3N4R5EXSmmIK4ctVq
         PJjJzlXjvfS14chD5qukJC0brWwt/hKqVIr6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xDNxkj+uQycWeWJxwRr0UJMfY455iJI+piAWVIhy1fyvPRRNxluISQEzQi39auz4Hq
         LOGwOzo4IPL5GiO4RuTP8XhciSfxap1tbZ3odHquHCngXbBy2NLNWzi1do/BnOp+NS0P
         dqdKOK0FWGxj1pHEEhkQ2tgCj/i+emsfqEEk0=
Received: by 10.213.36.10 with SMTP id r10mr612939ebd.131.1304857330578;
        Sun, 08 May 2011 05:22:10 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.09
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173147>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4420b46..80607dc 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,7 +36,7 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo >&2 'You need to start by "git bisect start"'
+		echo >&2 "$(gettext "You need to start by \"git bisect start\"")"
 		if test -t 0
 		then
 			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
@@ -239,7 +239,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		echo >&2 "$(gettext "Warning: bisecting only with a bad commit.")"
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -403,7 +403,7 @@ bisect_run () {
=20
       if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT=
_RUN" \
 		> /dev/null; then
-	  echo >&2 "bisect run cannot continue any more"
+	  echo >&2 "$(gettext "bisect run cannot continue any more")"
 	  exit $res
       fi
=20
--=20
1.7.4.4
