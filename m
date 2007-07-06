From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 14:14:41 +0200
Message-ID: <20070706121441.GM3492@stusta.de>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site> <20070706014222.GK3492@stusta.de> <Pine.LNX.4.64.0707060243110.4093@racer.site> <20070706022629.GL3492@stusta.de> <Pine.LNX.4.64.0707060413190.4093@racer.site> <alpine.LFD.0.98.0707052108070.9434@woody.linux-foundation.org> <7vd4z6gkbk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:14:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6mhT-0004JC-0o
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759957AbXGFMON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759925AbXGFMON
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:14:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52620 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759900AbXGFMOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:14:12 -0400
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 45908181C33;
	Fri,  6 Jul 2007 14:15:27 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id A18323CFC89; Fri,  6 Jul 2007 14:14:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4z6gkbk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51743>

On Thu, Jul 05, 2007 at 10:41:51PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>...
> > Adrian has a point in that if there are lines to be deleted, that in 
> > itself is context, and then the strict behaviour of "git-apply" is 
> > arguably unnecessaily strict.
> 
> Not really.  That is true, unless you have two identical
> instances of the group of lines being deleted, in which case you
> cannot safely tell which instance is to be removed.
>...

The interesting thing is that you can never safely tell it for any 
amount of context - I've seen patches with three lines of context being 
applied at the wrong place simply because there were several matching 
contexts.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
