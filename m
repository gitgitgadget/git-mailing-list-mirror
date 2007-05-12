From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] tiny fix in documentation of git-clone
Date: Sat, 12 May 2007 13:32:34 +0200
Message-ID: <79265012-A444-4EE9-B374-C34A62358829@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 13:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmps7-0007HS-RU
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbXELLen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXELLem
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:34:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:33196 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323AbXELLem (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:34:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4CBWPAW019586
	for <git@vger.kernel.org>; Sat, 12 May 2007 13:34:40 +0200 (CEST)
Received: from [192.168.178.32] (p54BF300F.dip0.t-ipconnect.de [84.191.48.15])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4CBWO5F015302
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 12 May 2007 13:32:24 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47040>

path in example was missing '../'

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
  Documentation/git-clone.txt |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6d32c49..644bf12 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -132,7 +132,7 @@ Make a local clone that borrows from the current  
directory, without checking thi
  +
  ------------
  $ git clone -l -s -n . ../copy
-$ cd copy
+$ cd ../copy
  $ git show-branch
  ------------

-- 
1.5.1.2
