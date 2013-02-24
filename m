From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 02/16] git-svn: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:40 -0800
Message-ID: <1361665254-42866-3-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLV-0000io-5Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759323Ab3BXAVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:08 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44596 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111Ab3BXAVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:05 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1122955pad.25
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8O0O/IUaB4Wj73jXuSQ+9m5CM0OLx2LOXASOAIw1p3c=;
        b=QVknx/X0m+313oqEXdoTDI3M6ZdzjCZp0WKBPN+7EhdXS0zRHMPRJ6lXfVgZFZM/Aw
         WQb0++CCE8aQS+RXcJC1sPTewPNkz09SP3cITagC7bp4FuEv9xNJO8HuIGqbIcmUaVMa
         abZFJV9C7vPzAp/845oyfbOx0iXXjop3daUWNCj7vSIArNqUkbqW6/JFtBOXNg/0CKK6
         nE5o9rkPjpnNzG9v99LGmOSLsIzwqeXrdhWTppQM7rGu8ZRYkpm/2wy/z7Yg9WRPwUcA
         7M/q1zQHbsUaaEGrFGvs8tpSY+wq+eM2HKWUHPRcy1Ix76JxV2Fw6ERg3KttbLDrIV3y
         UJxA==
X-Received: by 10.68.197.202 with SMTP id iw10mr10465709pbc.207.1361665265196;
        Sat, 23 Feb 2013 16:21:05 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:04 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216939>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index b46795f..a93166f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -382,7 +382,7 @@ sub usage {
 	my $fd = $exit ? \*STDERR : \*STDOUT;
 	print $fd <<"";
 git-svn - bidirectional operations between a single Subversion tree and git
-Usage: git svn <command> [options] [arguments]\n
+usage: git svn <command> [options] [arguments]\n
 
 	print $fd "Available commands:\n" unless $cmd;
 
-- 
1.8.2.rc0.247.g811e0c0
