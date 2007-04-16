From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status when no files are removed.
Date: Mon, 16 Apr 2007 05:04:26 -0400
Message-ID: <20070416090426.GA2549@coredump.intra.peff.net>
References: <20070416000408.GA19107@midwinter.com> <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net> <4622C0AC.8090904@midwinter.com> <7vps65yvc1.fsf@assigned-by-dhcp.cox.net> <20070416074648.GA18719@midwinter.com> <20070416075324.GA18961@midwinter.com> <7vps64vjfc.fsf@assigned-by-dhcp.cox.net> <20070416085011.GA2387@coredump.intra.peff.net> <7v7iscvgx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 11:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdN8R-0002Mm-L9
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 11:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXDPJE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 05:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXDPJE2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 05:04:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2635 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbXDPJE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 05:04:28 -0400
Received: (qmail 12837 invoked from network); 16 Apr 2007 09:04:22 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Apr 2007 09:04:22 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2007 05:04:26 -0400
Content-Disposition: inline
In-Reply-To: <7v7iscvgx1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44635>

On Mon, Apr 16, 2007 at 01:53:46AM -0700, Junio C Hamano wrote:

> >> > +\--ignore-notfound::
> >> > +	Exit with a zero status even if no files matched.
> >> > +
> >> ls-files has --error-unmatch so we may want to make the name
> >> consistent by saying --ignore-unmatch?  I particularly do not
> >> care about the minute naming issues _right_ _now_, but we might
> >> regret it in the long run.
> >
> > Isn't this quite similar to the '-k' option to git-mv?
> 
> Heh, I never use 'git-mv' and 'git-rm' myself, so I did not know
> about that option, but from the Documentation/git-mv.txt, it
> sounds similar.  What does it stand for, I wonder?

As you are so fond of telling everyone else, use git-blame to find out. :)

Looks like '-k' got added in the move from git-rename to git-mv. Josef,
can you shed any light on the choice of '-k'?

-Peff
