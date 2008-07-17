From: Petr Baudis <pasky@suse.cz>
Subject: Re: Patterns work unexpectedly with "git log" commit limiting
Date: Thu, 17 Jul 2008 10:59:04 +0200
Message-ID: <20080717085903.GR32184@machine.or.cz>
References: <20080717074706.GA5392@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jul 17 11:00:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJPLL-0000qP-P1
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 11:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYGQI7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYGQI7I
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:59:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52789 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbYGQI7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:59:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1024C2C4C025; Thu, 17 Jul 2008 10:59:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080717074706.GA5392@mithlond.arda.local>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88820>

  Hi,

On Thu, Jul 17, 2008 at 10:47:06AM +0300, Teemu Likonen wrote:
>  3. What is the supposed behaviour of -F (--fixed-strings) when combined
>     with --author= ?
> 
> 	--author=pattern -F
> 
>     doesn't seem to match anything. I also tried putting the entire raw
>     author field (i.e. including the raw date) but no match. With -F
>     before the --author= it behaves like no -F at all.
> 
>     "--grep=fixedstring -F" seems to work, though.

  this is actually very high on my TODO list, since it makes
author/committer search in gitweb disfunctional. I plan to post a patch
fixing this in a few days, unless someone beats me to it as usual. ;-)

				Petr "Pasky" Baudis
