From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix some doc typos and grammar
Date: Thu, 01 Feb 2007 22:44:28 -0800
Message-ID: <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCs9x-0004MR-1R
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbXBBGoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423152AbXBBGo3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:44:29 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:62359 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423153AbXBBGo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:44:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202064430.XBKW1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 01:44:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JWkU1W00F1kojtg0000000; Fri, 02 Feb 2007 01:44:28 -0500
In-Reply-To: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com>
	(Mike Coleman's message of "Fri, 2 Feb 2007 00:25:30 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38463>

"Mike Coleman" <tutufan@gmail.com> writes:

> [This is my first patch, which I'm trying via cut-and-paste into
> gmail, which I realize sucks.  Any ideas for a better way?  Is anyone
> sending patches via gmail+pop?  I gave up my previous shell/email
> provider because they just weren't keeping the spam down.  Any
> suggestions for something that works?  --Mike]

It is usually nicer to put this "cover letter" material below
the three dashes after Signed-off-by line; not a huge deal,
though.

I was surprised that, for a patch that came from cut & paste via
gmail, your patch did not have too many whitespace breakages.
There was only one -- this hunk:

> @@ -2923,6 +2923,8 @@ Think about how to create a clear chapter
> dependency graph that will
>  allow people to get to important topics without necessarily reading
>  everything in between.
>...

and after hand-fixing that overflowed hunk header, everything
cleanly applied.

It might help if you did not say:

	Content-Type: text/plain; charset=ISO-8859-1; format=flowed

as "format=flawed" often seem to corrupt patches by wrapping
lines.  This might be fixable just by futzing with your MUA
setting, or maybe gmail sets it and outside of your control; I
do not know which, because I do not use gmail myself.

> @@ -617,7 +617,7 @@ the relationships between these snapshots.
>  Git provides extremely flexible and fast tools for exploring the
>  history of a project.
>
> -We start with one specialized tool which is useful for finding the
> +We start with one specialized tool that is useful for finding the
>  commit that introduced a bug into a project.
>
>  How to use bisect to find a regression

Ah, "which or that", very funny.  At work today I was working
with somebody you know (AB) on a document, and he was fixing my
that to which.  Now you are fixing my which to that.

All the other hunks looked reasonable to me.  Thanks, will
apply, and I'll let others to fight over which and that ;-).
