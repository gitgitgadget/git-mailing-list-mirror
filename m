From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 19:16:46 -0400
Message-ID: <20070316231646.GB4508@spearce.org>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316104715.483df0d5@localhost> <20070316140855.GE4489@pasky.or.cz> <20070316153822.5c842e69@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sat Mar 17 00:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLgC-0004Hh-Ut
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 00:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992457AbXCPXRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992458AbXCPXRq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 19:17:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992457AbXCPXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 19:17:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSLf4-0001Im-0G; Fri, 16 Mar 2007 19:16:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F23520FBAE; Fri, 16 Mar 2007 19:16:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070316153822.5c842e69@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42406>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
>  I think the right solution is to get rid of die() from functions that
> are supposed to be an interface, set errno if needed and return -1
> or NULL.

And then make their callers (if they are above the public API layer)
die instead.  In some cases this might imply an undesirable change
in the error message produced, as necessary details that are included
today would be unavailable in the caller.
 
>  Is there more things like the set_*_routine()s added to fix
> other problems?

Not that I am aware of.

-- 
Shawn.
