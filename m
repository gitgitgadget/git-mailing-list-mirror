From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-apply(1): document --unidiff-zero
Date: Sun, 17 Sep 2006 12:55:38 +0200
Message-ID: <20060917105538.GA1497@diku.dk>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org> <7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net> <7vsliq7vqr.fsf_-_@assigned-by-dhcp.cox.net> <eej12j$36t$2@sea.gmane.org> <7vac4y7u8n.fsf@assigned-by-dhcp.cox.net> <eej2s7$97c$2@sea.gmane.org> <7v64fm6cuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 12:56:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOuJd-0004zN-0V
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWIQKzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 06:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWIQKzo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 06:55:44 -0400
Received: from [130.225.96.91] ([130.225.96.91]:60869 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964925AbWIQKzo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 06:55:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id C9493770068;
	Sun, 17 Sep 2006 12:55:40 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13451-05; Sun, 17 Sep 2006 12:55:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2BAF7770065;
	Sun, 17 Sep 2006 12:55:39 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D11636DF84F; Sun, 17 Sep 2006 12:53:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0B00F62A3C; Sun, 17 Sep 2006 12:55:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64fm6cuj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27184>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-apply.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c76cfff..ee136c1 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -95,6 +95,16 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
+--unidiff-zero::
+	By default, gitlink:git-apply[1] expects that the patch being
+	applied is a unified diff with at least one line of context.
+	This provides good safety measures, but breaks down when
+	applying a diff generated with --unified=0. To bypass these
+	checks use '--unidiff-zero'.
++
+Note, for the reasons stated above usage of context-free patches are
+discouraged.
+
 --apply::
 	If you use any of the options marked "Turns off
 	'apply'" above, gitlink:git-apply[1] reads and outputs the
-- 
1.4.2.g39f1

-- 
Jonas Fonseca
