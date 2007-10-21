From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 09/14] Use the asyncronous function infrastructure in builtin-fetch-pack.c.
Date: Sat, 20 Oct 2007 20:29:04 -0400
Message-ID: <20071021002904.GY14735@spearce.org>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at> <20071020025352.GA6569@spearce.org> <200710202022.33782.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPnX-0007Sj-SR
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXJUBj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbXJUBj7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:39:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55952 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXJUBj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:39:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjOga-0003QZ-3Q; Sat, 20 Oct 2007 20:28:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F384B20FBAE; Sat, 20 Oct 2007 20:29:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710202022.33782.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61855>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> On Saturday 20 October 2007 04:53, Shawn O. Pearce wrote:
> >
> > If this is a threaded start_async() system this close is going
> > to impact the caller.
> 
> Yes, I noticed this, too. I think that a solution calls for a member .in of 
> struct async analogous to .in of struct child_process.

Probably.
 
> How do we continue from here? Could you park the series in pu so that I don't 
> have to resend if it turns out that the fix is just another followup patch 
> (which is how I'd prefer to solve the issue)? Then I tell you no or go after 
> I have it tested on mingw.git.

Yes, this series is already queued for pu.  I built the branch last
night but didn't push anything out.  I will be doing a push tonight
and this branch will be included in pu.

I think I would also rather receive a follow up patch than a
replacement/resend.

-- 
Shawn.
