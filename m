From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Sun, 24 Apr 2016 20:20:28 +0000
Message-ID: <1461529229-15222-2-git-send-email-avarab@gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:20:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQWG-00077j-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbcDXUUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 16:20:37 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35175 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbcDXUUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 16:20:36 -0400
Received: by mail-wm0-f47.google.com with SMTP id e201so66326244wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9Q+B2YgDEW+YPr+tzSF31jJNaO4q5cNcmsCzVHGf+w=;
        b=SXaeTPPXS1hmbyFws6UB2FLHKb05/khafv5yWdwYm2DOtLHrCSVW0mbaEHxb8a+gl+
         ZssmHB5qISCc/KTE11MOzlSc/wFMClR7IR9dB+xsqi+58JULFeFy9Vgrl+H9K1l/vN98
         tPHEYHcS9WCAUUmMCayCuRp/TxG+LTIfFQsDIBStvmjOEfuRA4N85qxLjiL2QNBEMHkD
         F+EfqG30jQo9dkD8Ylj9/jJYQ7Q7Kl9OugVprvOLnDUMp9+zy4aOY02kMzOzZmbFULnN
         YjuaefZ2r9AMBm4jMQtR5p6Udc4XJpPJiphQhDEOyQj+4ymyknLO8TBXoTwqn+NHbiBY
         h0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9Q+B2YgDEW+YPr+tzSF31jJNaO4q5cNcmsCzVHGf+w=;
        b=euA6eE1RPbPBap3jeXCRJpXY+2FXiK+Ayj6WSiCyyzUvSSHMXoN5XjS8YmY4Ap7E5N
         mlr4VEw77MZCLO1PbLuaqaPX8Ft31mta/F4kEUkSl4AAWE1YGOwpg+qOHOCrODkh55BH
         HqCI/ItcItYqoGQW+XBLDopIsi+0OmcifKLnMO7HDVzRtQZtA1CMnQ4ThlsxD7NuPbfa
         zHjJGdIbLQPNMQYkWZ42XweSOtkkkJ8wiea4EbqAijAyqNAVvUVVsMa86MWcWcSJnhuo
         GQi89P5uRqFRmCVf7ZAPyeQB/elZWFlQ9/hXDe2aJ3IUlyOKzmBng/fwzVQxpIGNscQi
         vnog==
X-Gm-Message-State: AOPr4FX8oD720r5y5/lfwaMvxohiRm8tJa1psqZPlpLJwZC0u6+PPd9iuUVuUiPwhgg5Cg==
X-Received: by 10.194.61.40 with SMTP id m8mr30518064wjr.106.1461529235370;
        Sun, 24 Apr 2016 13:20:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m20sm15233040wma.23.2016.04.24.13.20.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Apr 2016 13:20:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292438>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just built their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 2f3caf7..e9d169e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,9 +275,13 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+Another use for this hook to implement access control which is finer
+grained than the one based on filesystem group. Note that if the user
+pushing has a normal login shell on the machine receiving the push
+implementing access control like this can be trivially bypassed by
+just using not executing the hook. In those cases consider using
+e.g. linkgit:git-shell[1] as the login shell to restrict the user's
+access.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
