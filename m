From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t5505: add missing &&
Date: Sun, 05 Sep 2010 14:56:11 +0200
Message-ID: <4C83936B.1050609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: bgustavsson@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 14:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsElf-0001ag-2R
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 14:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0IEM4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 08:56:14 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33180 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0IEM4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 08:56:13 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3866416F7B484;
	Sun,  5 Sep 2010 14:56:12 +0200 (CEST)
Received: from [93.246.57.186] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OsElY-0007Kq-00; Sun, 05 Sep 2010 14:56:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19x/9OQFuaNriezzCulOLK+JiKfQxY8SRyIYHLr
	iogDSBiY3EhaZEmrrQeoega6SHMitnx3wRHYSGV8ZfqmEkQOb+
	yrwMnSMzjkDb01BLU7xQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155455>

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I stumbled over this one by accident.


 t/t5505-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4c498b1..5d1c66e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -435,7 +435,7 @@ test_expect_success 'update --prune' '
 	 git branch -m side2 side3) &&
 	(cd test &&
 	 git remote update --prune &&
-	 (cd ../one && git branch -m side3 side2)
+	 (cd ../one && git branch -m side3 side2) &&
 	 git rev-parse refs/remotes/origin/side3 &&
 	 test_must_fail git rev-parse refs/remotes/origin/side2)
 '
-- 
1.7.2.3.569.gb58be.dirty
