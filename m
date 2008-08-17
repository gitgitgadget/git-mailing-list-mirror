From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 3/6] Link to libnetwork on Haiku
Date: Sun, 17 Aug 2008 10:57:31 +0200
Message-ID: <DD3BA725-CB8E-4EC6-BBCA-BC2B1836F1B9@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 10:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe5u-0005br-5W
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 10:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYHQI5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 04:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYHQI5d
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 04:57:33 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35343 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYHQI5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:57:32 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id E07B3EB477D6;
	Sun, 17 Aug 2008 10:57:31 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe4p-0003YQ-00; Sun, 17 Aug 2008 10:57:31 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1+5rZxVdEwmXi9JUCwsuYauGPA86R0ic82l0dh3
	PvXWFGXyV5bLoOwjmnNj14vcGoTDXo7QDQl18I2mbzMQGw68c+
	LUxhdOP++xRu5Ov0lEOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92585>

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
Acked-by: Ingo Weinhold <ingo_weinhold@gmx.de>
Acked-by: Scott McCreary <scottmc2@gmail.com>
---
  Makefile |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b22dbcf..5dba2c7 100644
--- a/Makefile
+++ b/Makefile
@@ -730,6 +730,7 @@ ifeq ($(uname_S),HP-UX)
  endif
  ifeq ($(uname_S),Haiku)
  	NO_IPV6 = YesPlease
+	EXTLIBS += -lnetwork
  endif
  ifneq (,$(findstring MINGW,$(uname_S)))
  	NO_MMAP = YesPlease
-- 
1.6.0.rc3.32.g8aaa
