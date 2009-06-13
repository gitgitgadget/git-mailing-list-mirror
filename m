From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: remove warning that "git bisect skip" may slow
	bisection
Date: Sat, 13 Jun 2009 07:22:57 +0200
Message-ID: <20090613052258.4209.23374.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 07:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFLiY-0005BK-AN
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 07:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbZFMFXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 01:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZFMFXl
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 01:23:41 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:48974 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbZFMFXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 01:23:40 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id BCC6C4C8068;
	Sat, 13 Jun 2009 07:23:35 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id AF9234C8032;
	Sat, 13 Jun 2009 07:23:32 +0200 (CEST)
X-git-sha1: b71d97980e3652d5f1e85a3ab924f0b65b060e4c 
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121482>

This warning was probably useless anyway, but it is even more so now
that filtering of skipped commits is done in C and that there is a
mechanism to skip away from broken commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ffc02c7..5d015fc 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -164,9 +164,8 @@ to do it for you by issuing the command:
 $ git bisect skip                 # Current version cannot be tested
 ------------
 
-But computing the commit to test may be slower afterwards and git may
-eventually not be able to tell the first bad commit among a bad commit
-and one or more skipped commits.
+But git may eventually not be able to tell the first bad commit among
+a bad commit and one or more skipped commits.
 
 You can even skip a range of commits, instead of just one commit,
 using the "'<commit1>'..'<commit2>'" notation. For example:
-- 
1.6.3.GIT
