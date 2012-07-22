From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Sun, 22 Jul 2012 09:26:04 +0800
Message-ID: <cover.1342920089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:27:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sskx9-0000lI-MD
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab2GVB0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:26:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2GVB0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:26:37 -0400
Received: by pbbrp8 with SMTP id rp8so8575153pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gX+Tm/bvmicaFbH5Gb4RetifN80/rATLQAxF0zuNbrc=;
        b=Axvz2g0ONu0xSk480za/Lf5rB+/zMBhLqDw6hsdTciVx/I90wJ60fE1Wna2vsRDP2c
         yFGJyn/qIM+Q8oWm7GtQTvsg83MSbAgH8OLlfOk6RHK/iiNLdmfV1KaatnYz+AKONLZl
         UUYFT6V/sAExGN+pGtPaepxnaPL46UlMXN70uVWnEi3q4hzJ7hAW83HKlnRcBGIgcYGo
         fTJd/RPpygGLrSCA6SyMA/SR3xZhDlKCtQ86eWW3DUhVyxShNRSkuwyLenIbJmF1r8Ci
         ot0poi7nRbJzzMi7f0NQ6Ks7d+GRnIYhROYEJt/G8mDheWwhV8D0WPXeVz8bC5mCIXTM
         Of6Q==
Received: by 10.68.196.228 with SMTP id ip4mr24590545pbc.82.1342920397229;
        Sat, 21 Jul 2012 18:26:37 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id rg10sm6946850pbc.54.2012.07.21.18.26.31
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 18:26:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201833>

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
