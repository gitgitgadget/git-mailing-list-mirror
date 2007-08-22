From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
 documentation
Date: Wed, 22 Aug 2007 10:30:32 +0200
Message-ID: <20070822083032.GN1070MdfPADPa@greensroom.kotnet.org>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
 <11875937841178-git-send-email-madduck@madduck.net>
 <7vd4xhsybm.fsf@gitster.siamese.dyndns.org>
 <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
 <11875937841178-git-send-email-madduck@madduck.net>
 <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org>
 <20070821180218.GA14739@piper.oerlikon.madduck.net>
 <20070821202516.GL1070MdfPADPa@greensroom.kotnet.org>
 <20070821210349.GA16702@piper.oerlikon.madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, hjemli@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 10:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INlbr-00040w-8G
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 10:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXHVIaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbXHVIaf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 04:30:35 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:49191 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbXHVIae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 04:30:34 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JN600IMZ2AWPH@psmtp09.wxs.nl> for git@vger.kernel.org; Wed,
 22 Aug 2007 10:30:32 +0200 (MEST)
Received: (qmail 22997 invoked by uid 500); Wed, 22 Aug 2007 08:30:32 +0000
In-reply-to: <20070821210349.GA16702@piper.oerlikon.madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56357>

On Tue, Aug 21, 2007 at 11:03:49PM +0200, martin f krafft wrote:
> also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.21.2225 +0200]:
> > >   Users who clone the project's repository need to initialize each
> > >   submodule before they can work with it. By initializing
> > 
> > I suppose this is implicit in the git submodule man page,
> 
> It wasn't to me; that's why I am doing all this.

I meant that the rest of my sentence could probably be
implicitly understood.

> > but this is only true if you actually want to use git submodule to
> > work with the submodules.
> 
> Is it? I tried this and after cloning a repo with submodules, it
> created the submodule directories alright, but it did not actually
> check them out/populate them, so they were empty.

Some people have been doing this manually or have homegrown scripts.
Not that you should mention those options here.

> 
> > >   a submodule, the submodule's url is copied from the
> > >   .gitmodules
> > 
> > As I mentioned before, this is not strictly true. (see init::)
> 
> You're missing something like "... unless the submodule is already
> registered, in which case it won't be overwritten", right?

Something like that, yes.

skimo
