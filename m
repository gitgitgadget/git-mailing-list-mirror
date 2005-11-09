From: Petr Baudis <pasky@suse.cz>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Wed, 9 Nov 2005 12:20:30 +0100
Message-ID: <20051109112030.GC30496@pasky.or.cz>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <1537CD60-21E4-4F5E-820F-216A4E8C06AC@hawaga.org.uk> <20051109010922.GC5830@reactrix.com> <5C8707EC-3A6F-46B6-8FB1-AAB0842DDDD1@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 12:22:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZo0K-0004C5-9R
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 12:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVKILUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 06:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVKILUe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 06:20:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60546 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751368AbVKILUd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 06:20:33 -0500
Received: (qmail 6404 invoked by uid 2001); 9 Nov 2005 12:20:30 +0100
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <5C8707EC-3A6F-46B6-8FB1-AAB0842DDDD1@hawaga.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11395>

Dear diary, on Wed, Nov 09, 2005 at 10:49:30AM CET, I got a letter
where Ben Clifford <benc@hawaga.org.uk> said that...
> 
> On 9 Nov 2005, at 12:09, Nick Hengeveld wrote:
> >
> >Those curl result codes all look wrong, and sounds like a memory issue
> >that Johannes Schindelin recently fixed in commit
> >90279074ca5cc336a8bfffd47d19d089b291b432.  Does your git build have  
> >that
> >patch?
> 
> I did not - I've pulled and rebuilt from master, and have that commit  
> now.
> It works better (not perfectly (there's a tags 403) but I suspect  
> that may be permissions config at my server end or absence of tags in  
> my repo or something mumble). I can do this a bunch of times in a row  
> with the same results and the resulting cloned repository looks sane.

This likely means that you don't permit directory listing of the tags/
subdir. Since Cogito is just about to cease using it, though, it's up to
you whether you'll go through the trouble of enabling it or waiting for
new Cogito version. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
