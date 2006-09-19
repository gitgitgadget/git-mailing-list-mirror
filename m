From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 17:35:36 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191709160.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org> <20060919220604.GE8259@pasky.or.cz>
 <Pine.LNX.4.64.0609191519090.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 01:49:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPpKg-00065G-9R
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWISXsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWISXsv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:48:51 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:2537 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1750849AbWISXsu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 19:48:50 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id 8FDB21E108;
	Tue, 19 Sep 2006 23:35:35 +0000 (UTC)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609191519090.4388@g5.osdl.org>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27316>

On Tue, 19 Sep 2006, Linus Torvalds wrote:
> On Wed, 20 Sep 2006, Petr Baudis wrote:
>> This is actually exactly how SVN revision numbering works. There's just
>> a single number (no '1.') and it indeed jumps randomly if you have
>> several concurrent branches in your (ok, Linus does not have any, just
>> someone's) repository.
>
> Oh, ok, if it's just a single numbering, then that's easy to do. It won't
> _mean_ anything, and you're seriously screwed if you ever merge anything
> else (or use a git that doesn't update the refcache or whatever), but it
> is simple and stable within a single repo.

Well, what it means is "this is the order in which commits were applied to 
this repository".  I suggest that this information is useful for the most 
common development style - the kind which relies on a central repository 
as the canonical source for a project's code.  "gcc-trunk-r117064" means a 
lot more to me than "39282037d7cc39829f1d56bf8307b8e5430d585f", and is no 
less precise.

I do believe that distributed VCSs such as Git can improve the 
productivity of these kinds of projects without forcing the developers to 
suddenly and dramatically alter their workflow.  I think ICNs would help 
make this possible.

  - Joel
