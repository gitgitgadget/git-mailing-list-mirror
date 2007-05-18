From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 00:42:09 +0200
Message-ID: <20070518224209.GG10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpB9p-0006jF-6k
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbXERWmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762972AbXERWmN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:42:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:41638 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbXERWmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:42:12 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo17) (RZmta 6.5)
	with ESMTP id E046c9j4IMUrbG ; Sat, 19 May 2007 00:42:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0C96A277BD;
	Sat, 19 May 2007 00:42:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DD77AD195; Sat, 19 May 2007 00:42:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47673>

Sven Verdoolaege, Sat, May 19, 2007 00:08:26 +0200:
> I noticed there's a whole thread about subprojects that I haven't read yet,
> so this may have been addressed already ....

Not the checkout, which is strange. It's mostly about cloning.

> On Fri, May 18, 2007 at 11:53:12PM +0200, Alex Riesen wrote:
> > Can we have this option (and corresponding support in the following
> > patches, of course) first?
> 
> That's why the clone thing comes last.
> 
> > It is enough to have subprojects working
> > locally, and people can start using them immediately: anyone can clone
> > the subprojects manually if he wishes so.
> 
> Anyone can run git-write-tree and git-commit-tree is she wishes so...

It is much more tedious. It have to be done recursively, and with
right SHA and you have to cd into right direcotry first and it is
git-read-tree and git-checkout-index, BTW.

IOW, it is hard.

> The reason for not putting this in shouldn't be that someone doesn't
> think it is useful; the reason should be that my code is crap.

The code is not a problem. It can be also discarded because you
implemented something no one wants.

I just meant to say, that even if no one wants your subproject cloning
code, _I_ support your checkout effort and I am asking for it to be
put in.

"First", as the cloning discussion does not seem to be finished (and,
as I said, I am not interested in cloning anyway).
