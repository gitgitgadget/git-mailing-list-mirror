From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: daemon.c broken on OpenBSD
Date: 25 Oct 2005 16:40:59 -0700
Message-ID: <86k6g1jhbo.fsf@blue.stonehenge.com>
References: <867jc336f4.fsf@blue.stonehenge.com>
	<7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
	<86vezljhve.fsf@blue.stonehenge.com>
	<86r7a9jhq4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 01:42:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYPf-0005HR-43
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVJYXlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVJYXlA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:41:00 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:27653 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932484AbVJYXk7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:40:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7E8418F91C;
	Tue, 25 Oct 2005 16:40:59 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03926-01-13; Tue, 25 Oct 2005 16:40:59 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1F37F8F95C; Tue, 25 Oct 2005 16:40:59 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.6; tzolkin = 3 Cimi; haab = 4 Zac
In-Reply-To: <86r7a9jhq4.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10637>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> Actually, you probably want this instead:

And this one too, because .gitignore is missing some files:

>From nobody Mon Sep 17 00:00:00 2001
Subject: [PATCH] fix .gitignore to add new progs
From: Charlie <root@blue.stonehenge.com>
Date: 1130283408 -0700

---

 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: eba31d473719d9a1f2d00b40b3011460d7af864c
c0964c0160d7b08c0b5dd28d1b9462fd2b01bd50
diff --git a/.gitignore b/.gitignore
index 52cb9e2..758aaf6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -54,6 +54,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-mktag
+git-mv
 git-octopus
 git-pack-objects
 git-parse-remote
@@ -78,6 +79,7 @@ git-revert
 git-send-email
 git-send-pack
 git-sh-setup
+git-shell
 git-shortlog
 git-show-branch
 git-show-index
---
0.99.8.GIT


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
