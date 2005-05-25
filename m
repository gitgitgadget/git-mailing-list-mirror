From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: change of git-diff-tree and symlinks
Date: Thu, 26 May 2005 00:26:22 +0200
Message-ID: <20050525222622.GA8552@vrfy.org>
References: <20050525111711.GA27492@vrfy.org> <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org> <20050525183546.GA4241@vrfy.org> <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:28:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db4KA-0000RZ-Jj
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEYW1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVEYW1H
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 18:27:07 -0400
Received: from soundwarez.org ([217.160.171.123]:63657 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261560AbVEYW0a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 18:26:30 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id DFCAF39E18; Thu, 26 May 2005 00:26:22 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2005 at 12:40:51PM -0700, Junio C Hamano wrote:
> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> KS> Ok, works again. Any reason not to mark it as 'M'? It's easyly to
> KS> distinguish between a content change and a mode change by looking if
> KS> the sha has changed.
> 
> I'd need some time to think about this in the evening (I'm at
> work now) but I think Linus did '?' as an interim measure.  I
> suspect 'M' would work just as well without introducing a new
> class 'T', but on the other hand having them distinct would be
> easier for people who read diff-raw format, so my knee-jerk
> reaction is that we should use 'T'.  It's the same reasoning to
> have N, D, and U --- they can be gleaned by looking at mode and
> sha fields and there is no need to mark them any differently but
> surely marking them the way we do now is much nicer.

If we introduce 'T', how is a content _and_ a type change represented
if they happen at the same time?

Kay

