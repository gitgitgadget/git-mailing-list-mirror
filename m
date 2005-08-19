From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-head fetches, pulls, and a King Ghidorah
Date: Fri, 19 Aug 2005 03:25:13 -0700
Message-ID: <7vslx6z0ja.fsf@assigned-by-dhcp.cox.net>
References: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508191039460.11916@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 12:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E643t-0007tz-9S
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 12:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVHSKZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 06:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVHSKZS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 06:25:18 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55458 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964936AbVHSKZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 06:25:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819102514.WVE17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 06:25:14 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508191039460.11916@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 19 Aug 2005 11:14:54 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> If I understand correctly, the multi-head fetch would not write any ref if 
> used like this:
>
> 	git fetch remote:repository/ head tail
>
> but it would try a fast-forward when used like this:
>
> 	git fetch remote:repository/ head:head tail:tail
>
> Correct? If yes: This is fantastic! It obsoletes my dumb script.

That is the intent, but what is currently in "pu" is somewhat
broken.
