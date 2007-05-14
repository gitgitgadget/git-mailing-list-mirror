From: Petr Baudis <pasky@suse.cz>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 11:58:57 +0200
Message-ID: <20070514095857.GI4489@pasky.or.cz>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB> <20070514010831.GH4489@pasky.or.cz> <20070514020001.GX14859@MichaelsNB> <20070514023609.GI18276@pasky.or.cz> <20070514085314.GY14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Mon May 14 11:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnXKz-0003yp-9n
	for gcvg-git@gmane.org; Mon, 14 May 2007 11:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbXENJ7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 05:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbXENJ7A
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 05:59:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58831 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583AbXENJ67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 05:58:59 -0400
Received: (qmail 32247 invoked by uid 2001); 14 May 2007 11:58:57 +0200
Content-Disposition: inline
In-Reply-To: <20070514085314.GY14859@MichaelsNB>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47230>

  Hi,

On Mon, May 14, 2007 at 10:53:15AM CEST, Michael Niedermayer wrote:
> On Mon, May 14, 2007 at 04:36:09AM +0200, Petr Baudis wrote:
> > On Mon, May 14, 2007 at 04:00:02AM CEST, Michael Niedermayer wrote:
> > > i agree with you that she will click on 'history' and figure out what it is
> > > but if she wants to see the contents of one of the files then i think
> > > she will be confused and not know where to click,
> > 
> > I think she will just click on the filename - straightforward enough...?
> 
> yes and no :)
> i see 2 possible problems with this
> first if she starts from the summary page (which is from where she would
> start from if she clicked on 'ffmpeg') then she would see the recent 
> history but no directory/file names, she would have to click on 'tree' 
> here

  well, I guess our opinions on how hard it is to guess it through just
differ... :-)

> also file size and last modified dates would be interresting on the tree
> page
> viewvc displays on its equivalent page, time since last change
> svn revission of the last change, the author/commiter of the last change
> and the corresponding abbreviated log entry

  I guess this is much easier to retrieve in svn than in git - you
actually have to walk all the history to figure out this information as
there's no global per-file info; so this is very troublesome
performance-wise. I think there were some patches on the mailinglist
that dit this, though I'm not sure. Might be reasonable to cache this
(and git history properties make it possible to nicely make a very
easily reusable cache for this information).

  About file sizes, that also has some extra performance hit, but in
this case I suspect that it would be totally negligible (if implemented
at the plumbing level) - and I admit that I would like to see file sizes
too, they can help orientation in a foreign source tree a lot.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
