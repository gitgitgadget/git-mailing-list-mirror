From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 02 Dec 2005 14:09:12 +0100
Message-ID: <20051202130911.GY8383MdfPADPa@greensroom.kotnet.org>
References: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
 <20051202091946.1631.qmail@science.horizon.com>
 <7vacfj6c4l.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 14:11:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiAfG-0005Dt-W3
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 14:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVLBNJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 08:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLBNJQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 08:09:16 -0500
Received: from psmtp03.wxs.nl ([195.121.247.12]:34701 "EHLO psmtp03.wxs.nl")
	by vger.kernel.org with ESMTP id S1750730AbVLBNJP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 08:09:15 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IQV00MMBGJCK5@psmtp03.wxs.nl> for git@vger.kernel.org; Fri,
 02 Dec 2005 14:09:12 +0100 (MET)
Received: (qmail 22153 invoked by uid 500); Fri, 02 Dec 2005 13:09:12 +0000
In-reply-to: <7vacfj6c4l.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, linux@horizon.com,
 git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13116>

On Fri, Dec 02, 2005 at 02:12:42AM -0800, Junio C Hamano wrote:
> linux@horizon.com writes:
> > 3) Dumb question: why does "git-commit-tree" need "-p" before the
> >    parent commit arguments?  Isn't just argv[2]..argv[argc-1]
> >    good enough?
> 
> 3. It does not matter; nobody types that command by hand.
> 

I do.  git commit won't let me commit an empty tree, or at
least I haven't figured out how to make it do that.

I also used it when, after resolving a merge initiated by
cg-merge, cogito (or at least the version I had installed
at the time) wouldn't let me commit it because a new file
I had pulled in contained non-ascii characters in its name.

skimo
