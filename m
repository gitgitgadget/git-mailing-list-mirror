From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Thu, 01 Dec 2005 14:07:24 +0100
Message-ID: <20051201130724.GV8383MdfPADPa@greensroom.kotnet.org>
References: <20051123222003.GA16290MdfPADPa@greensroom.kotnet.org>
 <20051129211551.GF8383MdfPADPa@greensroom.kotnet.org>
 <17294.58317.317337.145932@cargo.ozlabs.ibm.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 14:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eho9r-0003vz-Ik
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 14:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVLANH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVLANH2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 08:07:28 -0500
Received: from psmtp04.wxs.nl ([195.121.247.13]:15313 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S932219AbVLANH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 08:07:28 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IQT00IL8LSCD6@psmtp04.wxs.nl> for git@vger.kernel.org; Thu,
 01 Dec 2005 14:07:24 +0100 (MET)
Received: (qmail 1972 invoked by uid 500); Thu, 01 Dec 2005 13:07:24 +0000
In-reply-to: <17294.58317.317337.145932@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Mail-followup-to: Paul Mackerras <paulus@samba.org>,
 Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13054>

On Thu, Dec 01, 2005 at 10:51:41PM +1100, Paul Mackerras wrote:
> I put this in although I'm not completely happy with it (though it is
> a good step in the right direction).

Thanks.  That's what it was meant to be (a step in the right direction).

> Why do we unset children and nchildren in the phase == updatecommits
> case?  Wouldn't it give the same result if we set ncleft to nchildren
> for each commit and then we didn't call updatechildren in
> finishcommits?  I think that would end up simpler.

Well, you probably know your own code better than I do,
but I'll have a look later.

> I tried removing some commits (using git reset --hard) and then doing
> selecting update from the menu, and it redrew everything, but the
> removed commits were still shown.

Hmmm...  I'll have look at this over the weekend (unless you beat
me to it).

> Also, what will happen if the user selects update while gitk is still
> drawing the graph?  I think that will cause havoc.  At _best_ we'll
> end up with a truncated list of commits AFAICS.  We need to make that
> robust.

Agreed.  I hadn't thought a user would do that, but that was just
my lack of imagination.

skimo
