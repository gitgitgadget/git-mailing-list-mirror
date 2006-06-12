From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bisect and gitk happy together
Date: Mon, 12 Jun 2006 08:10:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120807350.5498@g5.osdl.org>
References: <46a038f90606120441p74dd4872y441fe04470f4acd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 17:10:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpo3f-0000Q9-4K
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 17:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbWFLPKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWFLPKY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 11:10:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752030AbWFLPKX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 11:10:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CFAKgt014621
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 08:10:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CFAJr4024013;
	Mon, 12 Jun 2006 08:10:19 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606120441p74dd4872y441fe04470f4acd5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21705>



On Mon, 12 Jun 2006, Martin Langhoff wrote:
> 
> - git-bisect visualise wasn't as useful as just a plain gitk. (This
> may be because I was working with ~60 commits in a medium-sized
> project).

Definitely. Try just firing up gitk when you're bisecting a kernel archive 
with thousands of commits, and complex history..

That's when "git bisect visualize" really helps: when git bisect has 
already narrowed down the list of commits from "5 years" to "1 week", but 
you still have maybe a hundred-odd commits to go.

I agree that just plain "gitk" is actually nicer if you want to see the 
whole context. It's just that often the context is pretty damn confusing ;)

> - gitk didn't show the bad commit tagged specially, even if
> git-bisect had just identified it. Of course I could find it, but I
> had all the other good/bad commits well labelled. And not the one I
> was looking for. Odd.

It should be the head of the "bisect" branch, and naturally tagged that 
way.

			Linus
