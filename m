From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: weird pull behavior as of late
Date: Sun, 23 Apr 2006 21:28:36 -0400
Message-ID: <20060424012836.GC19550@quicksilver.road.mcmartin.ca>
References: <20060423.175953.52710961.davem@davemloft.net> <7vy7xvdb3x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 03:29:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXpsz-0006z8-CS
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 03:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWDXB3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 21:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWDXB3G
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 21:29:06 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:57045 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751477AbWDXB3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 21:29:05 -0400
Received: from localhost (stout [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id F07155840B0;
	Sun, 23 Apr 2006 21:29:01 -0400 (EDT)
Received: from fattire.cabal.ca (cabal.ca [134.117.69.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 63EEA5840A8;
	Sun, 23 Apr 2006 21:29:01 -0400 (EDT)
Received: from localhost (fattire.cabal.ca [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id DD0ED23E83;
	Sun, 23 Apr 2006 21:29:00 -0400 (EDT)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15207-03; Sun, 23 Apr 2006 21:29:00 -0400 (EDT)
Received: from quicksilver.road.mcmartin.ca (CPE0013d4367761-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.25.68.171])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 9425923E82;
	Sun, 23 Apr 2006 21:29:00 -0400 (EDT)
Received: by quicksilver.road.mcmartin.ca (Postfix, from userid 1000)
	id BB7663B04F; Sun, 23 Apr 2006 21:28:36 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7xvdb3x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cabal.ca
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at engsoc.carleton.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19081>

On Sun, Apr 23, 2006 at 06:18:58PM -0700, Junio C Hamano wrote:
> "David S. Miller" <davem@davemloft.net> writes:
> 
> > Updating from f4ffaa452e71495a06376f12f772342bc57051fc to 6b426e785cb81e53dc2fc4dcf997661472b470ef
> > Fast forward
> >  MAINTAINERS |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > I got 446 objects and this amounted to just a 4 line change to the
> > MAINTAINERS file? :-)
> 
> That is weird, certainly, and does not match what I am getting...
>

Hmm, I saw this when I did a git diff linus..master on my tree on hera
before I sent the pull request, but when I did git request-pull it 
had All The Right Stuff (tm), so I assumed I just mucked something up
with my command-line options. When I looked at the tree in gitk,
everything looked sane as well.

Hope I didn't break anything...

Cheers,
	Kyle 
