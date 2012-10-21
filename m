From: Tom Jones <tom@oxix.org>
Subject: [PATCH] Add -S, --gpg-sign option to manpage of "git commit"
Date: Sun, 21 Oct 2012 20:46:37 +0100
Message-ID: <20121023225101.189E57D4C@ralph.oxix.org>
References: <7vbofvfup7.fsf@alter.siamese.dyndns.org>
Cc: tom@oxix.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 00:52:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnKZ-0002T4-L9
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934038Ab2JWWwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:52:03 -0400
Received: from [81.187.158.195] ([81.187.158.195]:39883 "EHLO ralph.oxix.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933995Ab2JWWv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:51:59 -0400
Received: by ralph.oxix.org (Postfix, from userid 1000)
	id 189E57D4C; Tue, 23 Oct 2012 23:51:01 +0100 (BST)
In-Reply-To: <7vbofvfup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208270>

git commit -S, --gpg-sign was mentioned in the program's help message,
but not in the manpage.

This adds an equivalent entry for the option in the manpage.

Signed-off-by: Tom Jones <tom@oxix.org>
---
On Sun, Oct 21, 2012 at 01:15:16PM -0700, Junio C Hamano wrote:
> Are you sure about this?  The order [...]

Good point.  Please find a revised patch, with the newly documented
option before the optional double dashes, below.

> Sign off?

Now added, too.

 Documentation/git-commit.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9594ac8..4b78bd0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
-	   [-i | -o] [--] [<file>...]
+	   [-i | -o] [-S[keyid]] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -276,6 +276,10 @@ configuration variable documented in linkgit:git-config[1].
 	commit message template when using an editor to prepare the
 	default commit message.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commit.
+
 \--::
 	Do not interpret any more arguments as options.
 
-- 
1.7.2.5
