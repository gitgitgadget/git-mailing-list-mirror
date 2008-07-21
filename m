From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 21 Jul 2008 00:09:08 -0700
Message-ID: <7vod4rvhm3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 09:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpXD-0008Oh-2z
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYGUHJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbYGUHJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:09:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYGUHJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:09:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5AB1335A6C;
	Mon, 21 Jul 2008 03:09:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 46B9135A6B; Mon, 21 Jul 2008 03:09:10 -0400 (EDT)
X-maint-at: 2d9c572578c72bd6691e80a9feed7d631baf007f
X-master-at: 93310a40eb022a0e36e7c618921931d8ffc31fd1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECC038E6-56F3-11DD-AA51-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89312>

As announced in a separate message, the tip of master was tagged as
1.6.0-rc0; for people who neglected futureproofing themselves so far, it
would really be a good time to seriously consider doing so.

* The 'maint' branch has these fixes since the last announcement.

Jonathan Nieder (1):
  fix usage string for git grep

Junio C Hamano (1):
  refresh-index: fix bitmask assignment


* The 'master' branch has these since the last announcement
  in addition to the above.

Avery Pennarun (1):
  Reword "your branch has diverged..." lines to reduce line length

Dmitry Potapov (1):
  git-svn: fix git svn info to work without arguments

Junio C Hamano (8):
  rerere.autoupdate: change the message when autoupdate is in effect
  builtin-add.c: restructure the code for maintainability
  git-add --all: add all files
  git-add --all: tests
  git-add --all: documentation
  Link shell with compat layer functions
  Move read_in_full() and write_in_full() to wrapper.c
  "needs update" considered harmful

Lars Noschinski (1):
  cvsserver: Add testsuite for packed refs

Michele Ballabio (2):
  builtin-merge.c: Fix option parsing
  builtin-push.c: Cleanup - use OPT_BIT() and remove some variables

Miklos Vajna (1):
  Teach 'git merge' that some merge strategies no longer exist

Nanako Shiraishi (1):
  git am --abort
