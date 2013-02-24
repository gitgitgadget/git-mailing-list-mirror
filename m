From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 14/16] contrib/hooks/setgitperms.perl: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:52 -0800
Message-ID: <1361665254-42866-15-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
 <1361665254-42866-11-git-send-email-davvid@gmail.com>
 <1361665254-42866-12-git-send-email-davvid@gmail.com>
 <1361665254-42866-13-git-send-email-davvid@gmail.com>
 <1361665254-42866-14-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLx-0002It-1s
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759374Ab3BXAVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:33 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39356 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759364Ab3BXAV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:29 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so1127663pab.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=53kHAFJP/4GWFrctR+EPsmjIj0tOPNgo9jFnYT3ij90=;
        b=RCF8Rldo1wvSyIMIf+EreNRV2JLhu41AEonSr/8v0+bIVNKEH2CeDDOatx+jpE6MFT
         6vyYQlDKDLO2x4/nORs9MV2BUmqrT/L5S15YC34qTm7vGcpbfkCGgPQ1q8iNBYs5JdK7
         hAUZuq3txaUaIVUi4MWORXEUfjgIRhb2URTJG9lyhsLFn7mMX4ZKblohhviPK6E8652B
         LGz7VdHKdgwFuqdvVEcDmAleg7J8OiJ4Uyam373+kDbXhV+cADBJPVVcDx08Vk96Gl0U
         hUj+pYG8rSlxFG2Z+ZHJp9AWbJUQ/ApFgcBKDem5snRkGU/LIjllBc7AktqLwbf8qQOr
         1V0Q==
X-Received: by 10.66.86.201 with SMTP id r9mr11877916paz.14.1361665288833;
        Sat, 23 Feb 2013 16:21:28 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:28 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-14-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216948>

Use a lowercase "usage:" string for consistency with Git with Git with Git with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/hooks/setgitperms.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index a577ad0..2770a1b 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -24,7 +24,7 @@ use File::Find;
 use File::Basename;
 
 my $usage =
-"Usage: setgitperms.perl [OPTION]... <--read|--write>
+"usage: setgitperms.perl [OPTION]... <--read|--write>
 This program uses a file `.gitmeta` to store/restore permissions and uid/gid
 info for all files/dirs tracked by git in the repository.
 
-- 
1.8.2.rc0.247.g811e0c0
