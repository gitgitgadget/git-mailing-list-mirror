From: Jon Loeliger <jdl@jdl.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 08:51:13 -0500
Message-ID: <E1EInxJ-00026N-Ll@jdl.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EInxU-000367-0h
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVIWNvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVIWNvW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:51:22 -0400
Received: from www.jdl.com ([66.118.10.122]:43439 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750993AbVIWNvW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 09:51:22 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EInxJ-00026N-Ll
	for git@vger.kernel.org; Fri, 23 Sep 2005 08:51:14 -0500
To: git@vger.kernel.org
In-Reply-To: Pine.LNX.4.58.0509221355330.2553@g5.osdl.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9194>



>> (This is an intentional asymmetry, right?  Distributed systems, right?)
>
>Right. It's intentional. The "master" branch tends to be the main one for
>everybody, but _my_ "master" branch is clearly _your_ "linus" branch, and
>_your_ "master" branch would be the "jon" branch for me.

OK, I'm being clued slowly... :-)

>So it's not "asymmetric". It _is_ symmetric, but it's symmetric the same
>way "left" and "right" are symmetric when facing each other - my left is
>your right, your left is my right. It's a symmetry, but it's not an 
>_identity_.

Ah, right.  I mis-spoke myself, I see. :-)

> What does
>
>	git-cat-file -t 3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da

It used to be nothing at all.  It is now (after another fetch)
a commit.  And, it did leave this:

    jdl.com 231 % cat .git/refs/heads/origin.remote
    3fd07d3bf0077dcc0f5a33d2eb1938ea050da8da


> Actually, the fact that it even left it as a head might
> cause problems (because now you have a reference to something
> that doesn't exist), so you are probably best off just removing
> the .git/refs/heads/origin.remote file entirely.

Excellent.

<aside stage=left>
IMO, one of the things that distinguishes those "who get git"
and those who don't yet git it, are the ones who can casually
toss out phrases like, "Oh, you don't need that, just rm it."
The rest of us sit around and ponder "Do I need _that_ data?
How do I know I can toss it?  If I toss it, what will be lost
with it?  But if I revert the index, I lose... _it_, right?"

There is a certain amount of opacity to Git and its Object
store that makes it a bit scary.  And, at least for me, as
a result I am a bit reluctant to go wildly experimenting.
With more certainty as to "recovering from badness", I'll
be more familiar and more willing to experiment, I'm sure.
</aside>

Things are better, I've now been able to:

    * committish: e484585ec3ee66cd07a627d3a9e2364640a3807f
      branch 'master' of rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
    * refs/heads/origin: fast forward to branch 'master' of rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6


Thanks for your help!

jdl
