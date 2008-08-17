From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 5/6] Link to libbsd for getpass on Haiku
Date: Sun, 17 Aug 2008 10:59:48 +0200
Message-ID: <252CFE86-9234-4170-A04C-166A67A1C537@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 11:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe8R-00063t-K4
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYHQJAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYHQJAB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:00:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59935 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYHQI77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:59:59 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9F815E8FCFEF;
	Sun, 17 Aug 2008 10:59:58 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp06.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe7C-0001NS-00; Sun, 17 Aug 2008 10:59:58 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1+mU5lxhkfC9qrtFY3HOOaFeu5MksbcUsy4Cf0w
	L6Q8Ezk9lt45RwzRPYm4dYMVvvS1JbJ3AaH4GUajnxqarWUabn
	oMiTDZJrplrJL1Bpt2fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92587>

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
Acked-by: Ingo Weinhold <ingo_weinhold@gmx.de>
Acked-by: Scott McCreary <scottmc2@gmail.com>
---
  Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a4d73fc..3daf9ac 100644
--- a/Makefile
+++ b/Makefile
@@ -731,7 +731,7 @@ endif
  ifeq ($(uname_S),Haiku)
  	NO_IPV6 = YesPlease
  	NO_ST_BLOCKS_IN_STAT = YesPlease
-	EXTLIBS += -lnetwork
+	EXTLIBS += -lnetwork -lbsd
  endif
  ifneq (,$(findstring MINGW,$(uname_S)))
  	NO_MMAP = YesPlease
-- 
1.6.0.rc3.32.g8aaa
