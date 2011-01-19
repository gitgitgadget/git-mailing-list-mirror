From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH] Documentation fixes in git-config
Date: Wed, 19 Jan 2011 15:14:01 +0100
Message-ID: <20110119141401.GE8034@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 15:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfYnY-0005KR-UW
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 15:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab1ASOOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 09:14:04 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37497 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab1ASOOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 09:14:03 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6A12B89994;
	Wed, 19 Jan 2011 15:14:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110119100105.GB8034@fm.suse.cz>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165269>

Variable names must start with an alphabetic character, regexp config key
matching is case sensitive.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
Cc: Jeff King <peff@peff.net>
---
 Documentation/config.txt     |   12 +++++++-----
 Documentation/git-config.txt |    4 +++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..0f23bc7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -12,8 +12,9 @@ The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
-dot. The variable names are case-insensitive and only alphanumeric
-characters are allowed. Some variables may appear multiple times.
+dot. The variable names are case-insensitive, only alphanumeric
+characters and '-' are allowed and must start with an alphabetic character.
+Some variables may appear multiple times.
 
 Syntax
 ~~~~~~
@@ -53,9 +54,10 @@ All the other lines (and the remainder of the line after the section
 header) are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
 is taken as 'name' and the variable is recognized as boolean "true".
-The variable names are case-insensitive and only alphanumeric
-characters and `-` are allowed.  There can be more than one value
-for a given variable; we say then that variable is multivalued.
+The variable names are case-insensitive, only alphanumeric
+characters and `-` are allowed and must start with an alphabetic character.
+There can be more than one value for a given variable; we say then that
+variable is multivalued.
 
 Leading and trailing whitespace in a variable value is discarded.
 Internal whitespace within a variable value is retained verbatim.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 543dd64..6966ed6 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -84,7 +84,9 @@ OPTIONS
 
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression.
-	Also outputs the key names.
+	Regular expression matching is case sensitive in all parts of the key,
+	therefore make sure your pattern matches lower case letters in section
+	and variable names.  Also outputs the key names.
 
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
-- 
1.7.4.rc2.2.gb4f4f
