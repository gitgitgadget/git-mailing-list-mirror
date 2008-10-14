From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t4018-diff-funcname: add objective-c xfuncname pattern to
 syntax test
Date: Tue, 14 Oct 2008 15:22:10 -0500
Message-ID: <fKvMlOmE4M6iVhkxUGb4iiUasQ0Mc2Y4_WlnfcFS3W4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 22:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpqQo-00079Y-9N
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 22:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYJNUWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYJNUWi
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 16:22:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36138 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbYJNUWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 16:22:37 -0400
Received: by mail.nrlssc.navy.mil id m9EKMB9D004471; Tue, 14 Oct 2008 15:22:11 -0500
X-OriginalArrivalTime: 14 Oct 2008 20:22:10.0710 (UTC) FILETIME=[89875B60:01C92E3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98207>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4018-diff-funcname.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 520e095..0320e19 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex html java pascal php python ruby tex"
+builtin_patterns="bibtex html java objc pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
-- 
1.6.0.2.468.gd5b83
