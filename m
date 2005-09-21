From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Wed, 21 Sep 2005 10:50:37 +0200
Message-ID: <20050921085037.GC24902@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz> <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz> <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org> <20050920150719.GB1836@pasky.or.cz> <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>, fonseca@diku.dk,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 10:52:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI0Jf-0001PP-QW
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 10:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIUIul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 04:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVIUIul
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 04:50:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2435 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750760AbVIUIul (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 04:50:41 -0400
Received: (qmail 28808 invoked by uid 2001); 21 Sep 2005 10:50:37 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9032>

Dear diary, on Tue, Sep 20, 2005 at 06:54:57PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Tue, 20 Sep 2005, Petr Baudis wrote:
> > 
> > I'll just drop the date revision specifier support from Cogito. I don't
> > know if any measurable number of people actually use it in the real
> > world anyway.
> 
> I think the date specifier makes sense for cg-log, though. 
> 
> Ie it doesn't make sense as a generic cg-*-id thing, but it _does_ make 
> sense as a totally log-specific case.
> 
> Maybe it could use "-d" instead of "-r", since it's really a totally 
> separate control. For example, there's nothing wrong with
> 
> 	cg-log -d yesterday v2.6.12..

Yes, I agree on that. I added the -d option now and will remove the -r
date functionality soon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
