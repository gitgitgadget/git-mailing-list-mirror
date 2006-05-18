From: Matthias Lederhofer <matled@gmx.net>
Subject: git status and empty directories
Date: Thu, 18 May 2006 19:57:35 +0200
Message-ID: <E1Fgmkh-0000ur-Hn@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 18 19:58:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgmkn-0002wK-Nx
	for gcvg-git@gmane.org; Thu, 18 May 2006 19:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWERR5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWERR5i
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 13:57:38 -0400
Received: from moooo.ath.cx ([85.116.203.178]:21988 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932107AbWERR5i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 13:57:38 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20294>

Today I've been working on some source with many empty directories.
git-status shows all empty directories under "Untracked files: (use
"git add" to add to commit)" but adding is impossible. And if it would
be possible to add the directory, because a new file exists in the
directory, it still shows up in the same place, indistinguishable from
the empty directories.

Things I could think of to solve this:
- hide empty directories if the user does not ask explicitly for them
  with a command line option
- vice versa: add a command line option to hide empty directories
(I'd prefer the first one)

Another category in git-status for empty directories which cannot be
added could be interesting too because the comment 'use "git add" to
add to commit' is quite misleading.

Perhaps there should also be another option to show files in untracked
directories.

Any comments? If a patch would be accepted I'll take a look at
writing one. Adding the correct options to git-ls-files seems quite
trivial.
