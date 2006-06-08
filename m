From: Junio C Hamano <junkio@cox.net>
Subject: GIT 1.4.0-rc2
Date: Wed, 07 Jun 2006 20:41:24 -0700
Message-ID: <7vfyigb9gb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 05:41:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoBOn-0000wb-Ek
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 05:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWFHDl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 23:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWFHDl0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 23:41:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9965 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932477AbWFHDlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 23:41:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608034125.JWQX5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 23:41:25 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21469>

I've tagged the tip of "master" as v1.4.0-rc2.

Many documentation updates, new and much improved gitk, git
aliases stored in .git/config, and most importantly, http-fetch
fix.

I think we are getting there; expect real 1.4.0 this Saturday my
time.  I am planning to throw in a bit of surprise in it as well.


* Shortlog since 1.4.0-rc1 *

Francis Daly:
      Some doc typo fixes
      config.txt grammar, typo, and asciidoc fixes
      git-cvsserver asciidoc formatting tweaks

Horst H. von Brand:
      Cleanup git-send-email.perl:extract_valid_email

Johannes Schindelin and Petr Baudis:
      git aliases stored in .git/config

Jon Loeliger:
      Refactor git_tcp_connect() functions a little.

Jonas Fonseca:
      Misc doc improvements
      Document git-ls-tree --fullname

Junio C Hamano:
      git alias: try alias last.
      send-email: be more lenient and just catch obvious mistakes.
      send-email: a bit more careful domain regexp.
      git-format-patch: add --output-directory long option again
      HTTP cleanup
      Make index file locking code reusable to others.
      refs.c: convert it to use lockfile interface.
      ref-log: style fixes.
      Documentation: add missing docs make check-docs found.
      make clean: remove dist-doc targets.
      Documentation: git-ls-tree (typofix)
      Documentation: add another example to git-ls-files

Nick Hengeveld:
      HTTP cleanup
      http-fetch: fix possible segfault

Paul Mackerras:
      gitk: Make a row of controls for controlling highlighting
      gitk: Highlight entries in the file list as well
      gitk: Highlight paths of interest in tree view as well
      gitk: First cut at a search function in the patch/file display window
      gitk: Improve the text window search function
      gitk: Move "pickaxe" find function to highlight facility
      gitk: Fix bug in highlight stuff when no line is selected
      gitk: Provide ability to highlight based on relationship to selected commit
      gitk: Add a goto next/previous highlighted commit function
      gitk: Show nearby tags
      gitk: Show branch name(s) as well, if "show nearby tags" is enabled
      gitk: Re-read the descendent/ancestor tag & head info on update

Petr Baudis:
      Document git aliases support
      Documentation: git aliases

Rene Scharfe:
      Off-by-one error in get_path_prefix(), found by Valgrind

Robert Fitzsimons:
      builtin-grep: pass ignore case option to external grep
