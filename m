From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/6] gitweb: Separate HTTP header output
Date: Wed, 27 Dec 2006 20:28:00 -0500
Message-ID: <20061228012800.GA16612@spearce.org>
References: <200612272355.31923.jnareb@gmail.com> <200612272357.56532.jnareb@gmail.com> <7v7iwc4xu9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:28:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzk42-0001hw-3g
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWL1B2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWL1B2F
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:28:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36878 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWL1B2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:28:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzk3r-00032R-E6; Wed, 27 Dec 2006 20:27:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A24E120FB65; Wed, 27 Dec 2006 20:28:00 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7iwc4xu9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35499>

Junio C Hamano <junkio@cox.net> wrote:
> which means it does not omit generating the body anyway no
> matter what "sub http_header" did...
> 
> Or is there some Perl magic that makes a return from sub named
> *_header magically terminate the execution of the caller?

No magic.  Bad patch.  Your assessment of the patch is correct;
it is not avoiding the body generation for a HEAD request.

-- 
Shawn.
