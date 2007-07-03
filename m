From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [TIG PATCH] Ignore generated manpages.
Date: Tue, 3 Jul 2007 10:50:25 -0400
Message-ID: <20070703145012.GA11660@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:50:33 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ji2-0004eS-Vb
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXGCOu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbXGCOu2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:50:28 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50401 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbXGCOu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:50:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 627BB1FFC032;
	Tue,  3 Jul 2007 14:50:26 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51502>

Adds tig.1 and tigrc.5 to .gitignore

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 A simple change that will help me from committing man pages by
 accident.  ;-)

 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index f7ab840..9bc5de5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,3 +4,5 @@ manual.toc
 tig
 tig.spec
 tig-*.tar.gz
+tig.1
+tigrc.5
-- 
1.5.3.rc0
