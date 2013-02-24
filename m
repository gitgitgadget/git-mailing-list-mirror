From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 14/16] contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:22 -0800
Message-ID: <1361667024-49776-15-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
 <1361667024-49776-10-git-send-email-davvid@gmail.com>
 <1361667024-49776-11-git-send-email-davvid@gmail.com>
 <1361667024-49776-12-git-send-email-davvid@gmail.com>
 <1361667024-49776-13-git-send-email-davvid@gmail.com>
 <1361667024-49776-14-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoX-0008WV-LH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473Ab3BXAvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:11 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41924 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759444Ab3BXAvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:51:10 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1129893pad.11
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H1f29F/kEJBHrsixcKoVBiwevw3aXi2usUk3nLN35gM=;
        b=GvStD6hb8g88DJqQoBcoLLy68Austr+AK6RjCVv1crSm8OdqbjNgrbsOOYqRvFqlCg
         SYXjZnMScLrmjDVmDLLHGaA3c9gywFB42X8uGKAwjIxJny0X+hrqPIpO5p10BQ5m7H96
         YImqGOVh4HKka3cguSodZ49IODh3G67hfKBMKpXw+wsZ0NMlQv4xDNWM5jR7eZHy1dlx
         VWdG/3UeQLMBlKAyH24HHgHNuGPbJ3tB7P6AZjh2IJZDwyaCdx8IF5IFsBdVjc8yaq92
         iVqOz2AgmEImcVohNIRAB2706Nw4HqogwWY3gZfVE00UFA1MCuex8Jkx7fMFOzD8bRhC
         Ff6A==
X-Received: by 10.68.189.71 with SMTP id gg7mr10859989pbc.15.1361667069999;
        Sat, 23 Feb 2013 16:51:09 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.51.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:51:08 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-14-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216974>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.8.2.rc0.263.g20d9441
