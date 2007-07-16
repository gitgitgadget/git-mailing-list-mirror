From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Mon, 16 Jul 2007 23:47:56 +0200
Message-ID: <20070716214756.GA15007MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site>
 <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAYQJ-0003C7-H0
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762926AbXGPVr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762790AbXGPVr7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:47:59 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:61920 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762665AbXGPVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 17:47:58 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLA00DUQKJW90@psmtp12.wxs.nl> for git@vger.kernel.org; Mon,
 16 Jul 2007 23:47:57 +0200 (MEST)
Received: (qmail 15024 invoked by uid 500); Mon, 16 Jul 2007 21:47:56 +0000
In-reply-to: <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52727>

On Mon, Jul 16, 2007 at 10:04:04PM +0200, Sven Verdoolaege wrote:
> - a SHA1 of a commit that appears in a commit message is replaced
>   by the rewritten commit iff it was rewritten to a single commit.
>   That is, if the commit was pruned or rewritten (through a commit
>   filter) to more than one commit, then the SHA1 is left alone.

Sorry.  I misremembered.  I considered doing it this way, but
then thought it was better to replace the SHA1 with a(n abbreviated)
null SHA1 to signify that the commit had gone.

skimo
