From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 08 Jul 2007 21:11:04 +0200
Message-ID: <20070708191104.GM1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707081729040.4248@racer.site>
 <20070708173027.GK1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707081911160.4248@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 21:11:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7cA2-0005Yb-Hs
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 21:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbXGHTLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXGHTLH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 15:11:07 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:34172 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbXGHTLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 15:11:06 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKV00MLNJYGVL@smtp13.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 21:11:04 +0200 (CEST)
Received: (qmail 5344 invoked by uid 500); Sun, 08 Jul 2007 19:11:04 +0000
In-reply-to: <Pine.LNX.4.64.0707081911160.4248@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51908>

On Sun, Jul 08, 2007 at 07:17:16PM +0100, Johannes Schindelin wrote:
> On Sun, 8 Jul 2007, Sven Verdoolaege wrote:
> > On Sun, Jul 08, 2007 at 05:37:22PM +0100, Johannes Schindelin wrote:
> > > I am really unhappy that so much is talked about filtering out 
> > > commits.  That is amost certainly not what you want in most cases.  
> > > In particular, I suspect that most users would expect the _changes_ 
> > > filtered out by such a command, which is just not true.
> > 
> > I don't care about that either.  I'm just mentioning it because it's 
> > mentioned in the git-filter-branch documentation (which you added).
> 
> Which I copied.  And this is not the first, let alone the only example in 
> filter-branch's documentation.

All I'm saying is that you shouldn't blame me for doing something
you have done yourself.
And if you're not blaming me, but just making a general comment,
then all I can say is that I agree with your comment.

> However, this leaves things only in half-finished states.
> 
> - "git filter-branch" did not learn the useful features that you seem to 
>   need, and
> 
> - your builtin is at most a start of a builtin replacement for 
>   filter-branch, which changes the semantics, to be sure.
> 
> I have no doubts that it will stay that way for a while, since this 
> builtin seems to be good enough for what you want it to do.

If people find rewrite-commits useful, but think that something
is missing, then I'd be willing to look into that.
I'm personally not likely to work on fiter-branch, but maybe
someone else, possibly inspired by rewrite-commits, will.
But it is true that rewrite-commits does everything I want now.

skimo
