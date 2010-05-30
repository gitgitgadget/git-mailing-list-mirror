From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 3/6] Makefile: Remove Gettext files on make clean
Date: Sun, 30 May 2010 20:54:14 +0000
Message-ID: <1275252857-21593-4-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 22:55:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIpXP-0007nM-H6
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab0E3Uyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 16:54:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36908 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741Ab0E3Uyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:54:49 -0400
Received: by fxm10 with SMTP id 10so1964086fxm.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LqreLxnWyX+HtSORkPH5oU3tl+toy0wjW1c0HAwvgJc=;
        b=M0z2XY+pK3+KaHVdO9Fg9smTQ6HjssW9dUDaJEpMG5WjCXoK2Ivq6O4jqTgv2Aqg66
         RDIi54CI5eprWFUWvyEi6yjn0WRAD2pwzi3L8utdmBmE7aio+3YAPds34kvGhPGsPrge
         qiX+bBUdd0As8LJ5IWBAF+hl2U89chh31efps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TXEQ4qWawtUKJIMiTdYGxKCWy5V+XYGphURyIiAgC1IjltP6mbEl762s4NNQk5B3En
         M/CMrfRBgKgtEpMA33SvSKe35Uo7RGLZOZF1w0edIWIUJ8PwXoRQ48W+V7BhuR4/Sp1x
         J9mweTPlu9GryUT6nKezY4YQ30bdw1NNgJyxM=
Received: by 10.223.45.83 with SMTP id d19mr4310025faf.65.1275252887635;
        Sun, 30 May 2010 13:54:47 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm33459492fah.8.2010.05.30.13.54.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.gde05d
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148022>

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
1.7.1.248.gcd6d1
