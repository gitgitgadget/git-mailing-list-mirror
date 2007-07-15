From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Sun, 15 Jul 2007 16:07:55 +0200
Message-ID: <20070715140755.GG999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <7v7ip2hjna.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 16:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4lc-0006jC-U5
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 16:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbXGOOIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757402AbXGOOIB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 10:08:01 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:44195 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757352AbXGOOH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 10:07:56 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL8000754L7ND@smtp15.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 16:07:55 +0200 (CEST)
Received: (qmail 19105 invoked by uid 500); Sun, 15 Jul 2007 14:07:55 +0000
In-reply-to: <7v7ip2hjna.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52557>

On Sat, Jul 14, 2007 at 12:26:01PM -0700, Junio C Hamano wrote:
> But this leads to more fundamental issues.  It is not obvious
> from the description what environment rewrite-commits runs in.

I'll try to make that more clear in the next round.

> >> +To move the whole tree into a subdirectory, or remove it from there:
> >> +
> >> +---------------------------------------------------------------
> >> +git rewrite-commits --index-filter \
> >> +	'git ls-files -s | sed "s-\t-&newsubdir/-" |
> >> +		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
> >> +			git update-index --index-info &&
> >> +	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'
> >> +---------------------------------------------------------------
> 
> I see only one operation in the example, and "or remove it from
> there" confuses the reader.

I found it confusing too (I copied it from the filter-branch manual).
I'll remove it.

skimo
