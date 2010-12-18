From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/8] fsck docs: remove outdated and useless diagnostic
Date: Sat, 18 Dec 2010 00:38:38 -0500
Message-ID: <1292650725-21149-2-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVu-0006oi-Vd
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab0LRFjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab0LRFjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:01 -0500
Received: by qwa26 with SMTP id 26so1366776qwa.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s0uIltqjCsqcw8judVjaiP5yf4U/8LvkIaAP+XZSzFI=;
        b=S6q7PG8noN2B/uq6bDhxVKMp6YLqJMK0ffGCtR+Reic1Yfd06j4NDmAEycEdit5J0G
         O2YHwotroTymDdJbblFNfcKdexug4Ld0VKIxvut3Bzqe10avoxshkMemQV1HR1xySfeL
         XXVQWsUjasynu9cdeRCPMjTMrdQoBRHhfVdv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kjGGyXqpTOUVTTmNV9/29ZFj+gIP/x0SZyfrtPPHNskzo4ZCx1VSG6UVbFYYa/dWvG
         JgjSzLRKrYS8QofS7AfG9S8EC262UBnFI626ORetm4bS6DvOc0Adkt32NSr25V13MxBV
         8jCUUnXnaBDQJmWTi/E63RefsGnXj7kR6cLf8=
Received: by 10.229.187.196 with SMTP id cx4mr1563584qcb.178.1292650741027;
        Fri, 17 Dec 2010 21:39:01 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:00 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163902>

In git-fsck(1), there was a reference to the warning "<tree> has full
pathnames in it".  This exact wording has not been used since 2005
(commit f1f0d0889e55), when the wording was changed slightly.  More
importantly, the description of that warning was useless, and there were
many other similar warning messages which were not document at all.
Since all these warnings are fairly obvious, there is no need for them
to be in the man page.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-fsck.txt |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 3ad48a6..86f9b2b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -123,9 +123,6 @@ dangling <type> <object>::
 	The <type> object <object>, is present in the database but never
 	'directly' used. A dangling commit could be a root node.
 
-warning: git-fsck: tree <tree> has full pathnames in it::
-	And it shouldn't...
-
 sha1 mismatch <object>::
 	The database has an object who's sha1 doesn't match the
 	database value.
-- 
1.7.3.2
