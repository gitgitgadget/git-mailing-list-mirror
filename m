From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/48] i18n: git-am one-line gettext $msg; echo
Date: Sun,  8 May 2011 12:20:34 +0000
Message-ID: <1304857280-14773-3-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zb-0003bV-Be
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab1EHMVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1EHMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:32 -0400
Received: by ewy4 with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jLei3B7RaTs1JPJJgWkkpHOOK3MLMyEEwCvQ3GSnAco=;
        b=VwToBTs7SeTe94EEYr8Fh8gSLyPsQBlR7nMCHezK2HDRBNDMmAFatEKC9KI+63tUsb
         axgJ/OlY+CEnmA90sltArU4+qrQIZ+Trz0dijT4+j1i3cysizdZmGz8AQjDQ3zIJEZVQ
         X5HQlH37i4IkEOPEaiRngWFY/kDxAu+3Epvfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rNdg0OzEMdnKev4qOw3i45SukI5m5CGa0L+n87uagdD+Br8eFBIfT0gtgXb0ZzUJOl
         v65xCWgM0ULfGH+s68aAWOEtHtjUc+zFYRMpDJevD0OeG2qv45d9KeVtTGWcuxR1wn4L
         K6o1fudpaKzLq1U+Ssl5qSliK0QIljomO0gko=
Received: by 10.14.131.75 with SMTP id l51mr2600776eei.183.1304857291718;
        Sun, 08 May 2011 05:21:31 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.30
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173106>

One-line `gettext $msg; echo' messages are the simplest use case for
gettext(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 79c5ea2..f54f13d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -115,7 +115,7 @@ go_next () {
=20
 cannot_fallback () {
 	echo "$1"
-	echo "Cannot fall back to three-way merge."
+	gettext "Cannot fall back to three-way merge."; echo
 	exit 1
 }
=20
@@ -645,7 +645,7 @@ do
=20
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		echo "Patch does not have a valid e-mail address."
+		gettext "Patch does not have a valid e-mail address."; echo
 		stop_here $this
 	fi
=20
@@ -696,7 +696,7 @@ do
 	    action=3Dagain
 	    while test "$action" =3D again
 	    do
-		echo "Commit Body is:"
+		gettext "Commit Body is:"; echo
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
--=20
1.7.4.4
