From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 5/5] Make the ProgramError class printable.
Date: Mon, 12 Sep 2005 23:31:56 +0200
Message-ID: <20050912213156.GG6644@c165.ib.student.liu.se>
References: <20050912212601.GB6644@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 12 23:33:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvuc-0006Qe-7j
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVILVb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVILVb6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:31:58 -0400
Received: from [85.8.31.11] ([85.8.31.11]:7405 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932266AbVILVb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:31:57 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A3A0F4115; Mon, 12 Sep 2005 23:36:57 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEvu8-0001wH-00; Mon, 12 Sep 2005 23:31:56 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050912212601.GB6644@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8436>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 gitMergeCommon.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

30c12b2a8d3df83b15952f786327ccd0c3c04554
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -46,6 +46,9 @@ class ProgramError(Exception):
         self.progStr = progStr
         self.error = error
 
+    def __str__(self):
+        return self.progStr + ': ' + self.error
+
 addDebug('runProgram')
 def runProgram(prog, input=None, returnCode=False, env=None, pipeOutput=True):
     debug('runProgram prog:', str(prog), 'input:', str(input))
