From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/7] i18n for git-am, git-rebase and git-merge
Date: Tue, 24 Jul 2012 14:59:28 +0800
Message-ID: <cover.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6A-0001RP-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab2GXG75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 02:59:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2GXG74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 02:59:56 -0400
Received: by pbbrp8 with SMTP id rp8so12207178pbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HjmmDCG9ASQsEtbdxEal03OSMaoONmG1ctvr6DwiDtM=;
        b=yPRdjETMpbl18s7Z1FmNXD3cA9ijLQ5dJelXlWbvhXkWzgW8e4vxjFySAESwuyGkCO
         dTRWHQ2b1VTTj4Cq4ArzD2YP5y+DCw1f7t0ANgyAhfvejoAKUH9rSB+lZEtmp4OcKWIm
         6BnK592FkuQ0/uS5b1FdGgbnF1NOK5lJj03K1Onix6HMCxpnU0MlWq4h/kHH7aaMECuF
         ebT3HZfMRTEOoVKfdO0xitPisKE8RFUUUom6Fsr71FUXza8Q3eZu00W6OEADmMzSABdW
         ChPZRd4KqPagUvevxtAN+QtsWW54UuAULh8e2vQaCAPokwIYJkjXWiZ7OsAdvIQ3RW95
         mT2g==
Received: by 10.68.224.36 with SMTP id qz4mr41866628pbc.161.1343113195841;
        Mon, 23 Jul 2012 23:59:55 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.23.23.59.49
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 23:59:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202010>

Marked messages for translation in git-am, git-rebase, and git-merge.
Also fixed affected test cases when turn GETTEXT_POISON switch on.

Jiang Xin (7):
  i18n: New keywords for xgettext extraction from sh
  i18n: rebase: mark strings for translation
  i18n: Rewrite gettext messages start with dash
  Remove obsolete LONG_USAGE which breaks xgettext
  i18n: am: mark more strings for translation
  Remove unused and bad gettext block from git-am
  i18n: merge-recursive: mark strings for translation

 Makefile                             |   3 +-
 git-am.sh                            |  14 ++--
 git-rebase.sh                        |  87 ++++++++------------
 git-submodule.sh                     |   2 +-
 merge-recursive.c                    | 148 +++++++++++++++++++----------------
 t/t3400-rebase.sh                    |   8 +-
 t/t3404-rebase-interactive.sh        |   2 +-
 t/t3406-rebase-message.sh            |   2 +-
 t/t6022-merge-rename.sh              |  16 ++--
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 10 files changed, 134 insertions(+), 150 deletions(-)

-- 
1.7.12.rc0.17.gcb766d3
