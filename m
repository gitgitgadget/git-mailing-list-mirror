From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 05/12] user-manual: rewrite index discussion
Date: Sat, 15 Sep 2007 22:20:30 -0400
Message-ID: <20070916022030.GB5118@fieldses.org>
References: <11893670592247-git-send-email-bfields@citi.umich.edu> <11893670593767-git-send-email-bfields@citi.umich.edu> <1189367059977-git-send-email-bfields@citi.umich.edu> <11893670591013-git-send-email-bfields@citi.umich.edu> <11893670592312-git-send-email-bfields@citi.umich.edu> <11893670593596-git-send-email-bfields@citi.umich.edu> <7vsl5nh4io.fsf@gitster.siamese.dyndns.org> <20070909222450.GC12147@fieldses.org> <7vbqcbuzgj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 04:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWjkc-0000Cp-5D
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 04:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXIPCUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 22:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbXIPCUk
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 22:20:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42321 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbXIPCUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 22:20:39 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IWjkM-0002hh-Uk; Sat, 15 Sep 2007 22:20:30 -0400
Content-Disposition: inline
In-Reply-To: <7vbqcbuzgj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58292>

On Sun, Sep 09, 2007 at 05:38:20PM -0700, Junio C Hamano wrote:
> At the end of first paragraph as a note would be good.  People
> may scan from top to bottom (maybe "Find...") to look for
> "cache" and find the sentence "this chapter is about index but
> that is what you are looking for".  That feels a natural flow.

OK, I've addressed all the comments I've gotten and pushed an updated
version to:

  git://linux-nfs.org/~bfields/git.git maint

Please pull if it looks ready.

--b.

J. Bruce Fields (12):
      user-manual: adjust section levels in "git internals"
      user-manual: move object format details to hacking-git chapter
      user-manual: rename "git internals" to "git concepts"
      user-manual: create new "low-level git operations" chapter
      user-manual: rewrite index discussion
      user-manual: reorder commit, blob, tree discussion
      user-manual: rewrite object database discussion
      user-manual: move packfile and dangling object discussion
      user-manual: fix introduction to packfiles
      user-manual: todo updates and cleanup
      documentation: replace Discussion section by link to user-manual chapter
      core-tutorial: minor cleanup

 Documentation/Makefile          |    2 +-
 Documentation/core-intro.txt    |  592 --------------------------
 Documentation/core-tutorial.txt |   32 +-
 Documentation/git.txt           |   57 +++-
 Documentation/user-manual.txt   |  868 ++++++++++++++++++++++-----------------
 5 files changed, 548 insertions(+), 1003 deletions(-)
 delete mode 100644 Documentation/core-intro.txt
