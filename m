From: Zenaan Harkness <zen@freedbms.net>
Subject: sane, stable renames; when a commit should commit twice
Date: Sun, 23 Dec 2007 13:03:10 +1100
Message-ID: <20071223020310.GA22450@freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 03:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6GL8-0007rg-5R
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 03:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbXLWCMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 21:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbXLWCMv
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 21:12:51 -0500
Received: from mx06.syd.iprimus.net.au ([210.50.76.235]:46404 "EHLO
	mx06.syd.iprimus.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbXLWCMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 21:12:50 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2007 21:12:50 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGZQbUfKQ0+P/2dsb2JhbACpVA
X-IronPort-AV: E=Sophos;i="4.24,199,1196600400"; 
   d="scan'208";a="85725418"
Received: from unknown (HELO zen700m.freedbms.net) ([202.67.79.143])
  by smtp06.syd.iprimus.net.au with ESMTP; 23 Dec 2007 13:02:48 +1100
Received: by zen700m.freedbms.net (Postfix, from userid 1001)
	id 8B6DF136336; Sun, 23 Dec 2007 13:03:10 +1100 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69159>

When should a commit, commit twice?

When one or more git mv file renames/ moves are involved.

In such a case the commit ought to be split into two. Perhaps move the
files in the first commit, then make the changes needed to support the
move in the build chain (including changes in the moved files) in the
second commit.

This keeps a clean record of the move, making the move, and the
associated changes (as two commits) a clean cherry.

Does this make sense?

I develop in the java world, and we use packages (directories, and
subdirectories, sub-sub... etc) a lot, and so it is not uncommon in my
10 years development, to decide to reorganise some package/dir every now
and then, and files, and whole dirs, get moved.

I've only been using git for a few weeks, but finding it truly awesome!
A little demanding in the initial learning curve - took me three days of
reading and a little experiementation here and there, before I finally
felt comfortable with rebasing, branching, etc, to effect my work
pattern.

Have used arch/tla, a little bzr, aegis for a couple of years long time
ago, some cvs, and bk for four months or so.

I'm hoping that the above workflow, which has just crystallized for me
in the last two days, makes sense.

zen

-- 
Homepage: www.SoulSound.net -- Free Australia: www.UPMART.org
Please respect the confidentiality of this email as sensibly warranted.
