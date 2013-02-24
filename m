From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 02/16] git-svn: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:10 -0800
Message-ID: <1361667024-49776-3-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Po2-0006ND-Gi
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759446Ab3BXAuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:40 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36153 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431Ab3BXAui (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:38 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so1118574pad.40
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=x0wPVa8nJs1U4J03tbjCbmHA+NrtljTEJ9wgi2eLpyk=;
        b=d3xclB8UWlhYyWrtySaZ5o9wRPX1ud6JxXdXUBMzi2HHvwxt44x+z047RC59IQgSHp
         c9rGB5HRbHQYLQvA1sXuwNB5Q8XV7GM0GpFoewZz7jlYrTgBV6jmKbuIyc+D4VZNhV9G
         Y5Ep2dU1YdffImzYsnhfto9NrHUiwNOM/ysDWPmshgPpqJjUN2Ol0C/OEkrRIVN3rWrT
         KTImPnRwJGYJn0S680S7c84nwqVtmU0ccQHWG7q2yxRZNA3pVCTZUKtn8KyVMAL1ab5Z
         LnP9upJ90XhiXnC6zVQZSGjTJv3HLPk9AIOaFUxckkQFw9oPRIWXvXpcJntYKFaTuV7n
         KFOw==
X-Received: by 10.68.227.202 with SMTP id sc10mr10645583pbc.109.1361667037765;
        Sat, 23 Feb 2013 16:50:37 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:36 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216960>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.8.2.rc0.263.g20d9441
