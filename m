From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 05/16] git-archimport: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:43 -0800
Message-ID: <1361665254-42866-6-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PMA-0003Wl-BS
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388Ab3BXAVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:54 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48836 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759325Ab3BXAVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:11 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so1062241pbc.30
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IK6XQu9w5SIuovX6s9KS+zUj2sBj80NVkDAfKjO4oCk=;
        b=gfa0EGMGsLVvw/S8DUcxq1GysEqVgh8PsdAflkmaOGZ2CIQKG5FXp2X1Mljoj6T0/2
         tV+lGSXaJ5DBO1OUTMICy632aHLFbkHfJHiMcdpww/jArXvqmGdnL0tfsPZk99wQ+V+f
         vratnvpEGfhqAh4lx20POE25v3ifPa9VQ3fVv3re90x0vv9zghse91OZGkKPHOMLEx39
         dOJzAp1E6QLv/UMwJi0ZyYz5mMkm7dWvGDsnR72yXC+WOBzojayQIA7Q3JcM0VkTmXDb
         2aWno+xMHnVfXsY3DgkhpiPw5Tm7l/F5YMN5tlislkjja7bW82QzW07fDi0nvj7A8RnZ
         n1DA==
X-Received: by 10.68.2.132 with SMTP id 4mr10528474pbu.221.1361665270944;
        Sat, 23 Feb 2013 16:21:10 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:10 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216950>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-archimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-archimport.perl b/git-archimport.perl
index bc32f18..9cb123a 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -75,7 +75,7 @@ our($opt_h,$opt_f,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
-Usage: git archimport     # fetch/update GIT from Arch
+usage: git archimport     # fetch/update GIT from Arch
        [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ] [ -D depth ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
-- 
1.8.2.rc0.247.g811e0c0
