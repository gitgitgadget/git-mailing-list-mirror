From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Git.pm: two minor typo fixes
Date: Wed, 18 Feb 2015 23:32:20 +0600
Message-ID: <1424280740-19525-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:32:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO8UK-0003fD-EK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbBRRcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 12:32:36 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45243 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbbBRRcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 12:32:35 -0500
Received: by lbjb6 with SMTP id b6so2576985lbj.12
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mq/ALdZqIzdbB+zn9EhP65CF0QjaMtDJbajjUu0XrrQ=;
        b=SyoeDKdSWJhqEJMvBD4itKB6Z3DfYXWgGwQIPS0GrudlkuA91BYQODEmqSshbDh9Fy
         VQalh0LnKjP1+NZ8T/+AcxZbIGMlB+ioKHyfWjVHEfKh0+YLazneWFmURQniKpsheGk8
         TKDxcdn0Q+JkR/+nwYGPv0X49xZV28SudWItvU0ZIjOeshBWxuy+d2K3gYIRt4uhjtTz
         gaoOx1WML05a7vz7u/KWFKzcS9H28/yfFjq4hSk/0wC/6LHLyGh2ZsQ4mdSE9elkCyt5
         dFDCtetjaZJ2QF9IsxLdttYjkUVEcheyHA8/Ffc3aFiAvrSDFgpbqOq1CnbBmokAzdW5
         TdLQ==
X-Received: by 10.152.5.193 with SMTP id u1mr415530lau.96.1424280754472;
        Wed, 18 Feb 2015 09:32:34 -0800 (PST)
Received: from localhost.localdomain ([5.76.34.68])
        by mx.google.com with ESMTPSA id xu8sm2588534lab.21.2015.02.18.09.32.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Feb 2015 09:32:33 -0800 (PST)
X-Mailer: git-send-email 2.3.0.80.g18d0fec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264033>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 perl/Git.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index b5905ee..9026a7b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -695,7 +695,7 @@ Retrieve the integer configuration C<VARIABLE>. The return value
 is simple decimal number.  An optional value suffix of 'k', 'm',
 or 'g' in the config file will cause the value to be multiplied
 by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
-It would return C<undef> if configuration variable is not defined,
+It would return C<undef> if configuration variable is not defined.
 
 =cut
 
@@ -704,7 +704,7 @@ sub config_int {
 }
 
 # Common subroutine to implement bulk of what the config* family of methods
-# do. This curently wraps command('config') so it is not so fast.
+# do. This currently wraps command('config') so it is not so fast.
 sub _config_common {
 	my ($opts) = shift @_;
 	my ($self, $var) = _maybe_self(@_);
-- 
2.3.0.80.g18d0fec
