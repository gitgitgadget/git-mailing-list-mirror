From: "Raimund Bauer" <ray007@gmx.net>
Subject: Problem with gitk on cygwin
Date: Thu, 29 Mar 2007 12:21:42 +0200
Message-ID: <000001c771ec$12729c30$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWrlf-0008H1-GJ
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 12:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934240AbXC2KVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 06:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934249AbXC2KVt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 06:21:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934240AbXC2KVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 06:21:48 -0400
Received: (qmail invoked by alias); 29 Mar 2007 10:21:46 -0000
Received: from host-62-245-155-90.customer.m-online.net (EHLO swl011) [62.245.155.90]
  by mail.gmx.net (mp046) with SMTP; 29 Mar 2007 12:21:46 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+jgF8q4dejkL2TRT+ERBZWbojFYp7u4rTCQE3cUZ
	NJnl/b1hpGTeZh
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43426>

When trying to use gitk from current cygwin-install, I get an error-dialog
and no gitk-window.

Error title: "Error in startup script"
Error message:
--------------------------------
.git
    8 [main] git 1620 tty_list::allocate: No tty allocated while executing
"exec git rev-parse --git-dir"
  (procedure "gitdir" line 6)
  invoked from within
"gitdir"
  invoked from within
"set gitdir [gitdir]"
  (file  "/usr/bin/gitk" line 6270)
--------------------------------

Setting the environment variable GIT_DIR produced a slightly different
error, but didn't help.
The new error message is:
--------------------------------
    6 [main] git 1268 tty_list::allocate: No tty allocated while executing
"close $refd"
  (procedure "readrefs" line 47)
  invoked from within
"readrefs"
  (file "/usr/bin/gitk" line 6325)
--------------------------------

Did I forget to install some cygwin package (and it's only a problem of
cygwin dependencies), or does gitk on cygwin have a problem currently?

-- 
best regards

  Ray
