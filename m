From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix dependencies of parse-options test program
Date: Tue, 13 Nov 2007 23:46:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132345310.4362@racer.site>
References: <20071113231636.GJ3268@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5T5-0005I3-WE
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbXKMXqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbXKMXqk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:46:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:42248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754558AbXKMXqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:46:39 -0500
Received: (qmail invoked by alias); 13 Nov 2007 23:46:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp057) with SMTP; 14 Nov 2007 00:46:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+kGt5oJg+TORTO0P7DJyaIXTsbNtFtGsUG6ZUwI
	Lpfd9x5WjtDgSe
X-X-Sender: gene099@racer.site
In-Reply-To: <20071113231636.GJ3268@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64909>

Hi,

apparently I forgot to send this patch, which I thought was only relevant 
in the builtin-commit branch of mine:

-- snipsnap --
[PATCH] Makefile: add correct dependencies for test-parse-options

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bda8762..2abb8da 100644
--- a/Makefile
+++ b/Makefile
@@ -996,6 +996,10 @@ test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
 
+test-parse-options$X: parse-options.o
+
+test-parse-options.o: parse-options.h
+
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
-- 
1.5.3.5.1769.gc3bdd
