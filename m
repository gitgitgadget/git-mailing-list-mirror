From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: document --append (amend really!)
Date: Wed, 05 Apr 2006 12:55:32 -0700
Message-ID: <7vacaz23wr.fsf@assigned-by-dhcp.cox.net>
References: <20060405191608.GA20572@fiberbit.xs4all.nl>
	<7vfykr24wi.fsf@assigned-by-dhcp.cox.net>
	<20060405194607.GB20854@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 21:55:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRE6L-0007hZ-K0
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWDETze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 15:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWDETze
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 15:55:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17338 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932081AbWDETzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 15:55:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405195533.JWVB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 15:55:33 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060405194607.GB20854@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Wed, 5 Apr 2006 21:46:07 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18451>

Marco Roeland <marco.roeland@xs4all.nl> writes:

> Here with asciidoc 7.1.2 (Debian 'sid') it looks good in the generated
> man page. But I'll investigate if nobody beats me to it.

Please see below for an example.

> Oops. Well I suppose I could use "git commit --amend" and then run "git
> format-patch" again I suppose. ;-)

Yup ;-).

diff-tree b0d08a504bee17dfc46f761e166ff2c20c59a91a (from 3103cf9e1e09b0045a60542f24a2a1e4ed7b1237)
Author: Francis Daly <francis@daoine.org>
Date:   Wed Mar 22 09:53:57 2006 +0000

    Format tweaks for asciidoc.
    
    Some documentation "options" were followed by independent preformatted
    paragraphs. Now they are associated plain text paragraphs. The
    difference is clear in the generated html.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fbd2394..d55456a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,13 +24,13 @@ OPTIONS
 
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
-
-	The following are the specific `git-ls-files` options
-	that may be given: `-o`, `--cached`, `--deleted`, `--others`,
-	`--killed`, `--ignored`, `--modified`, `--exclude=*`,
-	`--exclude-from=*`, and `--exclude-per-directory=*`.
-
-	All other options will be passed to `grep`.
++
+The following are the specific `git-ls-files` options
+that may be given: `-o`, `--cached`, `--deleted`, `--others`,
+`--killed`, `--ignored`, `--modified`, `--exclude=\*`,
+`--exclude-from=\*`, and `--exclude-per-directory=\*`.
++
+All other options will be passed to `grep`.
 
 <pattern>::
 	The pattern to look for.  The first non option is taken
