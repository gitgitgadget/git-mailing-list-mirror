From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 0/7] i18n for git-am, git-rebase and git-merge
Date: Wed, 25 Jul 2012 16:34:05 +0800
Message-ID: <cover.1343205009.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx3P-0002LB-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775Ab2GYIel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 04:34:41 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56034 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab2GYIei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:34:38 -0400
Received: by ghrr11 with SMTP id r11so445314ghr.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=z5v1HtX06nG6DyNod6oIeLEXkqhXHWmWgRu0na17QoE=;
        b=Bv/GNac0of11n+LftSWePN9nD0v8rQSJ4XA2FVdmiXm2F/A+MWog/nzGQ9fHKIJOwz
         15qBXsxwd8GqSgOPbrtQ5+u/jJb5hlTmnWu/zxCKHsAXwINv9jjWpOzv0P2KTeYX4Znp
         AZnfAlcsST0a/0Qj73au+JZEgv99w1+m9LCVmDvCm3mo0OsaWzPWVvdED7RPWy+yYEYR
         WEgDv7f0FkgVpOWOcCN5m1u+An7k5AhC248EO1vmoqrNrGICKkXQNs8n8VucdlvsZtB3
         jAcZddg3eAYc/W+LDzzJedFnax4ypykkbMgeI1DsCJ1vb19jdmPdAikWA5wbz95D9Lam
         UIwA==
Received: by 10.66.75.74 with SMTP id a10mr11069681paw.46.1343205277982;
        Wed, 25 Jul 2012 01:34:37 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.34.30
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202135>

Marked messages for translation in git-am, git-rebase, and git-merge.
Also fixed suffered tests when turning GETTEXT_POISON switch on.

Jiang Xin (7):
  i18n: New keywords for xgettext extraction from sh
  i18n: rebase: mark messages for translation
  i18n: Rewrite gettext messages start with dash
  Remove obsolete LONG_USAGE which breaks xgettext
  i18n: am: mark more strings for translation
  Remove dead code which contains bad gettext block
  i18n: merge-recursive: mark strings for translation

 Makefile                             |   3 +-
 git-am.sh                            |  20 ++---
 git-rebase.sh                        |  89 ++++++++-------------
 git-submodule.sh                     |   2 +-
 merge-recursive.c                    | 148 +++++++++++++++++++----------------
 t/t0201-gettext-fallbacks.sh         |   8 +-
 t/t3400-rebase.sh                    |   8 +-
 t/t3404-rebase-interactive.sh        |   2 +-
 t/t3406-rebase-message.sh            |   9 ++-
 t/t6022-merge-rename.sh              |  16 ++--
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 11 files changed, 150 insertions(+), 157 deletions(-)

-- 
1.7.12.rc0.16.gf4916ac
