From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Change the spelling of "wordregex".
Date: Tue, 20 Jan 2009 22:59:54 -0600
Message-ID: <200901202259.54886.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de> <200901202146.58651.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 06:01:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPVDS-0002Un-7l
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 06:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbZAUFAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 00:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbZAUE76
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 23:59:58 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:50935 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbZAUE75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 23:59:57 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121045955.LBWK18445.eastrmmtao103.cox.net@eastrmimpo02.cox.net>;
          Tue, 20 Jan 2009 23:59:55 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id 64zv1b00A2i4SyG024zwbe; Tue, 20 Jan 2009 23:59:56 -0500
X-Authority-Analysis: v=1.0 c=1 a=93yWaWhXTo8A:10 a=8oSRSpTRIyUA:10
 a=Fq1VQ0LPAAAA:8 a=XCv70T_l4VPjS-ZWBR4A:9 a=Xy0-HDpaHoSY7ZEZXJQA:7
 a=MZblZ5ROKAFcX93IQzHufyNaawUA:4 a=T3brmoaXcPoA:10 a=uocofYhV6bsA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPVBz-000L41-0O; Tue, 20 Jan 2009 22:59:55 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <200901202146.58651.bss@iguanasuicide.net>
X-Eric-Conspiracy: There is no conspiracy
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106567>

Use "wordRegex" for configuration variable names.  Use "word_regex" for C
language tokens.

Signed-off-by: Boyd Stephen Smith Jr. <bss@iguanasuicide.net>
---
On Tuesday 20 January 2009, "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> wrote about '[PATCH] 
color-words: Support diff.color-words config option':
>I'm not entirely satisfied with it. [...] I think camelCase is better than
>runtogether so I'd prefer to change "wordregex" -> "wordRegex" across
>the entire patch set.

Here's a patch that does something like that, that can be squashed into the
previous patch.

 Documentation/config.txt        |    2 +-
 Documentation/gitattributes.txt |    4 ++--
 t/t4034-diff-words.sh           |    8 ++++----
 userdiff.c                      |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0ca983a..332213e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -639,7 +639,7 @@ diff.suppress-blank-empty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
-diff.wordregex::
+diff.wordRegex::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
 	sequences that match the regular expression are "words", all other
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index ba3ba12..227934f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -341,14 +341,14 @@ Customizing word diff
 
 You can customize the rules that `git diff --color-words` uses to
 split words in a line, by specifying an appropriate regular expression
-in the "diff.*.wordregex" configuration variable.  For example, in TeX
+in the "diff.*.wordRegex" configuration variable.  For example, in TeX
 a backslash followed by a sequence of letters forms a command, but
 several such commands can be run together without intervening
 whitespace.  To separate them, use a regular expression such as
 
 ------------------------
 [diff "tex"]
-	wordregex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
+	wordRegex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
 ------------------------
 
 A built-in pattern is provided for all languages listed in the
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6bcc153..4508eff 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -86,7 +86,7 @@ test_expect_success 'word diff with a regular expression' '
 '
 
 test_expect_success 'set a diff driver' '
-	git config diff.testdriver.wordregex "[^[:space:]]" &&
+	git config diff.testdriver.wordRegex "[^[:space:]]" &&
 	cat <<EOF > .gitattributes
 pre diff=testdriver
 post diff=testdriver
@@ -121,8 +121,8 @@ test_expect_success 'use regex supplied by driver' '
 
 '
 
-test_expect_success 'set diff.wordregex option' '
-	git config diff.wordregex "[[:alnum:]]+"
+test_expect_success 'set diff.wordRegex option' '
+	git config diff.wordRegex "[[:alnum:]]+"
 '
 
 cp expect.letter-runs-are-words expect
@@ -138,7 +138,7 @@ test_expect_success '.gitattributes override config' '
 '
 
 test_expect_success 'remove diff driver regex' '
-	git config --unset diff.testdriver.wordregex
+	git config --unset diff.testdriver.wordRegex
 '
 
 cat > expect <<\EOF
diff --git a/userdiff.c b/userdiff.c
index 2b55509..d556da9 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -6,8 +6,8 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
 
-#define PATTERNS(name, pattern, wordregex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED }, wordregex }
+#define PATTERNS(name, pattern, word_regex)			\
+	{ name, NULL, -1, { pattern, REG_EXTENDED }, word_regex }
 static struct userdiff_driver builtin_drivers[] = {
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
-- 
1.5.6.5
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
