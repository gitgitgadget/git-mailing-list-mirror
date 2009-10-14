From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git add -e documentation: rephrase note
Date: Thu, 15 Oct 2009 00:26:28 +0200
Message-ID: <20091014222628.GK6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCR0-0003uN-L2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934355AbZJNW1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934347AbZJNW1c
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:27:32 -0400
Received: from virgo.iok.hu ([212.40.97.103]:41645 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934275AbZJNW1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:27:31 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 670F658083;
	Thu, 15 Oct 2009 00:26:54 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 481B444906;
	Thu, 15 Oct 2009 00:26:54 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AD14011F002B; Thu, 15 Oct 2009 00:26:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130345>

The original note probably wanted to suggest "edit the patch with care",
but actually suggested just editing the first characters on certain
lines, which is a pretty bad suggestion.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-add.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45ebf87..daa1add 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -86,9 +86,8 @@ OPTIONS
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
 +
-*NOTE*: Obviously, if you change anything else than the first character
-on lines beginning with a space or a minus, the patch will no longer
-apply.
+*NOTE*: Obviously, if you change the first characters of the lines or
+lines beginning with a space or a minus, the patch will no longer apply.
 
 -u::
 --update::
-- 
1.6.4
