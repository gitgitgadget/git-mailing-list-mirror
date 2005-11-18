From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 22:01:11 +0100
Message-ID: <20051118210111.GB3168@vrfy.org>
References: <200511181833.40048.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <437E3971.3060803@zytor.com> <200511182151.56161.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:32:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDMM-0008FN-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbVKRVBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbVKRVBW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:01:22 -0500
Received: from soundwarez.org ([217.160.171.123]:45189 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161220AbVKRVBW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:01:22 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 2DD3F684B8; Fri, 18 Nov 2005 22:01:11 +0100 (CET)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511182151.56161.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12273>

On Fri, Nov 18, 2005 at 09:51:56PM +0100, Josef Weidendorfer wrote:
> On Friday 18 November 2005 21:28, H. Peter Anvin wrote:
> > I think the point is: what do you do with the data?  If it *looks* like 
> > valid UTF-8, you pretty much have to assume it is; if it's not (it 
> > contains invalid UTF-8 sequences), what do you do?  There are only a 
> > small handful of alternatives, and none are really good:
> > 
> > 	- Reject it (it's kind of too late, should have been done at
> > 	  checkin)
> > 	- Show them as SUBSTITUTE characters (U+FFFD).
> > 	- Show them as Latin-1 or Windows-1252
> > 	- Provide a complex configuration mechanism
> > 
> > I think Kay is going with the second option.
> 
> In the case of the Linux kernel, UTF-8 of course is the
> way to go. As you can not reject already commited objects, the second
> option seems the best way.
> 
> But I think it would be better to have a config option specifying the
> prefered encoding for commit comments in a project. Something like
> 
> 	core.commit-encoding = Latin-1
> 
> gitweb should use this.

Sorry, the 90's are over. Patch it, if you need it, I will not make it happen.

Kay
