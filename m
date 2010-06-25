From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Documentation: grep: fix asciidoc problem with --
Date: Fri, 25 Jun 2010 04:16:24 +0200
Message-ID: <20100625021625.12918.85714.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 04:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORyVq-0006LH-21
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 04:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0FYCTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 22:19:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50635 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab0FYCTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 22:19:10 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A9397818042;
	Fri, 25 Jun 2010 04:19:03 +0200 (CEST)
X-git-sha1: 9cdbab1d4fc1b9adaf427fbe743978f097556b34 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149663>

Asciidoc interprets two dashes separated by spaces as a single big
dash. So let's escape the first dash, so that "\--" will properly
appear as "--".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-grep.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d89ec32..5474dd7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -191,7 +191,7 @@ OPTIONS
 Examples
 --------
 
-git grep 'time_t' -- '*.[ch]'::
+git grep 'time_t' \-- '*.[ch]'::
 	Looks for `time_t` in all tracked .c and .h files in the working
 	directory and its subdirectories.
 
-- 
1.7.1.642.gc3eb1
