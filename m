From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 20:23:14 -0700
Message-ID: <7vfyf1ena5.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 05:22:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLtQh-0001aF-E2
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 05:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWIIDWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 23:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWIIDWr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 23:22:47 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22462 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932105AbWIIDWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 23:22:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909032246.ZRRN13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 23:22:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L3Nn1V00H1kojtg0000000
	Fri, 08 Sep 2006 23:22:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 8 Sep 2006 19:56:00 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26733>

Linus Torvalds <torvalds@osdl.org> writes:

> And the "fully packed" part is probably the most important part. A packed 
> Linux historic tree takes just under six seconds cold-cache and under two 
> seconds hot-cache, but that's because pack-files are _really_ good at 
> mapping all the commits in just one go, and at the beginning of the 
> pack-file.
>
> But try the same thing with a fully unpacked kernel, and you'll see the 
> real pain of having to traverse all of history. We're talking minutes, 
> even when hot in the cache.

Just a random thought...  Does that suggest the general purpose
filesystem you would use for "a fully unpacked" case have room
for improvements?  Would a special purpose filesystem that is
designed to host .git/objects/??/ directory help?
