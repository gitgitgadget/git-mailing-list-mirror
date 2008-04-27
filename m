From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 26 Apr 2008 23:04:39 -0700
Message-ID: <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 08:05:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq011-0008MX-V8
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYD0GEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYD0GEt
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:04:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYD0GEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:04:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BE7F4D22;
	Sun, 27 Apr 2008 02:04:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E1F704D21; Sun, 27 Apr 2008 02:04:42 -0400 (EDT)
X-maint-at: 1ce89cc4bb18b0e66f7073562d6634f6a9841335
X-master-at: 36c79d2bf893b9957688a6c8c13cc0bf0589e596
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80414>

Post 1.5.5 maintenance track is getting stable and more boring ;-).

* The 'maint' branch has these fixes since v1.5.5.1

Andy Parkins (1):
  post-receive-email: fix accidental removal of a trailing space in
    signature line

Ariel Badichi (2):
  copy.c: copy_fd - correctly report write errors
  archive.c: format_subst - fixed bogus argument to memchr

Brandon Casey (1):
  git-clone.txt: Adjust note to --shared for new pruning behavior of git-gc

Dmitry Potapov (1):
  git-gc --prune is deprecated

Gerrit Pape (1):
  diff-options.txt: document the new "--dirstat" option

Jeff King (5):
  Don't force imap.host to be set when imap.tunnel is set
  t5516: remove ambiguity test (1)
  doc/git-gc: add a note about what is collected
  push: allow unqualified dest refspecs to DWIM
  remote: create fetch config lines with '+'

Junio C Hamano (1):
  write-tree: properly detect failure to write tree objects

Matt Graham (1):
  Linked glossary from cvs-migration page

Matthew Ogilvie (1):
  gitattributes: Fix subdirectory attributes specified from root directory

Michael Weber (1):
  svn-git: Use binmode for reading/writing binary rev maps

Miklos Vajna (1):
  diff options documentation: refer to --diff-filter in --name-status

Sam Vilain (1):
  Amend git-push refspec documentation

Teemu Likonen (1):
  bash: Add completion for git diff --base --ours --theirs

Thomas Guyot-Sionnest (1):
  git-svn bug with blank commits and author file

martin f. krafft (2):
  Escape project name in regexp
  Escape project names before creating pathinfo URLs


* The 'master' branch has these since the last announcement
  in addition to the above.

Clifford Caoile (1):
  git.el: Set process-environment instead of invoking env

Dan McGee (2):
  completion: allow 'git remote' subcommand completion
  completion: remove use of dashed git commands

Heikki Orsila (1):
  Make core.sharedRepository more generic

Jeff King (1):
  git-remote: show all remotes with "git remote show"

Junio C Hamano (5):
  sha1-lookup: more memory efficient search in sorted list of SHA-1
  diff: make --dirstat binary-file safe
  sha1-lookup: make selection of 'middle' less aggressive
  log: teach "terminator" vs "separator" mode to "--pretty=format"
  First batch of post 1.5.5 updates

Matthias Kestenholz (1):
  Use color.ui variable in scripts too

Miklos Vajna (3):
  git-gc --auto: add pre-auto-gc hook
  Documentation/hooks: add pre-auto-gc hook
  contrib/hooks: add an example pre-auto-gc hook

Ping Yin (3):
  git-submodule summary: --for-status option
  builtin-status: submodule summary support
  builtin-status: Add tests for submodule summary

Rafael Garcia-Suarez (1):
  Spelling fixes in the gitweb documentation
