From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Comments on recursive merge..
Date: Mon, 7 Nov 2005 23:58:07 +0100
Message-ID: <20051107225807.GA10937@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:00:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZFxC-00018s-57
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 23:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVKGW6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 17:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbVKGW6R
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 17:58:17 -0500
Received: from [85.8.31.11] ([85.8.31.11]:47501 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965009AbVKGW6P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 17:58:15 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id AC69140FD; Tue,  8 Nov 2005 00:06:27 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZFwF-0002rA-00; Mon, 07 Nov 2005 23:58:07 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11288>

On Mon, Nov 07, 2005 at 08:48:06AM -0800, Linus Torvalds wrote:
> 
> Guys,
> 
>   I just hit my first real rename conflict, and very timidly tried the 
> "recursive" strategy in the hopes that I wouldn't need to do things by 
> hand.
> 
> It resolved things beautifully. Good job. 

I'm glad that it worked.

> My only worry is that I don't read python, so I don't really know how it 
> does what it does, which makes me nervous. Can somebody (Fredrik?) add 
> some documentation about the merge strategy and how it works.

I will write something up.

> Considering that the stupid resolve strategy really requires you to know 
> how git works when rename conflicts happen (things left in unmerged state 
> are really quite hard to handle by hand unless you know exactly what 
> you're doing), I'd almost suggest making "recursive" the default. I'm a 
> bit nervous about it, but knowing how it works would probably put most of 
> that to rest.

It would be great if the recursive strategy could get some more
testing. I have tested it on a thousand commits or so in a few kernel
repositories and haven't found any bugs, but it could be due to errors
in the test setup, testing the wrong repositories or just being lucky. Some
real-world testing would be great.

- Fredrik
