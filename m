From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/apply.c: Fix a "Using plain integer as NULL pointer"
 warning
Date: Sun, 13 May 2012 22:42:36 +0100
Message-ID: <4FB02ACC.80703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 01:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SThnA-0001xd-1S
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 01:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab2EMXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 19:01:28 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:48304 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495Ab2EMXB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 19:01:27 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SThmY-00030O-f2; Sun, 13 May 2012 23:01:26 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197757>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Could you please squash this into commit fe823c5 ("apply: plug the
three-way merge logic in", 09-05-2012) in branch 'jc/apply-3way'.

Thanks!

ATB,
Ramsay Jones

 builtin/apply.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 507c73c..9cf3ce7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3094,7 +3094,7 @@ static int three_way_merge(struct image *image,
 			   const unsigned char *theirs)
 {
 	mmfile_t base_file, our_file, their_file;
-	mmbuffer_t result = { 0 };
+	mmbuffer_t result = { NULL };
 	int status;
 
 	read_mmblob(&base_file, base);
-- 
1.7.10
