From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rev-{list,parse}: allow -<n> as shorthand for --max-count=<n>
Date: Tue, 24 Jan 2006 22:33:25 -0800
Message-ID: <20060125063325.GA7953@mail.yhbt.net>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 25 07:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1eDh-0000RZ-I7
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 07:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWAYGd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWAYGd1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 01:33:27 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60876 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751040AbWAYGd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2006 01:33:26 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 555202DC033; Tue, 24 Jan 2006 22:33:25 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15119>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Some versions of head(1) and tail(1) allow their line limits to be
> > parsed this way.  I find --max-count to be a commonly used option,
> > and also similar in spirit to head/tail, so I decided to make life
> > easier on my worn out (and lazy :) fingers with this patch.
> 
> As an old timer, I personally am very used to "head -4", but
> also have been training my fingers to say "head -n 4" for the
> past few years, because the former is not POSIXly correct.

I don't agree with POSIX on this point, and I don't see why git should
be bound to POSIX, especially at the UI level just because it's POSIX.

Fwiw, head/tail in coreutils distributed by Debian still supports -<n>
alongside -n <n> and -n<n>.

> At the same time, I agree that --max-count *was* a mistake.  We
> should maybe say "-n <n>" perhaps?

Then, -n<n> (w/o the space) should be supported as well.  Heck, I've
been wanting GNU getopt_long() option parsing in git for a while.  Not
sure if I'll have time to implement it myself any time soon, though.

-- 
Eric Wong
