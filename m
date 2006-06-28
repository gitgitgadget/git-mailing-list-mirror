From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Fix a mixed declarations and code warning
Date: Wed, 28 Jun 2006 12:15:00 +0300
Message-ID: <20060628121500.3c61b120.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvW8c-0002vX-3V
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423237AbWF1JPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423238AbWF1JPF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:15:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5380 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423237AbWF1JPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:15:04 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3038374ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 02:15:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YKFGmwi143+G2j/rLy2lyOW+ICWdbhC9PpFAykmJ04uFfxHDw3VDICd2r+VNibPeQwTj+NY9zdG5CM7mDyqKOy7vm+VXcq5steu/2fT9MWpCs0TE9qGBubABNm8W14fmaoemO9tDLcrYr0jo05Ob9pqfgroi+SQP0r9k+0OPNWc=
Received: by 10.78.166.7 with SMTP id o7mr152903hue;
        Wed, 28 Jun 2006 02:15:03 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id 37sm2398178hua.2006.06.28.02.15.02;
        Wed, 28 Jun 2006 02:15:02 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22787>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  NOTE: This is for the pu branch

 exec_cmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index f2133ec..62f51fc 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -98,8 +98,8 @@ int execv_git_cmd(const char **argv)
 		argv[0] = git_command;
 
 		if (getenv("GIT_TRACE")) {
-			fputs("trace: exec:", stderr);
 			const char **p = argv;
+			fputs("trace: exec:", stderr);
 			while (*p) {
 				fputc(' ', stderr);
 				sq_quote_print(stderr, *p);
-- 
1.4.1.rc1.g1ef9
