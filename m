From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 21:10:24 +0200
Message-ID: <85abswo9gf.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:10:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKIpb-0007ML-9p
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933600AbXHLTK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbXHLTK1
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:10:27 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:33407 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761586AbXHLTK0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:10:26 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 927FB15C31E;
	Sun, 12 Aug 2007 21:10:25 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 7FD89345C1B;
	Sun, 12 Aug 2007 21:10:25 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id F2A1013C49;
	Sun, 12 Aug 2007 21:10:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 84E661C3C79D; Sun, 12 Aug 2007 21:10:24 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 12 Aug 2007 11\:38\:53 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55703>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 12 Aug 2007, David Kastrup wrote:
>>
>> And then it struck me: Emacs has a very efficient browser for linked
>> one-line information that can be expanded into complete changesets
>> with diffs inside.  It is called "Gnus".  A newsreader.
>
> A newsreader is mis-designed for all the same reasons SVN is
> misdesigned: it sees the messages (commits) as a _tree_.

In the first place, it sees linked messages.  They usually correspond
to something treeish, but a newsreader that would barf when they don't
would be unusable.  Newsreaders actually have to deal with stupid
things like _loops_ in message referals without going into a tizzy.
Those things happen in Usenet.

> Anybody who sees development as a tree is totally bogus by
> definition. It sees things forking off, but it doesn't see them
> merging. That's a fundamnetal and unfixable design bug.

It is not inherent in NNTP.  It depends on the particular newsreader,
and for pretty much all of them, you can turn off threaded display if
it disturbs you.

> But to visualize a history, it's useless.

Not half as useless as existing git-specific tools.  They thrash my
computer to death on serious sized trees.  Putting every branch into a
newsgroup of its own, in contrast, together with the usual header
search and refinement options, would be _much_ _much_ faster for
accessing a particular patch.

I'll probably be able to create a Gnus _backend_ for this sort of
setup (there are even backends for directory browsing: most files
become articles written by their owner that either are plain text, or
that contain their file contents as an attachment -- quite more crazy
than a git commit tree).  But an nntp server would make the idea
usable for more than just Emacs users, and it would allow a much more
convenient "what happened on the "next" branch in the last few days"
overview than existing tools.

It lends itself not well to actually serving trees and blobs (even
though one could superficially rely on a rigid tree topology there):
newsreaders just don't match the natural way of accessing them (Gnus
offers that for files, but it plainly is not much use compared to a
dedicated directory browser).

But for commits and patches, one group per branch?  That would be
fine.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
