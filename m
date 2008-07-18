From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Remove function stubs in shell.c
Date: Fri, 18 Jul 2008 03:06:37 +0200
Message-ID: <1216343197-20290-1-git-send-email-s-beyer@gmx.net>
References: <20080718005814.GA4155@spearce.org>
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJeRh-0006NH-RY
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769AbYGRBGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbYGRBGn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:06:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:40693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754498AbYGRBGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:06:42 -0400
Received: (qmail invoked by alias); 18 Jul 2008 01:06:41 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 18 Jul 2008 03:06:41 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/ZOWJhtLHZ5aAF1xp59yGE7fkXrKxSuFlz6H1CZ7
	HzJBdTpOk/nQj2
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJeQf-0005He-Bl; Fri, 18 Jul 2008 03:06:37 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <20080718005814.GA4155@spearce.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88945>

These function stubs may be useful, but because they redefine
functions, they provoke a linker error.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Or would you rather like this one? ;)

 shell.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/shell.c b/shell.c
index 91ca7de..b27d01c 100644
--- a/shell.c
+++ b/shell.c
@@ -3,14 +3,6 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
-/* Stubs for functions that make no sense for git-shell. These stubs
- * are provided here to avoid linking in external redundant modules.
- */
-void release_pack_memory(size_t need, int fd){}
-void trace_argv_printf(const char **argv, const char *fmt, ...){}
-void trace_printf(const char *fmt, ...){}
-
-
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
-- 
1.5.6.3.390.g7b30
