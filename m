From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 0/7] i18n for git-am, git-rebase and git-merge
Date: Wed, 25 Jul 2012 22:53:06 +0800
Message-ID: <cover.1343227806.git.worldhello.net@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 25 16:53:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2y3-0006la-MC
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339Ab2GYOxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:53:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63721 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181Ab2GYOxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:53:31 -0400
Received: by yhmm54 with SMTP id m54so780748yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XR1tVQ8KkThQMvoUZihXjOKFlfkE3pUQSdYVmLUhg2I=;
        b=W5qG7txJb60RzknJRxRkdgZ0q8XdFz8wBh5kPFzBGcL8NX/u304xsTNvtGU12r3kE0
         asuVFq+wyENmZZGA7xfFMia3YBz5eMp4xhfY649/xcLWsbQiuiPr0XVY2esPt/3NpAac
         /S+gkk80M0kp0ypSs67wBw+PTysB4Sa9tZzlYA7+6ldmP+njb0eBm/+uhufVmAUmfDAC
         IJlNlwWxaPvzW7jhhUCt7Yv95svMvd271b+sc66bso3tq+8k/6zl4vVhnmx7/dJzC6lN
         zacgzpU1nB7NmyEucnsHEZttfywEw8ovPG/IWeqyWyulLDd71xcV48MNg92bCebyFoxt
         ENbA==
Received: by 10.68.138.169 with SMTP id qr9mr54100277pbb.27.1343228010219;
        Wed, 25 Jul 2012 07:53:30 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.53.22
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:53:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202158>

[Sorry, bad patch series number, resend again. I'm sleepy.]

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
