From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 19 Apr 2008 01:18:52 -0700
Message-ID: <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 18:26:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8Ih-0001fa-4g
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbYDSITO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 04:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYDSITN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:19:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYDSITL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 04:19:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74A3836E5;
	Sat, 19 Apr 2008 04:19:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9155C36E4; Sat, 19 Apr 2008 04:19:06 -0400 (EDT)
X-maint-at: 5634cf24766f8700804ca55f5e8567c88538a5b0
X-master-at: 8876046037a3064f906d2155ea30cb6db186e409
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79903>

As quite some fixes have accumulated on 'maint', I am planning to do
1.5.5.1 this Sunday with what is in 'maint', perhaps with the 'rebase: do
not munge commit log message' fix that is in 'master' tonight.

* The 'maint' branch has these fixes since the last announcement.

Alberto Bertogli (1):
  builtin-apply: Show a more descriptive error on failure when opening a
    patch

Christian Couder (2):
  bisect: squelch "fatal: ref HEAD not a symref" misleading message
  git-bisect: make "start", "good" and "skip" succeed or fail atomically

Jakub Narebski (1):
  gitweb: Fix 'history' view for deleted files with history

Jon Loeliger (1):
  Clarify and fix English in "git-rm" documentation

Jonas Fonseca (1):
  git-remote: reject adding remotes with invalid names

Junio C Hamano (2):
  git-am: minor cleanup
  am: POSIX portability fix

Linus Torvalds (2):
  Ignore leading empty lines while summarizing merges
  git-am: cope better with an empty Subject: line

Mark Levedahl (1):
  git-submodule - possibly use branch name to describe a module

Matthieu Moy (1):
  Document that WebDAV doesn't need git on the server, and works over SSL

Scott Collins (1):
  Clarify documentation of git-cvsserver, particularly in relation to
    git-shell

Shawn Bohrer (2):
  git clean: Don't automatically remove directories when run within
    subdirectory
  git clean: Add test to verify directories aren't removed with a prefix


* The 'master' branch has these since the last announcement
  in addition to the above.

Christian Couder (1):
  bisect: add "git bisect help" subcommand to get a long usage string

Johannes Sixt (1):
  builtin-commit.c: Remove a redundant assignment.

Junio C Hamano (3):
  git_config_bool_or_int()
  Fix git_config_bool_or_int
  rebase: do not munge commit log message

Stephan Beyer (1):
  builtin-apply.c: use git_config_string() to get apply_default_whitespace
