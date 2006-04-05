From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix searching for filenames in gitk
Date: Wed, 05 Apr 2006 19:02:50 -0400
Message-ID: <20060405230250.16079.27784.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 01:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRH1h-0003V6-B0
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 01:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDEXC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWDEXC6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 19:02:58 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:41350 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932123AbWDEXC5
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 19:02:57 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FRH1a-0005p9-7L
	for git@vger.kernel.org; Wed, 05 Apr 2006 19:02:54 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FRH1W-0004BS-Gj; Wed, 05 Apr 2006 19:02:50 -0400
To: Paul Mackerras <paulus@samba.org>
User-Agent: StGIT/0.8-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18459>

findcont should not accept any arguments.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 26fa79a..e1848cd 100755
--- a/gitk
+++ b/gitk
@@ -2230,7 +2230,7 @@ proc donefilediff {} {
     }
 }
 
-proc findcont {id} {
+proc findcont {} {
     global findid treediffs parentlist
     global ffileline findstartline finddidsel
     global displayorder numcommits matchinglines findinprogress
