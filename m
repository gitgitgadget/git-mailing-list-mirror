From: Petr Baudis <pasky@ucw.cz>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 22:30:04 +0200
Message-ID: <20050628203004.GH1275@pasky.ji.cz>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org> <7vekamvmxj.fsf@assigned-by-dhcp.cox.net> <20050628110625.GC21533@64m.dyndns.org> <20050628145256.GA1275@pasky.ji.cz> <20050628163551.GA29410@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Li <git@chrisli.org>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 22:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnMfu-0003VL-5K
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 22:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVF1Uda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVF1UdC
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:33:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34213 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261422AbVF1UaJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 16:30:09 -0400
Received: (qmail 22625 invoked by uid 2001); 28 Jun 2005 20:30:04 -0000
To: Benjamin LaHaise <bcrl@kvack.org>
Content-Disposition: inline
In-Reply-To: <20050628163551.GA29410@kvack.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jun 28, 2005 at 06:35:51PM CEST, I got a letter
where Benjamin LaHaise <bcrl@kvack.org> told me that...
> On Tue, Jun 28, 2005 at 04:52:56PM +0200, Petr Baudis wrote:
> > I think the git-*-pull tools are actually just fine. You will only need
> > to have some server-side CGI gadget to frontend the file, but we need
> > that anyway to make the pull reasonably effective.
> 
> Not really -- the use of rsync for the objects fails horribly on slow 
> links when the project scales in the number of commits.  The rsync 
> protocol has to transfer the names of each file and some information 
> about it, and that information isn't delta compressed.  This is where 
> kernel.org is falling over, as well as what makes the kernel tree very 
> painful to use over a dialup modem link.

Yes. But isn't that what I'm after all saying too? git-*-pull tools
shouldn't have that problem since they have much less overhead and only
pull stuff you need.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
