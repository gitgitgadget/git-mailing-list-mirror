From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #05; Wed, 20)
Date: Wed, 20 Aug 2008 17:30:22 -0700
Message-ID: <7v4p5fmcpt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 02:31:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVy5V-0002ij-2i
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYHUAaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 20:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYHUAaa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:30:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYHUAa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 20:30:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 939C2541D3;
	Wed, 20 Aug 2008 20:30:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B80AB541CF; Wed, 20 Aug 2008 20:30:24 -0400 (EDT)
X-maint-at: 9b99e641c11044dba661f574f9098d362a3f0ef8
X-master-at: ea3594e04184475226109a21e71c539ff5f139fd
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59B50F80-6F18-11DD-9F60-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93079>

I have to say I've been very productive since 1.6.0 relase and it is _not_
a good thing.  Many minor bugs are discovered by the list regulars, but
they really  should have been found and fixed during the -rc period.
Let's try to do better in this cycle.

Anyway, thanks everybody for finding and fixing bugs and supplying bugfix
patches with test cases.  Perhaps we would need a 1.6.0.1 this weekend.

* The 'maint' branch has these fixes since the last announcement.

Jeff King (2):
  mailinfo: avoid violating strbuf assertion
  decorate: allow const objects to be decorated

Jim Meyering (2):
  git format-patch: avoid underrun when format.headers is empty or all NLs
  remote.c: remove useless if-before-free test

Johannes Sixt (1):
  Install templates with the user and group of the installing personality

Junio C Hamano (5):
  diff --check: do not get confused by new blank lines in the middle
  for-each-ref: cope with tags with incomplete lines
  completion: find out supported merge strategies correctly
  "git-merge": allow fast-forwarding in a stat-dirty tree
  Update draft release notes for 1.6.0.1

Tarmigan Casebolt (1):
  Add hints to revert documentation about other ways to undo changes


* The 'master' branch has these since the last announcement
  in addition to the above.

Brian Downing (2):
  Make xdi_diff_outf interface for running xdiff_outf diffs
  Use strbuf for struct xdiff_emit_state's remainder

Dmitry Potapov (6):
  teach index_fd to work with pipes
  correct argument checking test for git hash-object
  correct usage help string for git-hash-object
  use parse_options() in git hash-object
  add --path option to git hash-object
  add --no-filters option to git hash-object

Jeff King (2):
  run-command: add pre-exec callback
  spawn pager via run_command interface

Jim Meyering (3):
  add boolean diff.suppress-blank-empty config option
  SubmittingPatches: fix a typo
  reword --full-index description

Johannes Schindelin (1):
  checkout --track: make up a sensible branch name if '-b' was omitted

Johannes Sixt (1):
  Revert "Windows: Use a customized struct stat that also has the st_blocks
    member."

Junio C Hamano (4):
  imap-send.c: more style fixes
  xdiff-interface: hide the whole "xdiff_emit_state" business from the
    caller
  compat: introduce on_disk_bytes()
  Update draft release notes for 1.6.1

Pierre Habouzit (1):
  Enable threaded delta search on *BSD and Linux.

Robert Shearman (4):
  git-imap-send: Allow the program to be run from subdirectories of a git
    tree
  git-imap-send: Support SSL
  imap-send.c: style fixes
  Documentation: Improve documentation for git-imap-send(1)
