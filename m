From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 0/4] reworking git-rebase
Date: Thu, 17 Nov 2005 11:30:27 +0100
Message-ID: <20051117103027.GR8383MdfPADPa@greensroom.kotnet.org>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 11:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ech2d-0001QR-VB
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 11:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKQKad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 05:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKQKad
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 05:30:33 -0500
Received: from smtp18.wxs.nl ([195.121.247.9]:39120 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S1750724AbVKQKad (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 05:30:33 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IQ300AS7H6RGC@smtp18.wxs.nl> for git@vger.kernel.org; Thu,
 17 Nov 2005 11:30:28 +0100 (CET)
Received: (qmail 19921 invoked by uid 500); Thu, 17 Nov 2005 10:30:27 +0000
In-reply-to: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12093>

On Tue, Nov 15, 2005 at 03:32:05PM -0800, Junio C Hamano wrote:
> It notes that fact, and goes ahead to apply D and E, and at the
> very end tells you to deal with C by hand.  Even if you somehow
> managed to replay C on top of the result, you would now end up
> with ...-B-...-U-A-D-E-C.

Actually this is sometimes useful when rewriting history.
Suppose you cherry-pick two changes that touch the same piece
of code and combine them into a single change and then rebase
all your changes on top of this combined change.
The two cherry-picked changes will not apply and end up and
at the end of the chain where you can simply discard them.

Will the reworked rebase still support this use or is there
a better way to do this ?

skimo
