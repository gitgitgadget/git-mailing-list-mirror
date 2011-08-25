From: Boaz Harrosh <bharrosh@panasas.com>
Subject: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Thu, 25 Aug 2011 15:37:03 -0700
Message-ID: <4E56CE8F.8080501@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwiYn-0002YE-3m
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab1HYWht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:37:49 -0400
Received: from natasha.panasas.com ([67.152.220.90]:50255 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab1HYWhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:37:48 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7PMb9vT006398;
	Thu, 25 Aug 2011 18:37:11 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 25 Aug
 2011 18:37:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180133>


The Linux Kernel source tree is certainly a C language repository.
As a maintainer and code reviewer I would like too, for example:
See function names as hunk headers and not goto labels. And all
the other goodies a language specific diff parser gives me.

Add a .gitattributes file to the Linux tree to enable cpp parsing
of the source files.

People are welcome to add other parsers for other type of files
if needed. (Like Makefile or Kconfig ...)

CC: Jeff King <peff@peff.net>
CC: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>
---
 .gitattributes |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..6d2b620
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,2 @@
+*.h diff=cpp
+*.c diff=cpp
-- 
1.7.6
