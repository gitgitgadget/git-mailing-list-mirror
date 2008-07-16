From: SungHyun Nam <goweol@gmail.com>
Subject: [PATCH] Use SHELL_PATH
Date: Wed, 16 Jul 2008 10:31:28 +0900
Message-ID: <g5jj21$bsp$1@ger.gmane.org>
Reply-To: namsh@posdata.co.kr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 03:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvt9-0001He-E2
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbYGPBcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbYGPBcB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:32:01 -0400
Received: from main.gmane.org ([80.91.229.2]:39000 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbYGPBcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:32:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KIvs3-0006Di-Us
	for git@vger.kernel.org; Wed, 16 Jul 2008 01:31:56 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 01:31:55 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 01:31:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88625>


Signed-off-by: SungHyun Nam <goweol@gmail.com>
---
  t/Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index a778865..0d65ced 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -26,7 +26,7 @@ clean:
  	$(RM) -r 'trash directory' test-results

  aggregate-results:
-	./aggregate-results.sh test-results/t*-*
+	'$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*

  # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
  full-svn-test:
-- 
1.5.6.3.350.g6c11a
