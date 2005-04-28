From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 18:47:56 +0200
Message-ID: <1114706876.20916.18.camel@tglx.tec.linutronix.de>
References: <200504271251.00635.mason@suse.com>
	 <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
	 <1114627268.20916.8.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0504280815120.18901@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <mason@suse.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBA0-00074u-8y
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 17:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVD1PsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 11:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVD1PsI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 11:48:08 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29628
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262157AbVD1PsE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 11:48:04 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id C315D65C003;
	Thu, 28 Apr 2005 17:46:15 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 4298B28089;
	Thu, 28 Apr 2005 17:47:58 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504280815120.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 08:24 -0700, Linus Torvalds wrote:
> I disagree. I'm not database allergic, I just don't believe in the notion 
> that databases solve all the worlds problems.

I never claimed, they did

> You just made creating a commit etc much slower. You now have to update 
> per-file information that you never updated before, and look at 
> information that git simply doesn't _care_ about. 

I did not say, that such a fetaure should be included into git itself.
That was never my intention.

> what? We've had that. It's called RCS/SCCS/CVS, and it's a piece of total
> and absolute crap. Exactly because single-file revisions simply do not
> matter.

I agree that RCS is crap for distributed development, but seeing a
change in a file in the correct context is quite helpful at times.

> If you want to use a database, go wild. But use it as a _cache_. Then you 
> can build up the database of file revisions "after the fact", and always 
> know that your database is not the real data, it's just an index, and can 
> be thrown away and regenerated at will.

Thats all I want to use it for. Exactly for of tracking information over
various repos and longer time intervals.

tglx


