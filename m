From: William Morgan <wmorgan-git@masanjin.net>
Subject: [PATCH] additional help when editing during interactive rebase
Date: Tue, 08 Jan 2008 18:32:17 -0800
Message-ID: <1199845915-sup-797@south>
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 03:33:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCQko-0003Jl-CX
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 03:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbYAICcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 21:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYAICcv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 21:32:51 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:62858 "EHLO
	nlpi015.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYAICcu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 21:32:50 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi015.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m092WmhA024233
	for <git@vger.kernel.org>; Tue, 8 Jan 2008 20:32:49 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JCQjp-0006gA-B5
	for git@vger.kernel.org; Tue, 08 Jan 2008 18:32:17 -0800
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69944>

I personally would have found this message useful the first time I used
git rebase --interactive. YMMV.

Signed-off-by: William Morgan <wmorgan-git@masanjin.net>
---
 git-rebase--interactive.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acdcc54..d53d283 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -263,6 +263,10 @@ do_next () {
 		warn
 		warn "	git commit --amend"
 		warn
+		warn "Once amended, continue with"
+		warn
+		warn "	git rebase --continue"
+		warn
 		exit 0
 		;;
 	squash|s)
-- 
1.5.4.rc2.68.ge708a-dirty


-- 
William <wmorgan-git@masanjin.net>
