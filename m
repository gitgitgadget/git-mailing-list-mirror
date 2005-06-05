From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 5 Jun 2005 12:03:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506051150440.30848-100000@iabervon.org>
References: <7vzmu5b8o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DexYz-0000wI-Km
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFEQEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFEQEw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:04:52 -0400
Received: from iabervon.org ([66.92.72.58]:40453 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261543AbVFEQEt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:04:49 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DexbC-00043s-00; Sun, 5 Jun 2005 12:03:42 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmu5b8o6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Jun 2005, Junio C Hamano wrote:

> Ah (lightbulb!), are you asking me to send the patch in the
> git-extended rename diff format, like this?
> 
>     $ git-diff-cache -p -B -C HEAD
>     diff --git a/Documentation/git-rpull.txt b/Documentation/git-ssh-pull.txt
>     similarity index 89%
>     rename old Documentation/git-rpull.txt
>     rename new Documentation/git-ssh-pull.txt
>     --- a/Documentation/git-rpull.txt
>     +++ b/Documentation/git-ssh-pull.txt
>     @@ -1,20 +1,20 @@
>     -git-rpull(1)
>     -============
>     +git-ssh-pull(1)
>     +===============
>      v0.1, May 2005
>     ...

Right. I hadn't actually been following the discussion entirely, but it
certainly seems like one major benefit of the rename/copy stuff is that it
will generate more readable diffs. That is, I can see what you changed in
the process of renaming the file, and don't have to inspect all the lines
you didn't change to see that they're the same.

> I am not sure if this is suitable for patch submission.  I did
> the rename/copy stuff mostly for software archaeology purposes
> (meaning, you examine what is in your repository), not to
> generate patches for submission via e-mail.

I think that examination by mailing list subscribers is a very similar
situation, and it makes sense to apply exactly the patch that has been
checked.

> It certainly is a good test for the git-apply stuff Linus has
> been working on, and in addition it would have a good amusement
> value to see how well it would work (or how badly it would barf
> ;-), but I suspect Linus (or, rather, his "dotest" script) would
> appreciate it more if it came in the traditional diff format
> that does not use the rename stuff.  I dunno.  Let's ask Linus
> first.

I think I like best what you actually did: send it both ways. Having a 
test case that's a real change someone wants to make as well as a
reference for how it should come out helps a lot in debugging. And I can
tell that the rename-using version is what I wanted, and the
non-rename-using version is also must be good if the results match.

	-Daniel
*This .sig left intentionally blank*

