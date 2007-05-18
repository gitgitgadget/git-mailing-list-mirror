From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 09/16] entry.c: optionally checkout submodules
Date: Sat, 19 May 2007 00:03:23 +0200
Message-ID: <20070518220323.GL942MdfPADPa@greensroom.kotnet.org>
References: <11795163053812-git-send-email-skimo@liacs.nl>
 <1179516307425-git-send-email-skimo@liacs.nl>
 <20070518215642.GC10475@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAXr-0008Mm-Uk
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbXERWD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXERWD0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:03:26 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:47798 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbXERWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:03:25 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JI900EYCBXN00@smtp17.wxs.nl> for git@vger.kernel.org; Sat,
 19 May 2007 00:03:24 +0200 (CEST)
Received: (qmail 11603 invoked by uid 500); Fri, 18 May 2007 22:03:23 +0000
In-reply-to: <20070518215642.GC10475@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47664>

On Fri, May 18, 2007 at 11:56:42PM +0200, Alex Riesen wrote:
> skimo@liacs.nl, Fri, May 18, 2007 21:24:58 +0200:
> > +	if (err)
> > +		return error("failed to run git-checkout in submodule '%s'", path);
> 
> We may need an option to ignore these failures. Maybe even active by
> default. Imagine a superproject with _optional_ submodules, where it
> is just nice to know that some submodules weren't checked out. BTW,
> doesn't git-checkout already prints an error?

Probably.  You probably noticed that I haven't written any tests yet...

Still, the error that git-checkout prints may not give enough of a clue
that something was wrong with a submodule.

skimo
