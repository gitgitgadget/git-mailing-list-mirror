From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 22:30:16 +0200
Message-ID: <857io0mr6v.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<85abswo9gf.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
	<85wsw0mt77.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKK54-0002BQ-SF
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXHLUaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXHLUaU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:30:20 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:59953 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662AbXHLUaS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 16:30:18 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 6D54915C2E2;
	Sun, 12 Aug 2007 22:30:17 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 5B86C2D3B2C;
	Sun, 12 Aug 2007 22:30:17 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 2ACE430AA27;
	Sun, 12 Aug 2007 22:30:17 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BCD9E1C3C79D; Sun, 12 Aug 2007 22:30:16 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 12 Aug 2007 12\:59\:48 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55721>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 12 Aug 2007, David Kastrup wrote:
>> >
>> > So, use "git log --pretty=oneline" instead, which doesn't have the
>> > expense.
>> 
>> Yes, like managing a manual with grep is all one needs.  git log
>> --pretty=oneline provides just the commit headers, but offers no way
>> to jump into the commits themselves and back easily.
>
> You misunderstand.
>
> I was suggesting you do a *tool* that bases its listing on 
> --pretty=oneline, and then goes from there.

Full agreement here.  My tool was going to pass those lines off as
article headers.

> If you don't show the graph anyway, all the complex and expensive
> things that "git-rev-list --topo-order" does is pretty much totally
> useless.  You're going to show the commits as a list anyway, and
> then when you *select* one commit for closer inspection, you can
> then try to do a better job at that point of doing the reachability
> (ie parenthood is trivial, and the branch reachability is cheap if
> it's close to the tip of the tree, which it would almost always be).

Quite so.  I was thinking of doing such a tool inside of Emacs (after
all, Emacs is the most extensive junkyard for prototyping editing
solutions that can be had) and was weighing options for what kind of
stuff I would need to be doing to have it work efficiently, offering
access to everything without wasting unnecessary time on those things
that don't interest me at the moment.

And what I came up with had far too many similarities to what a
newsreader does...  So my first reaction to that idea was to post to
the Gnus Usenet group proposing some sort of virtual server method for
Gnus (it already has more than a dozen for managing news, mail,
various mail and news spools, diaries, Google, Slashdot, files,
directories, virtual groups...).  But it occured to me that the
mapping of information to NNTP is actually so straightforward that the
idea seemed exploitable not just by Emacs users.

> But if you have a client that is incremental anyway, almost all of
> that goes away.

Yup.  Omniscience is overrated in computer science.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
