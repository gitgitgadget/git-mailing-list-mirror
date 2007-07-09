From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 09 Jul 2007 16:42:48 +0200
Message-ID: <20070709144248.GW1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091257470.5546@racer.site>
 <20070709134918.GT1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091450440.5546@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 16:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7uRx-0000H1-16
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 16:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbXGIOmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 10:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbXGIOmu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 10:42:50 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:55982 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbXGIOmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 10:42:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKX007WO27CCT@smtp15.wxs.nl> for git@vger.kernel.org; Mon,
 09 Jul 2007 16:42:48 +0200 (CEST)
Received: (qmail 14447 invoked by uid 500); Mon, 09 Jul 2007 14:42:48 +0000
In-reply-to: <Pine.LNX.4.64.0707091450440.5546@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51997>

On Mon, Jul 09, 2007 at 03:11:45PM +0100, Johannes Schindelin wrote:
> On Mon, 9 Jul 2007, Sven Verdoolaege wrote:
> > The current git-rewrite-commits will rewrite all SHA1's it can find,
> > irrespective of any 'commit ' that may precede it.
> 
> Even abbreviated ones?

Yes.  I'll add that to the documentation.

> * rename the darned things to "filter" again.
> 
> * --write-sha1-mappings=<directory> (or --write-commit-mappings), possibly 
>   defaulting to .git/mappings/.  Be careful not to overwrite an existing 
>   such directory.
> 
> * change the semantics of the commit filter: the output is a list 
>   (possibly empty) of replacement sha1's for this commit.
> 
> * if any filters are called, provide a script with convenience functions, 
>   and an environment variable pointing to it.  These functions should 
>   include:
> 
> 	* map
> 	* commit
> 	* save
> 	* restore

Hmm... you're tricking me into write shell code.

skimo
