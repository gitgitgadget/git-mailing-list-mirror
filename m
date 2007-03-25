From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig 0.6
Date: Sun, 25 Mar 2007 14:51:33 +0200
Message-ID: <20070325125133.GA11453@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 15:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVSYb-0005Wi-FB
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 15:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXCYNOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXCYNOc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 09:14:32 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:45089 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXCYNOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 09:14:30 -0400
X-Greylist: delayed 1373 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Mar 2007 09:14:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 2EB85868054;
	Sun, 25 Mar 2007 14:51:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmNWW+vPSsYR; Sun, 25 Mar 2007 14:51:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B10B0778006;
	Sun, 25 Mar 2007 14:51:33 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 035C06DF835; Sun, 25 Mar 2007 14:51:10 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9B48262A13; Sun, 25 Mar 2007 14:51:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43055>

Hello,

    tig version 0.6 is now available. The release mainly
consists of various accumulated bug fixes and a merge of the
still experimental rev-graph branch. The latter means that
revision graphs "visualization" is now disabled by default.
Add

	set show-rev-graph = yes

to your ~/.tigrc to enable it always.

     A special thanks goes out to Miciah for reporting many
of the bugs that has been fixed. Also thanks to those who
have sent patches.


Grab the tarball at http://jonas.nitro.dk/tig/releases/
or pull it from git://repo.or.cz/tig.git


Following is a slightly trimmed shortlog:

Alexey Tourbin (1):
      Increase commit.title size from 75 to 128

Horst H. von Brand (1):
      Fix parameter warning for iconv(3)

Jonas Fonseca (35 was 44):
      Refactor stuff into draw_rev_graph
      Remove fprintf stuff
      Refactor graph drawing
      Now it actually starts looking like something
      Add graph_parent_is_merge
      Simplify the update_rev_graph end-game
      Move stuff to reset_rev_graph and rename it to done_rev_graph
      Move rev graph code to own section
      Use 'graph' instead of 'stack' in the rev graph code
      Improve comments
      draw_rev_graph: refactor stuff to get_rev_graph_symbol
      More graph_parent_is_merge usage
      Refactor (separator, line) chtype management to use 'fillers'
      Always draw the space between end of rev graph and start of commit title
      append_to_rev_graph: use local variable
      Allow view readers to 'finalize' by calling with NULL line before closing
      update_rev_graph: move code to prepare_rev_graph
      Make the rev graph visualization have a one rev look-ahead
      push_rev_graph: iterate all graph revs when looking for duplicates
      add_keybinding: always allocate the new keybinding
      Hardwire ERR to mean REQ_NONE in the main loop
      main_read: handle titles that start with whitespace
      Cast second arg to iconv to remove warning
      Never split the tree view when opening another tree view
      Fix commit author line parsing for when the name is empty
      Discard error messages from git-describe
      Fix SITES URLs; promote git://repo.or.cz/tig.git mirror more
      Add note about using autoconf to detect iconv(3) presence in libc
      Drop --stat usage from the main command assembled during option parsing
      Make tig handle GIT_DIR better
      TODO: use autoconf to detect newer git and git-config availability
      Improve handling of remotes
      Disable show-rev-graph by default
      Oops, remove -liconv from LDFLAGS
      Bump the version number to 0.6


-- 
Jonas Fonseca
