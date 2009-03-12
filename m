From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] allow guilt to handle binary files
Date: Wed, 11 Mar 2009 20:47:39 -0400
Message-ID: <20090312004739.GM13088@josefsipek.net>
References: <87vdqpuzj5.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZHF-00086s-T1
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbZCLA6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 20:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZCLA6V
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 20:58:21 -0400
Received: from josefsipek.net ([141.211.133.196]:32906 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZCLA6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 20:58:21 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2009 20:58:21 EDT
Received: by josefsipek.net (Postfix, from userid 1000)
	id 398041C00DC4; Wed, 11 Mar 2009 20:47:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87vdqpuzj5.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112992>

On Wed, Mar 04, 2009 at 11:19:32PM +0900, Yasushi SHOJI wrote:
> git plumbings has been working with binary diff for a while.  this one
> liner enable guilt to use those capabilities.
> 
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
> ---
> Hi Jeff,
> 
> I just found out that guilt does not yet support binary patch
> capability git has for a while.
> 
> so, before I leave my office, I just tried guilt with this one liner.
> the result was:
> 
>  - my local test with biniary files work (pop/push was check with md5), and
>  - all regression test completed without any error
> 
> I felt that I just send it out. :-) 

That's how it works :)

> # Note: I've googled "guilt bianry" before sending this but could not
> # find any.  I'm not following nether git nor guilt development for a
> # while. so, let me know if I'm off track.

Sorry for taking so long...the patch looks fine. I applied it & pushed it
out.

I think it would be a good idea to have a regression test that specifically
checks binary file handling. I'm not going to get to write it for a couple
of days at least, so feel free to give it a shot :)

Thanks!

Josef 'Jeff' Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
