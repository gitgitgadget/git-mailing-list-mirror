From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Get stash to help rebase.autostash
Date: Mon, 13 May 2013 18:15:48 +0530
Message-ID: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs72-0003ip-PI
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3EMMoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:16 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51118 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3EMMoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:16 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so4454292pbc.37
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=v3wTqPxQBGFWeg2+9u5PVZBGKOhhB6zeraJ/cC/s6rM=;
        b=lOKds8aKqgVkKyViO2i8ReRLmZ0p0XPkivWaATBhk+e8aXW4+jATlLk8nsrVgCzLGe
         Pqxys2qSWUsrR+7muSHSpwUVYBQgj0Q+b7i7ntxhZ8owKVH8TJK76NC/ZEgjYBmzqnGT
         wYaRFO0SgF/jIbJjpLwPJUyRc3xdP/tbVKowC0Uba0r/3Zl5yVwgsrz6BiQqb3J43qHc
         2+wuiSXoIuqpHlZZM1UabyAz4kebcTuLXM+98HBeEUKRoEMywH4BhRGtWyUqNV1/dUn5
         PiltA6qxeqFWOMg2JNVGrJOq1Jam3PqVxW3riAyAllHzq9V9zUgccy6cvZ3IC5etS898
         ycnw==
X-Received: by 10.66.48.197 with SMTP id o5mr1240835pan.196.1368449055564;
        Mon, 13 May 2013 05:44:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224125>

Hi,

This topic is based on the rebase.autostash topic.  It cleans up a few
things, introduces 'git stash store', and patches rebase to use it.
Should be simple enough.

Thanks.

Ramkumar Ramachandra (6):
  Documentation/stash: correct synopsis for create
  Documentation/stash: document short form -p in synopsis
  stash: simplify option parser for create
  stash: introduce 'git stash store'
  stash: tweak error message in store_stash ()
  rebase: use 'git stash store' to simplify logic

 Documentation/git-stash.txt | 10 ++++++++--
 git-rebase.sh               |  6 +-----
 git-stash.sh                | 32 +++++++++++++++++++++-----------
 t/t3903-stash.sh            | 20 ++++++++++++++++++++
 4 files changed, 50 insertions(+), 18 deletions(-)

-- 
1.8.3.rc1.57.g4ac1522
