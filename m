From: jidanni@jidanni.org
Subject: Re: [PATCH] Documentation/diff-options.txt: unify options
Date: Mon, 29 Dec 2008 15:03:17 +0800
Message-ID: <8763l331l6.fsf@jidanni.org>
References: <7vvdt4aj0e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 08:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHCBD-00044b-SV
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 08:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYL2HDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 02:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYL2HDX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 02:03:23 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:35450 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753767AbYL2HDW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 02:03:22 -0500
Received: from jidanni.org (122-127-43-85.dynamic.hinet.net [122.127.43.85])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id E35AEC595D;
	Sun, 28 Dec 2008 23:03:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104075>

(You were right about my previous patch being bad.
At least git-am gives an error message when fed
http://article.gmane.org/gmane.comp.version-control.git/104017/raw
git-apply however does nothing and returns 0! Must be a bug.)
OK, here's a better patch:

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/diff-options.txt |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c62b45c..b432d25 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -19,16 +19,12 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 -p::
+-u::
 	Generate patch (see section on generating patches).
 	{git-diff? This is the default.}
 endif::git-format-patch[]
 
--u::
-	Synonym for "-p".
-
 -U<n>::
-	Shorthand for "--unified=<n>".
-
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
 	the usual three. Implies "-p".
@@ -190,31 +186,25 @@ endif::git-format-patch[]
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
 
+-a::
 --text::
 	Treat all files as text.
 
--a::
-	Shorthand for "--text".
-
 --ignore-space-at-eol::
 	Ignore changes in whitespace at EOL.
 
+-b::
 --ignore-space-change::
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
 
--b::
-	Shorthand for "--ignore-space-change".
-
+-w::
 --ignore-all-space::
 	Ignore whitespace when comparing lines.  This ignores
 	differences even if one line has whitespace where the other
 	line has none.
 
--w::
-	Shorthand for "--ignore-all-space".
-
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
-- 
1.5.6.5
