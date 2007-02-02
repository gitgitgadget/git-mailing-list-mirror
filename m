From: Brendan Cully <brendan@kublai.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 09:59:23 -0800
Message-ID: <20070202175923.GA6304@xanadu.kublai.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<200702010058.43431.jnareb@gmail.com>
	<20070201003429.GQ10108@waste.org>
	<200702021055.49428.jnareb@gmail.com>
	<slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
	<epvnln$fmn$1@sea.gmane.org>
	<Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org,
        Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: mercurial-bounces@selenic.com Fri Feb 02 19:10:48 2007
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([66.93.16.53])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD2ro-0000RG-Rn
	for gcvmd-mercurial@gmane.org; Fri, 02 Feb 2007 19:10:33 +0100
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l12HtXFd012058;
	Fri, 2 Feb 2007 11:55:38 -0600
Received: from mail.quuxuum.com (zakopane.cs.ubc.ca [198.162.52.68])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	l12Hl4bt010762
	for <mercurial@selenic.com>; Fri, 2 Feb 2007 11:47:04 -0600
Received: from zakopane.cs.ubc.ca (localhost.localdomain [127.0.0.1])
	by mail.quuxuum.com (Postfix) with ESMTP id 707B05C408
	for <mercurial@selenic.com>; Fri,  2 Feb 2007 09:59:25 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed; d=kublai.com;
	h=received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:x-delivery-agent:from:mail-followup-to;
	q=dns; s=dk; bh=NkuJjpFP3xCIogOlNSkxt1YDHTs=;
	b=fXmtfGy7XqPyWo/XP5AywRQYToXqs4kcyVvK0ygW3Ld1GJLdeGNjWZU05EAhFRsZ13wp2aZNjHt0ekTsBlqUviDwmtiQly74XExLJngfYQtFZQQX0dyeXg/ngJq1Kj7vq6CSqc4lgJYldmwD34CKoPPXp4Jm6IUfQwSGrYqZTqU=
Received: by zakopane.cs.ubc.ca (tmda-sendmail, from uid 103);
	Fri, 02 Feb 2007 09:59:25 -0800 (PST)
Received: from xanadu.kublai.com (xanadu.kublai.com
	[IPv6:2001:5c0:89ec:1:1::2])
	by mail.quuxuum.com (Postfix) with ESMTP id 89C0B5C206;
	Fri,  2 Feb 2007 09:59:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
X-Operating-System: Darwin 8.8.0 Power Macintosh
User-Agent: Mutt/1.5.13 (2007-01-09)
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Mail-Followup-To: torvalds@linux-foundation.org, jnareb@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38521>

On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
> 
> 
> On Fri, 2 Feb 2007, Jakub Narebski wrote:
> > 
> > Gaaah. Why anyone would want to have non-propagated tags?
> 
> That's *definitely* not the mistake.
> 
> I use private tags (and branches, for that matter) all the time. I'd be 
> very upset indeed if all my tags were always pushed out when I push 
> something out.
> 
> The mistake seems to be to think that tags get "versioned", and are part 
> of the tree history. That's insane. It means that you can never have a tag 
> to a newer tree than the one you are on.

The tags you use can simply be those from the tip of the repository,
regardless of which revision you've currently checked out.

> Tags are *independent* of history. They must be. They are "outside" 
> history, since the whole point of tags are to point to history.

Tags have history too. They are added at particular times by
particular people, and sometimes changed (this wouldn't happen in an
ideal world, but it happens). It's a shame not to be able to find this
history.
