From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 21:46:52 +0200
Message-ID: <85wsw0mt77.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<85abswo9gf.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJOs-0008Dp-Vs
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936845AbXHLTqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936413AbXHLTqz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:46:55 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:44114 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936625AbXHLTqy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:46:54 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 3C65E37A834;
	Sun, 12 Aug 2007 21:46:53 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id DE4F8114476;
	Sun, 12 Aug 2007 21:46:52 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A76F436E86A;
	Sun, 12 Aug 2007 21:46:52 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4CE101C3C79D; Sun, 12 Aug 2007 21:46:52 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 12 Aug 2007 12\:24\:48 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55710>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 12 Aug 2007, David Kastrup wrote:
>>
>> > But to visualize a history, it's useless.
>> 
>> Not half as useless as existing git-specific tools.  They thrash my
>> computer to death on serious sized trees.
>
> So, use "git log --pretty=oneline" instead, which doesn't have the
> expense.

Yes, like managing a manual with grep is all one needs.  git log
--pretty=oneline provides just the commit headers, but offers no way
to jump into the commits themselves and back easily.

> I don't see why you think that using nntp would help anything. The
> _problem_ is still the same one, of calculating full
> reachability. It didn't go away just because you changed to another
> intermediate protocol.

Newsreaders are designed _not_ to calculate full reachability.  They
would be unusable otherwise.  They have reasonable heuristics for
dealing with partial information and getting more only when needed.

> Yes, you could perhaps use the nntp caching, but I don't know if
> you've noticed: the reason news servers tend to expire old messages
> is that a news reader and the NNTP protocol won't be able to handle
> huge histories either.

It's actually more of a storage problem.  A pretty normal general
newsspool with about 2 weeks of storage requires several gigabytes of
disk space already.

> And if you just want the "expire" feature, then you might as well
> just make git date-limit things for you, ie "gitk --since=last.week"

I actually don't want any "expire feature".  Expiry happens at the
server, and git is quite efficient enough at "storing" the articles
that expiry appears pointless (unless one puts all of Sourceforge's
recent commit histories onto an NNTP spool, probably an interesting
experiment).

"Marked as read" could conceivably come handy for keeping on top of
large projects, but basically I'd already be suited fine with
ephemeral groups which look the same whenever I visit them again.

The thing with newsreaders is that it is easy to say "since last
week", and then just look at a few more earlier articles.  This sort
of functionality has been honed and improved over decades.  If I can
avoid starting fresh, with a new user interface and the same old
problems, that helps.  Nobody wants tools that require to tell them
when you start them just how much information you'll ever want from
them.

That's the thing why pagers are so convenient with real pipes as
compared to temporary files: you can cut off the data generating
process when you decide you don't need more, and you don't need to
wait until the whole data is there.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
