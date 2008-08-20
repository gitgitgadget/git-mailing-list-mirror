From: Petr Baudis <pasky@suse.cz>
Subject: The state and future of the git/mingw** reposiories?
Date: Wed, 20 Aug 2008 13:23:09 +0200
Message-ID: <20080820112309.GH10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: prohaska@zib.de, johannes.schindelin@gmx.de,
	johannes.sixt@telecom.at
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 20 13:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlnX-0004Qt-LZ
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYHTLXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYHTLXP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:23:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50341 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYHTLXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:23:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AEB68393A2E4; Wed, 20 Aug 2008 13:23:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92979>

  Hi,

  I'm currently doing some MSysGit hacking (mostly git-gui-related) and
I'm wondering what should I actually base my work on, considering the
statement of 1.6.0 release notes:

	Source changes needed for porting to MinGW environment are now
	all in the main git.git codebase.

However, git diff junio/master...mingw/master shows quite a few
differences - is there any plan to merge these? If so, do you plan to
maintain the mingw fork indefinitely anyway as a staging area for your
patches that you plan to push upstream, or is it going to be phased out
eventually?

I'm even more confused about the git/mingw/4msysgit.git repository,
though. The branches here seem to be ... *insert 10 minutes of clicking
through dense gitk graphs* ... random mix of git.git and git/mingw.git
merges, but git diff mingw/master...origin/devel turns out to be fairly
minimal - still, some of the changes look quite generic. Again, is there
any upstream merge plan?

What is the branch structure of git/mingw/4msysgit.git? The 'master'
branch still points to 1.5.6, the 'next' branch points to something...
I can't quite pinpoint and the 'devel' branch seems to be 1.6.0 +
mingw/master. Who is supposed to use which one?

Overally, the situation seems to be quite confusing - I would appreciate
a lot if you could clarify the relationship between all the forks and
their branches. It would be great to have this in the project READMEs at
repo.or.cz so that casual visitors get this knowledge. I tried to look
around quite a bit, but could not find any up-to-date description of
this; if I missed it, please point me at the right place.

Thanks,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
