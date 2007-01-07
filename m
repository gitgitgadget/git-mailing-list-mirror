From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Sun, 7 Jan 2007 17:31:12 +0100
Message-ID: <20070107163112.GA9336@steel.home>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 17:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3avn-0004Uw-3H
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 17:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbXAGQbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbXAGQbX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 11:31:23 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:57802 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932606AbXAGQbW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 11:31:22 -0500
Received: from fwd31.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1H3avW-0003re-01; Sun, 07 Jan 2007 17:31:18 +0100
Received: from tigra.home (ZBu63uZfQe07kpdw4wHcUy062GGtWmLF2OPfDCJKryHKtToYhUGCZA@[84.163.114.208]) by fwd31.sul.t-online.de
	with esmtp id 1H3avS-0u8j4K0; Sun, 7 Jan 2007 17:31:14 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 20894277AF;
	Sun,  7 Jan 2007 17:31:13 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.62 #1 (Debian))
	id 1H3avQ-0007DR-Kn; Sun, 07 Jan 2007 17:31:12 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: ZBu63uZfQe07kpdw4wHcUy062GGtWmLF2OPfDCJKryHKtToYhUGCZA
X-TOI-MSGID: 915f5250-36aa-4057-8d7b-73193a9b5d67
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36175>

Alex Riesen, Fri, Jan 05, 2007 12:22:39 +0100:
> >So let's step back a bit.
> 
> Excellent analysis, thanks! I suspect heavily it will work as is.
> Now, if only someone could find time to code it up...
> 

I'm sorry for asking (because I'm partly guilty in the mess the
merge-recursive is), but could you accept at least the patch which
started the thread? It's not as if it breaks something, or giving
wrong ideas, or anything. It's incomplete, but so long noone seem to
be able to find the time to finish the job, the patch will improve the
state of affairs a bit, will it not?
