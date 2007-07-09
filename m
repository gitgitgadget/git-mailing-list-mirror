From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 09 Jul 2007 11:48:33 +0200
Message-ID: <20070709094833.GQ1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707081729040.4248@racer.site> <46912726.5080807@midwinter.com>
 <Pine.LNX.4.64.0707081920410.4248@racer.site>
 <20070708211034.GO1528MdfPADPa@greensroom.kotnet.org>
 <4691F96E.D869DF97@eudaptics.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 11:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7prC-0007aY-MM
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 11:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXGIJsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 05:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXGIJsf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 05:48:35 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:32777 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbXGIJsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 05:48:35 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKW0021POKXCS@smtp19.wxs.nl> for git@vger.kernel.org; Mon,
 09 Jul 2007 11:48:34 +0200 (CEST)
Received: (qmail 10992 invoked by uid 500); Mon, 09 Jul 2007 09:48:33 +0000
In-reply-to: <4691F96E.D869DF97@eudaptics.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51976>

On Mon, Jul 09, 2007 at 11:01:34AM +0200, Johannes Sixt wrote:
> Sven Verdoolaege wrote:
> > I guess the major thing that is missing is --subdirectory-filter.
> > Anything else?
> 
> Yes, how about this:
> 
>   $ git rewrite-commits --index-map '
>          testresult=$($HOME/bin/expensive-test);
>          [ $testresult = t ] && $HOME/bin/tweak-index ' \
>      --commit-map '
>          [ $testresult = t ] && $HOME/bin/tweak-commit '
> 
> :-P

You can write the result of expensive-test to a temporary file.

skimo
