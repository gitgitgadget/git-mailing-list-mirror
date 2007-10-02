From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 01 Oct 2007 22:52:54 -0700
Message-ID: <7v4phanjux.fsf@gitster.siamese.dyndns.org>
References: <7v3axsch0d.fsf@gitster.siamese.dyndns.org>
	<7v3axhd0lr.fsf@gitster.siamese.dyndns.org>
	<7vhclhyyxw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 07:53:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icagt-0005PL-JZ
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 07:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXJBFxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 01:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXJBFxA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 01:53:00 -0400
Received: from rune.pobox.com ([208.210.124.79]:38942 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbXJBFw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 01:52:59 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3DF52140003;
	Tue,  2 Oct 2007 01:53:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 93ED713FFD2;
	Tue,  2 Oct 2007 01:53:18 -0400 (EDT)
X-maint-at: 5946d4ba8970f00bb62b2c9e8714264831034043
X-master-at: 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
In-Reply-To: <7vhclhyyxw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 26 Sep 2007 13:05:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59659>

There are a few usability fixes to 'maint' after 1.5.3.3 but
nothing worth doing 1.5.3.4 for yet.

On the 'master' front, handful topics that have been cooking in
'next' have been merged, to be part of 1.5.4.  Notable are:

 * "git-remote rm"
 * "git-send-email --smtp-server-port"
 * "git-svn" futureproofing.

There are many changes cooking in 'next' that will graduate to
'master' real soon now.  It would probably be a good idea to
slow down and cut 1.5.4 early without aiming to have anything
with huge user visible changes once that happens, because there
are two rather big topics mostly about the implementation and
not about user experience (other than performance gain of fetch
in a repository with insane number of refs).

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.3.3

Andy Parkins (1):
  post-receive-hook: Remove the From field from the generated email
      header so that the pusher's name is used

Jari Aalto (1):
  git-remote: exit with non-zero status after detecting errors.

Jean-Luc Herren (2):
  git-add--interactive: Allow Ctrl-D to exit
  git-add--interactive: Improve behavior on bogus input

Johannes Schindelin (1):
  rebase -i: squash should retain the authorship of the _first_
      commit

Junio C Hamano (1):
  Whip post 1.5.3.3 maintenance series into shape.

Miklos Vajna (1):
  git stash: document apply's --index switch


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexandre Julliard (4):
  git.el: Preserve file marks when doing a full refresh.
  git.el: Do not print a status message on every git command.
  git.el: Update a file status in the git buffer upon save.
  git.el: Reset the permission flags when changing a file state.

Daniel Barkalow (1):
  Fix adding a submodule with a remote url

James Bowes (2):
  remote: add 'rm' subcommand
  remote: document the 'rm' subcommand

Jari Aalto (1):
  git-remote: exit with non-zero status after detecting error in
      "rm".

Jeff King (1):
  diffcore-rename: cache file deltas

Johannes Schindelin (1):
  rebase -i: support single-letter abbreviations for the actions

Junio C Hamano (3):
  git-remote rm: add tests and minor fix-ups
  send-email --smtp-server-port: allow overriding the default port
  Update stale documentation link in the k.org site

Mark Levedahl (1):
  git-submodule - allow a relative path as the subproject url

Sam Vilain (3):
  git-svn: fix test for trunk svn (commit message not needed)
  git-svn: fix test for trunk svn (transaction out of date)
  git-svn: handle changed svn command-line syntax

Stefan Sperling (1):
  Fix pool handling in git-svnimport to avoid memory leaks.
