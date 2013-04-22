From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/7] Documentation/shortlog improvements
Date: Mon, 22 Apr 2013 11:00:24 +0530
Message-ID: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9Kr-0005aT-CD
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab3DVFag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:36 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:34376 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3DVFag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:36 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so2885521daj.22
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=1jP9+qnjnNpDPZaAzn2Uh8PmLpz8hkGZpeS17UmuN2U=;
        b=b3HVx81Z7LMEAoJIK8GVPEO5TBkmXZfkd/YutCpbpGdOh4+0Ni15CzqYrl9FMboY8J
         x+j8X+Si488APYd9cKy9fiZK4YrSmwveITl3WG3+3kg6BrzZda8u72+O+v/x3x8x5rb0
         DNINTn8Gzyp9NVd1ZSAt7DagFa6UQ1ESf1sVtiba/jQgzg7XDes77eMAxzfd9joun+D+
         8V7mdkN20V5gx74CgpOoaIuN+MhxC2Du3/5O9/DlvtTSkUkpwdgdQcK1PO9QWDh6bF1l
         7OF4jEHOWsNqPZvWtFlm6+dcs4Dq1Trzvy8qmZS11LFk8UrdUg8NQ0K3PPtrlAcNiXXN
         3+Mw==
X-Received: by 10.68.16.164 with SMTP id h4mr30677380pbd.122.1366608635782;
        Sun, 21 Apr 2013 22:30:35 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221988>

Hi,

The re-roll was necessary due to minor/silly mistakes in v2, as
pointed out by Junio.

The builtin/shortlog.c patch has moved to the end until we change
'<since>..<until>' to '<revision range>' everywhere else.  We use
'<revision range>' here too.

[4/7] has been replaced with the version Junio fixed up and put in
`pu`.

[6/7] has been updated to copy sections from log.txt properly, and
omit the "see below for History Simplification" part.

Thanks.

Ramkumar Ramachandra (7):
  git-shortlog.txt: remove (-h|--help) from OPTIONS
  revisions.txt: clarify the .. and ... syntax
  git-log.txt: order OPTIONS properly; move <since>..<until>
  git-log.txt: generalize <since>..<until>
  git-log.txt: rewrite note on why "--" may be required
  git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
  builtin/shortlog.c: make usage string consistent with log

 Documentation/git-log.txt      | 22 ++++++++++++----------
 Documentation/git-shortlog.txt | 23 +++++++++++++++++------
 Documentation/revisions.txt    |  6 ++++--
 builtin/shortlog.c             |  4 +---
 4 files changed, 34 insertions(+), 21 deletions(-)

-- 
1.8.2.1.501.gd2949c7
