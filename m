From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] Documentation: fix graph in git-rev-parse.txt
Date: Mon, 26 May 2008 15:24:02 +0200
Message-ID: <200805261524.02355.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 15:21:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0cdO-0001fh-LJ
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 15:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbYEZNUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 09:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYEZNUO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 09:20:14 -0400
Received: from smtp.katamail.com ([62.149.157.154]:34783 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751620AbYEZNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 09:20:13 -0400
Received: (qmail 12861 invoked by uid 89); 26 May 2008 13:18:22 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_60,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO ?80.104.56.173?) (barra?cuda@katamail.com@80.104.56.173)
  by smtp1-pc with SMTP; 26 May 2008 13:18:21 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82931>

Preformatted html and man pages show a mangled graph, caused by a
backslash.

Commit f1ec6b22a8c1ab1cca0f1875f85aea5d2434e5a6 fixed this same issue,
but it seems that new versions of the Asciidoc toolchain changed their
behaviour.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

This should fix the problem, but I can't test it because I have an old
Asciidoc installation (works either way here).

 Documentation/git-rev-parse.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 69599ff..82dab73 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -243,16 +243,18 @@ Here is an illustration, by Jon Loeliger.  Both commit nodes B
 and C are parents of commit node A.  Parent commits are ordered
 left-to-right.
 
+........................................
     G   H   I   J
      \ /     \ /
       D   E   F
-       \  |  / \ 
+       \  |  / \
         \ | /   |
          \|/    |
           B     C
            \   /
             \ /
              A
+........................................
 
     A =      = A^0
     B = A^   = A^1     = A~1
-- 
1.5.5.1
