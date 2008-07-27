From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sun, 27 Jul 2008 16:18:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 01:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNFZj-0007QQ-S9
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 01:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbYG0XVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 19:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbYG0XVv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 19:21:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34975 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843AbYG0XVv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 19:21:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6RNL4jO021689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Jul 2008 16:21:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6RNL3rR009153;
	Sun, 27 Jul 2008 16:21:03 -0700
In-Reply-To: <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90375>



On Mon, 28 Jul 2008, Roman Zippel wrote:
> 
> Why are you dismissing what I wrote without even giving it a second 
> thought? I didn't bother with the initial example, because it's so 
> simple, that it's no real challenge.

Did you try it? It really shouldn't be any simpler than anything else. And 
I dismissed what you wrote because the example you _did_ state was about 
something else entirely (ie apparently some giggle bug that simplifies 
things incorrectly).

> What did I do wrong that you rebuff me based on this secondary problem 
> (which I'm quite aware of, because it was me who mentioned in first place) 
> and giving the primary problem (which is the missing history) no 
> attention?

It's not missing history. It's all there in --full-history. The default is 
to give a reasonable simplification, and I told you what the 
simplification was, and it's perfectly conceptually fine - AND IT IS MUCH 
MORE EFFICIENT than the alternatives.

So I'm not seeing your point what-so-ever. 

My point is:

 - with full-history, you have it all, but it's useless in practice

 - without full-history, it's useful in practice

You never gave any examples otherwise.

			Linus
