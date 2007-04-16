From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status when no files are removed.
Date: Mon, 16 Apr 2007 20:29:41 +0200
Message-ID: <200704162029.41427.Josef.Weidendorfer@gmx.de>
References: <20070416000408.GA19107@midwinter.com> <7v7iscvgx1.fsf@assigned-by-dhcp.cox.net> <20070416090426.GA2549@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVxZ-0004sl-Ch
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbXDPS3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbXDPS3u
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:29:50 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:58952 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754180AbXDPS3t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 14:29:49 -0400
Received: from dhcp-3s-58.lrr.in.tum.de (dhcp-3s-58.lrr.in.tum.de [131.159.35.58])
	by mail.in.tum.de (Postfix) with ESMTP id ADAE727DC;
	Mon, 16 Apr 2007 20:29:47 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070416090426.GA2549@coredump.intra.peff.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44685>

On Monday 16 April 2007, you wrote:
> On Mon, Apr 16, 2007 at 01:53:46AM -0700, Junio C Hamano wrote:
> 
> > >> > +\--ignore-notfound::
> > >> > +	Exit with a zero status even if no files matched.
> > >> > +
> > >> ls-files has --error-unmatch so we may want to make the name
> > >> consistent by saying --ignore-unmatch?  I particularly do not
> > >> care about the minute naming issues _right_ _now_, but we might
> > >> regret it in the long run.
> > >
> > > Isn't this quite similar to the '-k' option to git-mv?
> > 
> > Heh, I never use 'git-mv' and 'git-rm' myself, so I did not know
> > about that option, but from the Documentation/git-mv.txt, it
> > sounds similar.  What does it stand for, I wonder?
> 
> As you are so fond of telling everyone else, use git-blame to find out. :)
> 
> Looks like '-k' got added in the move from git-rename to git-mv. Josef,
> can you shed any light on the choice of '-k'?

That is similiar to "-k" option to "make", synonym for "--keep-going". 
I thought this was quite natural; at least I am used to this option for "make".


Josef
