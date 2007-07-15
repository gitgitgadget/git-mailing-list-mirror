From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Sat, 14 Jul 2007 22:49:28 -0400
Message-ID: <20070715024928.GY4436@spearce.org>
References: <46977660.7070207@trolltech.com> <81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com> <200707131533.55544.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sun Jul 15 04:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9uBU-0003sR-JP
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 04:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbXGOCtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 22:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbXGOCti
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 22:49:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42697 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbXGOCth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 22:49:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I9uAi-0005Th-ET; Sat, 14 Jul 2007 22:49:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6634D20FBAE; Sat, 14 Jul 2007 22:49:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707131533.55544.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52524>

Simon Hausmann <simon@lst.de> wrote:
> On Friday 13 July 2007 15:03:51 Alex Riesen wrote:
> > On 7/13/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > >      argmax = min(4000, os.sysconf('SC_ARG_MAX'))
> >
> > I wonder why the code in question does not use "-x"?
> > I use it git-p4-import and haven't seen the limit yet.
> 
> I still think the patch makes sense as stop-gap for 1.5.3 though, because 
> without it git-p4 doesn't work at all on Windows.

Thanks.  Marius' patch was whitespace damaged in the context lines,
but it was easily repaired.  I've got a couple of other small items
in my fastimport repository that I'm going to ask Junio to include
in 1.5.3 shortly.

-- 
Shawn.
