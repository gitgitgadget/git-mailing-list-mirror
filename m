From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 1/6] Disable IPv6 support for Haiku
Date: Sun, 17 Aug 2008 10:56:56 +0200
Message-ID: <7CCFCB0B-382F-4A94-B8A7-796156A73CEF@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 10:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe5b-0005Wl-QP
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 10:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbYHQI5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 04:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYHQI5K
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 04:57:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35035 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYHQI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:57:07 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8D542EB47787;
	Sun, 17 Aug 2008 10:57:05 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe4P-0003YQ-00; Sun, 17 Aug 2008 10:57:05 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/rGHXKJTz83Q8WVetbniYrflygXIiDWmsme3tu
	mcyAykAEfaqYGv6hBiQOGnz0TJc3X4f1c0NuBuZeiO/WfzHBWf
	6FRZEHmFv6YM0Ha8zt2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92583>

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
Acked-by: Ingo Weinhold <ingo_weinhold@gmx.de>
Acked-by: Scott McCreary <scottmc2@gmail.com>
---
  Makefile |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..b22dbcf 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,9 @@ ifeq ($(uname_S),HP-UX)
  	NO_HSTRERROR = YesPlease
  	NO_SYS_SELECT_H = YesPlease
  endif
+ifeq ($(uname_S),Haiku)
+	NO_IPV6 = YesPlease
+endif
  ifneq (,$(findstring MINGW,$(uname_S)))
  	NO_MMAP = YesPlease
  	NO_PREAD = YesPlease
-- 
1.6.0.rc3.32.g8aaa
