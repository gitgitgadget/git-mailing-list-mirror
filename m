From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 23:18:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0505272313450.2400@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 23:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbm7P-0008JI-UH
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVE0VNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVE0VNp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:13:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:37338 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262595AbVE0VNi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 17:13:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP
	id ADEF4FF441; Fri, 27 May 2005 23:20:24 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27729-05; Fri, 27 May 2005 23:20:22 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP
	id E3683FF420; Fri, 27 May 2005 23:20:21 +0200 (CEST)
Received: from DIFPST1A.backbone.dif.dk ([10.227.136.220]) by diftmgw2.backbone.dif.dk with InterScan Messaging Security Suite; Fri, 27 May 2005 23:12:42 +0200
Received: from [172.16.2.11] (10.227.136.29 [10.227.136.29]) by DIFPST1A.backbone.dif.dk with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id LWFYMALC; Fri, 27 May 2005 23:13:34 +0200
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
X-Virus-Scanned: amavisd-new at dif.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 27 May 2005, Andrew Morton wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > > 
> > > Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> > > proper comments again. Also, the author is not correct (should be taken
> > > from the first Signed-off-by:).
> > 
> > Hmm.. That's not always true in general, since Sign-off does allow to sign
> > off on other peoples patches (see the "(b)" clause in DCO), but maybe in
> > the ALSA tree it is.
> 
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> 
> which means that the algorithm for identifying the author is "the final
> From:".
> 
> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.
> 
> Maybe we should introduce "^Author:"?
> 

That might be good.  I honestly don't know what would be the best 
solution, but what happens often at the moment is that patches get passed 
on as "From" whatever maintainer (or random resender) happened to pass it 
on to Andrew/Linus and that person then effectively gets labeled as the 
author of the patch in the changelogs/git/whatever. That's not perfect...

Author: might solve it.. worth a shot if you ask me.. 


-- 
Jesper Juhl


