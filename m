From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitweb "tag" display
Date: Sat, 20 Aug 2005 09:21:39 +1000
Message-ID: <17158.27011.7426.577686@cargo.ozlabs.ibm.com>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<20050806033654.GA27953@vrfy.org>
	<7vacju9az9.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpssq7vfa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 01:22:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6GB9-0004uP-Lu
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 01:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHSXVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVHSXVh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 19:21:37 -0400
Received: from ozlabs.org ([203.10.76.45]:23981 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932340AbVHSXVg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 19:21:36 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4658467F9D; Sat, 20 Aug 2005 09:21:35 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpssq7vfa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> If you can pop-up a temporary window that shows the tag contents
> when I hover over a tag icon for 2 seconds, and remove that
> temporary window when step outside it would be ideal.  It is up

I did something a little easier - if you click on the tag, it now
displays the contents of the tag in the details pane.  Is that good
enough?

> to you to implement the part to show my wife's picture, reading
> "object-content-type: image/jpeg" thing ;-).  That one was not a
> serious request.

Well, Tk can display inline images in text widgets... :)

> I have two more requests to gitk, which are related to each
> other but not related to the "tag contents" one above:
> 
>  - if "gitk --all" slurped not just refs/heads and refs/tags but
>    everything under refs/* recursively, that would help
>    visualizing the bisect status.  bisect creates bunch of
>    commit object names in refs/bisect.
> 
>  - I have not looked at the code closely enough, but I cannot
>    find how to re-read references.  I would appreciate it if it
>    allowed it.  This relates to the bisect status visualization,
>    where the set of references changes _after_ the user started
>    gitk.

I implemented these two.  There is now a "Reread references" button in
the File menu.  References other than tags and heads get displayed in
a light blue box.

Hmmm... now I suppose we want a way to use gitk to drive the git
bisection process... :)

Paul.
