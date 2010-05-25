From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 25 May 2010 09:42:55 +0200
Message-ID: <4BFB7F7F.5090407@drmicha.warpmail.net>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com> <4BF7B751.7050704@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue May 25 09:43:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGonL-00066y-VS
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab0EYHnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:43:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57970 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750742Ab0EYHnS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 03:43:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9244BF82BA;
	Tue, 25 May 2010 03:43:08 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 25 May 2010 03:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NSYZFMkzg+fR1esWjTHj1FeL+VM=; b=JKDcxFiYUZ13yM0W4X5U+c/igU+sWsMKQOrQAa99TM/+x1N5d/pyEx7ONgC0HPKf0CCLo9Zw4L0oczOfO8DT/Iz2IynfCGKVFRjJibCQxV+dduHJQ9h+oqeMqHwv/AvyPtDF4QUc+IzWpfxIBMGfy8rrWUlKTMFkBas/PP711Hg=
X-Sasl-enc: a0nxEWrcXERhpkS08w8Ig6lA+lccIApwRl2dL/T3dN3z 1274773388
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DEF714920A;
	Tue, 25 May 2010 03:43:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <4BF7B751.7050704@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147680>

Andrew Sayers venit, vidit, dixit 22.05.2010 12:52:
> Hi Daniele,
> 
> I'm a developer getting towards the end of introducing my company to 
> Git.  Here are some thoughts based on the (mis)steps I took.
> 
> 
> I found that advocating specific steps wasn't that effective - I just 
> came across as being pushy and hard to work with.  It was more effective 
> to politely show off what I could do with git-svn, and let people get 
> jealous enough to work the "how" out for themselves.  Here are some 
> examples:
> 
> I would quietly bisect a hard-to-fix bug, then say "if it's any help, 
> git tells me it was introduced by so-and-so in revision N".  Sometimes 
> it was no help, but sometimes it was enough to provoke the appropriate 
> "aha!" for the bug.
> 
> I would nonchalantly use as many git features as I could while showing 
> people my work.  So "here's the diff for my work... grr whitespace ... 
> hang on I'll add `-w`... anyway, these are the REAL differences...". The 
> fact it was all in glorious technicolour went without mention.
> 
> When we had a big merge that nobody was looking forward to, I said "let 
> me do it!  It'll give me a chance to practice my git-fu".
> 
> When I used svn on somebody else's command-line, I'd blame the mistakes 
> I made on being spoiled by Git.  So "I'll just do an `svn log`... argh 
> no!  Control-C!  Control-C!  Right, `svn log | less`... my bad, git 
> pipes to less automatically."
> 
> 
> Over the course of a few months, people became convinced that Git was 
> something that makes you more productive.  Our lead developer had a go 
> with git-svn for a while, before our boss decided we should all make the 
> switch.
> 
> I tried to make git-svn as painless as possible with some svn-like 
> aliases and a cheatsheet, which I'd be happy to upload if the list could 
> suggest a good place to put a PDF and some text.

Feel free to contribute to the Git Wiki maybe at

https://git.wiki.kernel.org/index.php/GitDocumentation

in the "User contributed Documentation" section.

Michael
