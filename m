From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 0/7] i18n for git-am, git-rebase and git-merge
Date: Sat, 21 Jul 2012 23:50:49 +0800
Message-ID: <cover.1342884458.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssbyo-0005LB-9d
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab2GUPvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:51:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2GUPvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:51:46 -0400
Received: by pbbrp8 with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gX+Tm/bvmicaFbH5Gb4RetifN80/rATLQAxF0zuNbrc=;
        b=XyOh9oqAu9OYkuHwp4fx0fbnAHDO1EG0zaCfYIOH+dUkMo93LwsvBD5SY7Cmc60gOA
         U9fWol6hBh88JwLP9xyuIRa1y+cyf0h32JQLk63Rjp9lp1whwqRV5S6Snx41+zZl++WV
         Dm9q+B/ONQd+pS1Am+cbuGkv2KhZ+CVqwZJN7OyOnqpMy8zBxhJ+lb2jaNwOv8tzT3Zw
         NHRTlDWeL7fwp281nURbs3y9N92lQeiIxcJE5SsVm4T3pp3RGHPMb2JuGVYhtkwKaCIg
         cVopclUDKUa4uXzo51fIorIl01e7do0bVfA5X0pSU8D31L+m+jkMAfzyHFwNhcWF0RSV
         Ij8A==
Received: by 10.66.88.68 with SMTP id be4mr19281560pab.23.1342885906379;
        Sat, 21 Jul 2012 08:51:46 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.51.40
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:51:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201813>

Mark strings in git-am, git-rebase, and git-merge for translation.
And contain fixes for shell gettext extraction and xgettext workaround.

Jiang Xin (7):
  i18n: New keywords for xgettext extraction from sh
  i18n: rebase: mark strings for translation
  i18n: Rewrite gettext messages start with dash
  Remove obsolete LONG_USAGE which breaks xgettext
  i18n: am: mark more strings for translation
  Remove unused and bad gettext block from git-am
  i18n: merge-recursive: mark strings for translation

 Makefile                      |   3 +-
 git-am.sh                     |  14 ++--
 git-rebase.sh                 |  83 +++++++++--------------
 git-submodule.sh              |   2 +-
 merge-recursive.c             | 152 ++++++++++++++++++++++--------------------
 t/t3404-rebase-interactive.sh |   2 +-
 6 files changed, 120 insertions(+), 136 deletions(-)

-- 
1.7.11.2.259.g37fc0e1
