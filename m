From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 10:05:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:06:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5YJ-0000AV-Jt
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWHJIF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWHJIF5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:05:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161122AbWHJIF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 04:05:56 -0400
Received: (qmail invoked by alias); 10 Aug 2006 08:05:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 10 Aug 2006 10:05:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25166>

Hi,

On Wed, 9 Aug 2006, Junio C Hamano wrote:

> * The 'next' branch, in addition, has these.
>
>   = To graduate immediately after 1.4.2 happens:
>
> [...]
>
>   - pack-objects can copy a non-delta representation of a object
>     with the new style header straight into packs.
>
> [...]
>
>   * Hopefully not too long after 1.4.2:
> 
> [...]
> 
>   - New style loose objects, which use the same header format as
>     in-pack objects, can be copied straight into packs when not
>     deltified.  I am hoping that we can make the new-style loose
>     objects the default in 10 to 12 weeks to give everybody time
>     to update to 1.4 series.

These are the same, no?

> * The 'pu' branch, in addition, has these.
>
> [...]
> 
>   - Johannes has a new diff option --color-words to use color to
>     squash word differences into single line output.
> 
>     I do not feel much need for this stuff, and the change is
>     rather intrusive, so I am tempted to drop it.

I beg to differ on the "intrusive": except for needed structs and 
functions, which are totally orthogonal with the rest of git, it only 
touches fn_out_consume(), builtin_diff() and in an obvious way, 
diff_opt_parse() and struct diff_options.

So the real impact is pretty low and well contained.

Besides, I really use it often -- you should try it! Call me blind, but 
very often I cannot spot the differences (in the unified diff) when they 
are minor, especially when there was just a typo in the documentation. You 
could now say that I should not care about it, then, but if _I_ made the 
mistake, I want to learn from it.

Of course, if you really hate what it does, I will happily carry it in my 
personal repository; I _need_ it.

Ciao,
Dscho
