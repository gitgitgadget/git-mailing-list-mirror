From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/5] Makefile: Remove Gettext files on make clean
Date: Sat, 29 May 2010 22:45:23 +0000
Message-ID: <1275173125-21010-4-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 00:46:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIUnK-0006Bn-PG
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921Ab0E2Wp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 18:45:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64345 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814Ab0E2Wpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 18:45:52 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1533818fxm.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gii3WqovTQfow1UiSbQ3Hehxm6Ts35VrNJEpUlH0FiU=;
        b=uOMXQmRBcgvppPB1H1xNjnAzFl58usmEuDBMIoSEgEQ9tKcK0TUhp2QagfKfFCJPaP
         BNw+s8kUadNcFAqm9unCRSp8sOeWzG3Xo4kMzL6fj/83aVbM83f2p6t5Q9p742bJrsrF
         0no0qStG3sgDlwXSRixsP9bhoiGI5Xiz57APQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hePrdcssnCCEoeMW0mk4AiclvqlfKe4YUrOrL8jFg2Tutbwi5LY5MuLciTnJhOozlw
         zepATqAt4V8q1jdWyLq0Wcs/PV+TuOO6ZOpkp57P1EwOcpy02Rt4LYPGqa7joxoyv896
         4GdHT68EK3pneAz4nQawEYYSnHjLDAvLKjhDg=
Received: by 10.223.92.152 with SMTP id r24mr2799607fam.74.1275173151598;
        Sat, 29 May 2010 15:45:51 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm24351890faj.17.2010.05.29.15.45.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 15:45:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.ge2b63.dirty
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147975>

Remove the automatically generated po/git.pot and share/
files. They're created by the gettext installation process.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7989121..4de0627 100644
--- a/Makefile
+++ b/Makefile
@@ -2153,6 +2153,10 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+ifndef NO_GETTEXT
+	$(RM) po/git.pot
+	$(RM) -r share/
+endif
=20
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
--=20
1.7.1.242.ge2b63.dirty
