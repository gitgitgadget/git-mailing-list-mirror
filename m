From: Petr Baudis <pasky@ucw.cz>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 16:52:56 +0200
Message-ID: <20050628145256.GA1275@pasky.ji.cz>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org> <7vekamvmxj.fsf@assigned-by-dhcp.cox.net> <20050628110625.GC21533@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 16:47:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHLv-0004Ki-4W
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 16:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVF1OxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVF1OxS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 10:53:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20639 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261968AbVF1Ow7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 10:52:59 -0400
Received: (qmail 2087 invoked by uid 2001); 28 Jun 2005 14:52:56 -0000
To: Christopher Li <git@chrisli.org>
Content-Disposition: inline
In-Reply-To: <20050628110625.GC21533@64m.dyndns.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jun 28, 2005 at 01:06:25PM CEST, I got a letter
where Christopher Li <git@chrisli.org> told me that...
> On Tue, Jun 28, 2005 at 02:40:56AM -0700, Junio C Hamano wrote:
> > >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> > Still a good space reduction.  Good job!
> > 
> > I am now dreaming if we someday would enhance the mechanism with
> > append-only updates to the *.pack files with complete rewrite of
> > the *.idx files, and get rid of files under .git/objects totally.
> 
> No offense my friend, this has been done. It's name is mercurial.
> 
> > This would make things reasonably friendly to rsync.  The kernel
> > pack has around 60M pack with 1.1M index, so everyday use would
> > involve incremental updates to the pack [*1*] and full download
> > of the index file.
> 
> It still have other open issue. Now it would be harder to not sync
> all the heads. If I just want the clean Linus-2.6 tree, I have to
> dig it out from the pack file which mixing with other heads. 
> 
> You could host different projects with it's own pack file. That
> will lost the space saving on co-hosting projects.
> 
> So I am not convince rsync is the way to go in long run. You need
> to have your own network syncing method.

I think the git-*-pull tools are actually just fine. You will only need
to have some server-side CGI gadget to frontend the file, but we need
that anyway to make the pull reasonably effective.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
