From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: command to show diff of a commit
Date: Thu, 22 Sep 2005 16:33:46 +0200
Message-ID: <20050922143346.GZ15165MdfPADPa@greensroom.kotnet.org>
References: <72499e3b05092202583f9a751d@mail.gmail.com>
 <20050922100458.GF21019@pasky.or.cz> <72499e3b0509220725a52fef8@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 16:34:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIS94-0003v6-9d
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVIVOdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVIVOdv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:33:51 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:16533 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1030374AbVIVOdu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 10:33:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN8005GK34BXY@smtp16.wxs.nl> for git@vger.kernel.org; Thu,
 22 Sep 2005 16:33:47 +0200 (CEST)
Received: (qmail 11593 invoked by uid 500); Thu, 22 Sep 2005 14:33:46 +0000
In-reply-to: <72499e3b0509220725a52fef8@mail.gmail.com>
To: Robert Watson <robert.oo.watson@gmail.com>
Mail-followup-to: Robert Watson <robert.oo.watson@gmail.com>,
 git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9120>

On Thu, Sep 22, 2005 at 03:25:01PM +0100, Robert Watson wrote:
> On 9/22/05, Petr Baudis <pasky@suse.cz> wrote:
> > Dear diary, on Thu, Sep 22, 2005 at 11:58:32AM CEST, I got a letter
> > > I am wondering what is the best way to show the change introduced by a
> > > commit. In the other words, is there a better way to do this:
> > >
> > > git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
> > > b163512d4eb36ee946908b682c7863658c5a8db4
> >
> Thanks, it is nice to know that cogito can go it.  But can I achieve
> the same with git-core only?
> 

I suppose this is slightly shorter:

git-whatchanged --max-count=1 -p b163512d4eb36ee946908b682c7863658c5a8db4

skimo
