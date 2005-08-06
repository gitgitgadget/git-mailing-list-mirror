From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My Itchlist
Date: Sat, 6 Aug 2005 08:50:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508060846050.12882@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 08:51:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1IVy-0004GX-Qn
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 08:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVHFGuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVHFGuO
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 02:50:14 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20353 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261981AbVHFGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 02:50:12 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 415C3E23E4; Sat,  6 Aug 2005 08:50:11 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 236E0B349D; Sat,  6 Aug 2005 08:50:11 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 065E1AC4B2; Sat,  6 Aug 2005 08:50:11 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DF7EFE23E4; Sat,  6 Aug 2005 08:50:10 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 5 Aug 2005, Linus Torvalds wrote:

> On Fri, 5 Aug 2005, Junio C Hamano wrote:
> > 
> > - Teach fetch-pack reference renaming.
> 
> Well, the fetch side at least needs it less.
> 
> Right now the renaming means that you can only really fetch _one_ head at 
> a time, but that's at least a fairly common and important case, and you 
> can do the rest from there.
> 
> And doing only one means that git-fetch-pack can just return the result
> SHA1 of the head it was asked to fetch. In fact, even that could just be
> extended to returning multiple heads: just return each SHA1 in order. No 
> "renaming" necessary, since it's then up to the user what to do with the 
> results.

I think that we need a method to do a push in reverse: If a central 
repository has several branches, I might want to pull just those branches 
where the local head is a strict parent of the remote side, and get 
complains for the others. And maybe reference naming comes as a freebie 
with that.

Ciao,
Dscho
