From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 0/3] Update HTTPD/daemon tests for new push.default
Date: Tue, 15 Jan 2013 21:05:05 -0500
Message-ID: <cover.1358301792.git.brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:13:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIUv-0003eP-Vn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964Ab3APCMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:12:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55694 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab3APCMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:12:31 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 21:12:31 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E9E38117005B; Wed, 16 Jan 2013 02:06:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id 0D2E2117005B;
	Wed, 16 Jan 2013 02:06:06 +0000 (UTC)
X-Mailer: git-send-email 1.8.1.rc1.222.gec797b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213707>

I saw a string of these commits already, but found a few more when running
the test suite.

Brian Gernhardt (3):
  t5550: do not assume the "matching" push is the default
  t5551: do not assume the "matching" push is the default
  t5570: do not assume the "matching" push is the default

 t/t5550-http-fetch.sh | 1 +
 t/t5551-http-fetch.sh | 1 +
 t/t5570-git-daemon.sh | 1 +
 3 files changed, 3 insertions(+)

-- 
1.8.1.rc1.222.gec797b3
