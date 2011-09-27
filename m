From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] templates/hooks--*: remove sample hooks without any
	functionality
Date: Tue, 27 Sep 2011 11:56:53 +0000
Message-ID: <20110927115653.24283.qmail@bdefd4038bc987.315fe32.mid.smarden.org>
References: <20110926125932.27854.qmail@804c778e7e6607.315fe32.mid.smarden.org> <7vbou742eg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 13:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8WHU-0008KL-De
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 13:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab1I0L44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 07:56:56 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:58773 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752184Ab1I0L4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 07:56:55 -0400
Received: (qmail 24284 invoked by uid 1000); 27 Sep 2011 11:56:53 -0000
Content-Disposition: inline
In-Reply-To: <7vbou742eg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182235>

Remove the sample post-commit and post-receive hooks.  The sample
post-commit doesn't contain any sample functionality and the comments do
not provide more information than already found in the documentation.
The sample post-receive hooks doesn't provide any sample functionality
either and refers in the comments to a contrib hook that might be
installed in different locations on different systems, which isn't that
helpful.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Mon, Sep 26, 2011 at 10:52:23AM -0700, Junio C Hamano wrote:
> I removed the "-" lines above. Looking at the result, I really have to
> wonder if it makes much sense to keep the file here. It is not even an
> example anymore, and the user does not gain anything by enabling it,
> following the suggestion.
>
> Let's instead remove the file altogether, Ok?

Fine with me.  As the same applies to the sample post-commit hook, I
made this patch to remove both of them.

Thanks for your patience, Gerrit.


 templates/hooks--post-commit.sample  |    8 --------
 templates/hooks--post-receive.sample |   15 ---------------
 2 files changed, 0 insertions(+), 23 deletions(-)
 delete mode 100755 templates/hooks--post-commit.sample
 delete mode 100755 templates/hooks--post-receive.sample

diff --git a/templates/hooks--post-commit.sample b/templates/hooks--post-commit.sample
deleted file mode 100755
index 2266821..0000000
--- a/templates/hooks--post-commit.sample
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-#
-# An example hook script that is called after a successful
-# commit is made.
-#
-# To enable this hook, rename this file to "post-commit".
-
-: Nothing
diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
deleted file mode 100755
index 7a83e17..0000000
--- a/templates/hooks--post-receive.sample
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-#
-# An example hook script for the "post-receive" event.
-#
-# The "post-receive" script is run after receive-pack has accepted a pack
-# and the repository has been updated.  It is passed arguments in through
-# stdin in the form
-#  <oldrev> <newrev> <refname>
-# For example:
-#  aa453216d1b3e49e7f6f98441fa56946ddcd6a20 68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
-#
-# see contrib/hooks/ for a sample, or uncomment the next line and
-# rename the file to "post-receive".
-
-#. /usr/share/doc/git-core/contrib/hooks/post-receive-email
-- 
1.7.6.3
