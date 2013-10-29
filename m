From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 7/7] Documentation/gitk: document -L option
Date: Tue, 29 Oct 2013 08:20:40 +0100
Message-ID: <a84be3909ad7aed43f937f7547e7f238d6ee67ea.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cB-0006Ma-KC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab3J2HVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:12 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56280 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab3J2HVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1CF114D6581;
	Tue, 29 Oct 2013 08:21:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l9SEYwHwZD_5; Tue, 29 Oct 2013 08:21:07 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3B8B64D6580;
	Tue, 29 Oct 2013 08:21:05 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236899>

The -L option is the same as for git-log, so the entire block is just
copied from git-log.txt.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/gitk.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d44e14c..0f1c7f8 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -98,6 +98,18 @@ linkgit:git-rev-list[1] for a complete list.
 	(See "History simplification" in linkgit:git-log[1] for a more
 	detailed explanation.)
 
+-L<start>,<end>:<file>::
+-L:<regex>:<file>::
+
+	Trace the evolution of the line range given by "<start>,<end>"
+	(or the funcname regex <regex>) within the <file>.  You may
+	not give any pathspec limiters.  This is currently limited to
+	a walk starting from a single revision, i.e., you may only
+	give zero or one positive revision arguments.
+	You can specify this option more than once.
++
+include::line-range-format.txt[]
+
 <revision range>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.8.4.2.838.ga9a3e20
