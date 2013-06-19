From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 2/2] user-manual: Update download size for Git and the kernel
Date: Tue, 18 Jun 2013 21:55:22 -0400
Message-ID: <deb78c114d068ab3f9e28bcd019c3e29ad7b770c.1371606791.git.wking@tremily.us>
References: <cover.1371606791.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 04:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8ZH-0001L0-26
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091Ab3FSC4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:56:15 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:45678 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933836Ab3FSC4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:56:14 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 22:56:14 EDT
Received: from odin.tremily.us ([unknown] [72.68.80.181])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOM00MKDAP5BFD0@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 18 Jun 2013 20:55:53 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id F25BFA3A71A; Tue,
 18 Jun 2013 21:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371606953; bh=BCxzO6UilcgXSasMM6W5ipIEXbZII71jT61jTf/5SQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=RERTXbetZVYx0EysmOh3ckHUVjhKy05cW53B1Ta8tPfk/L1miHXlSgX8c4eSGjnLH
 Xze6SqcqO/Gzl88s39q665QQvDT3Zb3WLaNCKBHEF7MQW7VD2GDfAjRzFj+hFZOg/L
 IGs+wUkqUP4Fz5M1CHtYEHNpNTsjKnE7YR/aqDII=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371606791.git.wking@tremily.us>
In-reply-to: <cover.1371606791.git.wking@tremily.us>
References: <cover.1371606791.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228331>

From: "W. Trevor King" <wking@tremily.us>

They've grown since d19fbc3 (Documentation: add git user's manual,
2007-01-07) when the stats were initially added.  I've rounded
download sizes up to the nearest power of ten MiB to decrease the
precision and give a bit of growing room.  Exact sizes:

  $ git clone git://git.kernel.org/pub/scm/git/git.git
  Initialized empty Git repository in /tmp/git/.git/
  remote: Counting objects: 156872, done.
  remote: Compressing objects: 100% (40826/40826), done.
  remote: Total 156872 (delta 115322), reused 155492 (delta 114094)
  Receiving objects: 100% (156872/156872), 37.29 MiB | 7.54 MiB/s, done.
  Resolving deltas: 100% (115322/115322), done.

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  Initialized empty Git repository in /tmp/linux/.git/
  remote: Counting objects: 3057404, done.
  remote: Compressing objects: 100% (474769/474769), done.
  Receiving objects: 100% (3057404/3057404), 634.33 MiB | 27.95 MiB/s, done.
  remote: Total 3057404 (delta 2570385), reused 3040910 (delta 2554408)
  Resolving deltas: 100% (2570385/2570385), done.
  Checking out files: 100% (43012/43012), done.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index cd9941a..ffc4e1c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -57,9 +57,9 @@ download a copy of an existing repository.  If you don't already have a
 project in mind, here are some interesting examples:
 
 ------------------------------------------------
-	# Git itself (approx. 10MB download):
+	# Git itself (approx. 40MB download):
 $ git clone git://git.kernel.org/pub/scm/git/git.git
-	# the Linux kernel (approx. 150MB download):
+	# the Linux kernel (approx. 640MB download):
 $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 ------------------------------------------------
 
-- 
1.8.3
