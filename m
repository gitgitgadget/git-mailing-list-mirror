From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 08:55:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
 <20080823071014.GT23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 17:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWvUC-0002hc-Ko
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 17:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYHWP4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYHWP4D
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 11:56:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136AbYHWP4B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 11:56:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NFtuFK004216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 08:55:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NFttWU022558;
	Sat, 23 Aug 2008 08:55:55 -0700
In-Reply-To: <20080823071014.GT23334@one.firstfloor.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93463>



On Sat, 23 Aug 2008, Andi Kleen wrote:
>
> > Exactly. Don't rebase. And don't base your development on somebody who 
> > does.
> 
> That's pretty much impossible in the current state of Linux development
> as far as I know.

Note that the "don't rebase" (as usual) only concerns your published tree. 
You can certainly rebase non-published stuff.

As to the "don't base your development on somebody who does" - base your 
development either on my tree (I don't rebase) or talk to the d*ck-head 
that you _want_ to work with, but who rebases.

> > Remember how I told you that you should never rebase?
> 
> I suspect your recommendation does not match real world git use.

A lot of the trees don't rebase. The rest of the trees may not realize 
that somebody wants to work on top of them.

And linux-next has _never_ been appropriate as a development base for 
other reasons, so forget about linux-next. It's to find merge conflicts 
and possibly boot/test failures of the trees it contains, not for anything 
else.

			Linus
