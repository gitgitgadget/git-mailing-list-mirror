From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH 0/2] Documentation fixes for git-svn.txt
Date: Fri, 22 Apr 2011 19:03:37 +0200
Message-ID: <1303491819-9850-1-git-send-email-valentin.haenel@gmx.de>
Cc: Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDJyi-0004bT-O8
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 19:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab1DVRRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 13:17:07 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:58826 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab1DVRRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 13:17:04 -0400
X-Greylist: delayed 746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Apr 2011 13:17:04 EDT
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3MH4WJT009921;
	Fri, 22 Apr 2011 19:04:32 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3MH4VjD009920;
	Fri, 22 Apr 2011 19:04:31 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171938>

Hi,

the command documentation for 'git svn fetch' lists the following two
options:

  --use-log-author

and

  --add-author-from

However, as the current description of both states, they are also
applicable to 'git svn' subcommands other than fetch. The first patch
moves them, the second patch applies some cosmetics.

My remaining question regarding the second option, '--add-author-from',
is about the subcommands which it is applicable to. The current
documentation states 'commit' and 'dcommit'. My feeling is that 'commit'
is a typo, since 'git svn' does not have a 'commit' subcommand. I had a
look at the code, and while I am not familiar with perl, it seems to me
that the three subcommands that use the option are 'commit-diff',
'set-tree' and 'dcommit'. But this is non-trivial -- feedback is
appreciated.

V-

Valentin Haenel (2):
  git-svn.txt: move option descriptions
  git-svn.txt: small typeface improvements

 Documentation/git-svn.txt |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)
