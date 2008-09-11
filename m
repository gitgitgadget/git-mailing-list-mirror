From: Eric Raible <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 20:50:27 +0000 (UTC)
Message-ID: <loom.20080911T204256-821@post.gmane.org>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>  <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>  <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com> <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 22:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdt8i-0002Bt-U2
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYIKUuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYIKUuh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:50:37 -0400
Received: from main.gmane.org ([80.91.229.2]:39007 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYIKUug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:50:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kdt7a-0007x4-RS
	for git@vger.kernel.org; Thu, 11 Sep 2008 20:50:34 +0000
Received: from adsl-75-24-208-45.dsl.pltn13.sbcglobal.net ([75.24.208.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 20:50:34 +0000
Received: from raible by adsl-75-24-208-45.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 20:50:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.208.45 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.29 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95644>

Elijah Newren <newren <at> gmail.com> writes:

> Anyway, Eric wasn't really talking about ignoring files, since he was
> explicitly adding them for the next commit.  It's just that at some
> point he changed his mind and decided he didn't want to include any of
> the changes he had already made in the next commit, but was surprised
> when git reset --hard deleted the files from both the index and
> working copy instead of just the index.  git reset --hard really is
> meant for throwing away unwanted stuff (particularly including in the
> working directory), but I can see how he may have expected behavior
> more along the lines of git rm --cached for those particular files.  I
> don't agree with that viewpoint (I see files as tracked as soon as you
> stage it, not once you commit it), but I can see where the expectation
> comes from.
> 
> Just my thoughts,
> Elijah

Yes, you have a 100% correct understand of what I'm trying to say.
But can you see a downside to "git reset --hard" treating newly
added files as "git reset"?

Wiping out existing files (with no realistic recovery) is a bit harsh,
isn't it?  Especially when AFAICS there's no downside to leaving the
untracked files as they were before they were "git add"-ed.

- Eric
