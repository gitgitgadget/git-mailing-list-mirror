From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 22:30:02 +0100
Message-ID: <20051112213002.GI30496@pasky.or.cz>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org> <20051112194646.GE30496@pasky.or.cz> <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org> <Pine.LNX.4.64.0511121229340.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 22:30:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb2ww-0008J4-UM
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 22:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVKLVaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVKLVaL
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 16:30:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45470 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964834AbVKLVaJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 16:30:09 -0500
Received: (qmail 18150 invoked by uid 2001); 12 Nov 2005 22:30:02 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511121229340.3263@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11709>

Dear diary, on Sat, Nov 12, 2005 at 09:31:32PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Sat, 12 Nov 2005, Linus Torvalds wrote:
> > 
> > So the fact is: rsync is often slower, and _always_ less capable. 
> 
> Side note: a lot of the rsync problems are non-issues for the initial 
> clone. 

But based on my "machine X" tests, git is as fast as git+ssh (which is
as it should be), which means it is even slightly faster than rsync,
even for the initial commit.

> That initial clone is in fact the only time I think rsync can be a good 
> idea, especially if the server end is repacking regularly.

Yes, the only advantage of rsync I can see is that you get it all
packed. Well, I think this only means we are doing something wrong,
and perhaps we should automatically pack as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
