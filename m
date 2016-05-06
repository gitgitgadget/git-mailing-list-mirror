From: Li Peng <lip@dtdream.com>
Subject: [PATCH] Git.pm: fix duplicate words of "return"
Date: Fri,  6 May 2016 20:18:48 +0800
Message-ID: <1462537128-17659-1-git-send-email-lip@dtdream.com>
Cc: aroben@apple.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:19:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayej6-00043i-7g
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbcEFMTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:19:19 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:56432 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757596AbcEFMTT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:19:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.01819944|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mN8DzZ_1462537130;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 06 May 2016 20:18:55 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293768>

Fix duplicate words of "return" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 49eb88a..ce7e4e8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -393,7 +393,7 @@ sub command_close_pipe {
 Execute the given C<COMMAND> in the same way as command_output_pipe()
 does but return both an input pipe filehandle and an output pipe filehandle.
 
-The function will return return C<($pid, $pipe_in, $pipe_out, $ctx)>.
+The function will return C<($pid, $pipe_in, $pipe_out, $ctx)>.
 See C<command_close_bidi_pipe()> for details.
 
 =cut
-- 
1.8.3.1
