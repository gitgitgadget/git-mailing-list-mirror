From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 13:19:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704181312060.2828@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> 
 <20070417104520.GB4946@moonlight.home>  <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
  <200704171818.28256.andyparkins@gmail.com>  <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>  <Pine.LNX.4.64.0704181130150.12094@racer.site>
  <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGco-0000vC-Pc
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992565AbXDRUT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992567AbXDRUT1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:19:27 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45223 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992565AbXDRUT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:19:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IKJEYC027033
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 13:19:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IKJ7UP001965;
	Wed, 18 Apr 2007 13:19:11 -0700
In-Reply-To: <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44940>



On Wed, 18 Apr 2007, Guilhem Bonnefille wrote:
> 
> Yes, but I think that, as Git has ton more capabilities, user has to
> understand more things than with CVS.

I do agree.

The whole "branch" thing is something you can ignore in CVS, but it's 
simply very hard to ignore in git, because even *if* you just follow 
another repository, git kind of forces you to be aware of the difference 
between "local branch" and "remote tracking branch".

I think that's fairly fundamental to being distributed, though. 

> I don't know lot of corporate teams, but here, our developers are
> REALLY not motivated by VCS. It's only a way to share work. And I'm
> not talking about concurrent modification: lot of people in my office
> really think that the better model is the locked one.

Sure. At one level they may even be right. It's just that the locked model 
obviously doesn't work past a certain scenario. But explaining that to 
somebody who doesn't even think outside his own scenario is pointless.

So no question: git has a level of abstraction and perhaps requires a 
higher-level view than RCS and CVS do. And I can well imagine that it is 
seen as more "difficult" because of that.

I just haev to say that I worked with CVS at a commercial company for 
seven years, and I *did* do things like branches and merges etc, and 
despite workign with it at that level (not that I was the expert by any 
means: we had a person who came in with the main job literally being the 
tools around CVS to make branching more convenient etc), I seriously feel 
that CVS was a *lot* harder to get into than it is to get into git.

> So for such people, I really think raw Git is much more complicated
> than CVS/SVN.

I do wonder what we could do about that. I think you can use git in the 
"SVN tracker only" model, and I really thought it was pretty damn simple, 
but ...

		Linus
