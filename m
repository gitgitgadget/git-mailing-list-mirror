From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/7] i18n for git-am, git-rebase and git-merge
Date: Wed, 25 Jul 2012 11:53:41 +0800
Message-ID: <cover.1343188013.git.worldhello.net@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 25 05:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stsg1-0008PS-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab2GYDyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:54:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38920 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2GYDyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:16 -0400
Received: by yenl2 with SMTP id l2so281957yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=zef+u4TEgds7+1NLFWQhHF0T2FhPg5lQyPNj5MsCPls=;
        b=f9i9ImABvn7natCqE+4nGZwzL8iwgv4WuQ7wjDGjfdC/g59FKr0RO5oNxCYzrkZCiw
         cKQ3/0lth4RTIVO/ysL+NeUcikLfjDxGkx5sGU9pi0Cc/FNReRW8tPx9aGza98Ibh4ZR
         PmAQ8mtIOBRumpjwlDFaeJ/OoekGaj4vcKUolVzYodSJje5ICCp68VnivfLQdp4ngyju
         he+bzUVjU7BClShrHek1Tlt3bhCoJ54j9KkMKzfQee+nFjPCPtXzYJPrtdEiWx6LkWT4
         b8MXCVwTh0A6I9YFZ4unPFMmFKHKFOOAMjL4R8MLY1ht1VbeT1+3SxHboKZjiJo7OfFB
         PRgA==
Received: by 10.66.86.199 with SMTP id r7mr9469992paz.1.1343188455294;
        Tue, 24 Jul 2012 20:54:15 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.11
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202109>

Marked messages for translation in git-am, git-rebase, and git-merge.
Also fixed affected test cases when turn GETTEXT_POISON switch on.

Jiang Xin (7):
  i18n: New keywords for xgettext extraction from sh
  i18n: rebase: mark strings for translation
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
 t/t3406-rebase-message.sh            |   2 +-
 t/t6022-merge-rename.sh              |  16 ++--
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 11 files changed, 143 insertions(+), 157 deletions(-)

-- 
1.7.12.rc0.16.gf4916ac
