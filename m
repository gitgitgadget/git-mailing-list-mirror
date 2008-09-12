From: Petr Baudis <pasky@suse.cz>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 18:20:37 +0200
Message-ID: <20080912162037.GC10360@machine.or.cz>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz> <20080912160854.GL22960@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBP0-0000EN-LL
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbYILQUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756902AbYILQUj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:20:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47604 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbYILQUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:20:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1BD0F393A36E; Fri, 12 Sep 2008 18:20:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080912160854.GL22960@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95749>

On Fri, Sep 12, 2008 at 09:08:54AM -0700, Shawn O. Pearce wrote:
> Petr Baudis <pasky@suse.cz> wrote:
> > On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
> > 
> > > P.S. Could you please gather some statistics to compare the period
> > > before and after installing "smart" HTTP server (and after smart
> > > clients became widespread).
> > 
> > What kind of statistics?
> 
> Disk IO and network IO consumed probably.  The kernel.org folks are
> hoping the smart HTTP server can lower their loads a bit by being
> more careful about what we send to the client.

To check whether it actually matters for me, I have counted HTTP
requests for info/refs: 42 per hour for the last 5.5 days. So it might.
28% of the requests are web crawlers.

For objects/../, it is more fun - 1942 requests per hour. 46% is
accounted for web crawlers. I will put up a robots.txt. ;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
