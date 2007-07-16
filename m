From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Mon, 16 Jul 2007 01:35:11 -0400
Message-ID: <20070716053511.GC32566@spearce.org>
References: <46977660.7070207@trolltech.com> <81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com> <200707131533.55544.simon@lst.de> <20070715024928.GY4436@spearce.org> <7vmyxydwld.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, Alex Riesen <raa.lkml@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJEx-0003Lx-El
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXGPFfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXGPFfT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:35:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47894 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXGPFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 01:35:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAJEm-0007rx-M5; Mon, 16 Jul 2007 01:35:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 243CF20FBAE; Mon, 16 Jul 2007 01:35:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vmyxydwld.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52641>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Thanks.  Marius' patch was whitespace damaged in the context lines,
> > but it was easily repaired.  I've got a couple of other small items
> > in my fastimport repository that I'm going to ask Junio to include
> > in 1.5.3 shortly.
> 
> Thanks for taking care of this.  I have pulled gfi master into
> 'master'.  Perhaps we would want to tag -rc2 this weekend, run
> with it for a week or so and see if we need -rc3 before the
> final.

I'm not entirely sure how we're going to handle the git-p4 patches;
I see there's already another set available to use '-x -' to avoid
command line length problems.

I'm more than happy to play patch monkey and ship them through the
fastimport repository, but since I'm not a p4 user that offers little
value to the process, other than perhaps to save you a little time.

Simon suggested he might setup a git fork on repo.or.cz himself, at
which point you could pull the patches for git-p4 directly from him.

Simon?

-- 
Shawn.
