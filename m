From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 23:55:26 -0400
Message-ID: <20070319035526.GJ20658@spearce.org>
References: <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319025636.GE11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8y6-0001jL-0Z
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965424AbXCSDzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965452AbXCSDzd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:55:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49933 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965424AbXCSDzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:55:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT8xo-0000L9-36; Sun, 18 Mar 2007 23:55:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC20320FBAE; Sun, 18 Mar 2007 23:55:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070319025636.GE11371@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42581>

Theodore Tso <tytso@mit.edu> wrote:
> Berkely got it horribly wrong when it tried to start with the "small
> and beautiful" functions that were non-reentrant, and we've been
> paying the price ever since.  Do we really want to support two
> versions of the API forever?  Is it really that hard to support a
> reentrant API from the beginning?  I'd submit the answer to these two
> questions are no, and no, respectively.

I agree entirely, for every reason mentioned by Ted (including
those not quoted).  ;-)

I learned about gethostbyname after gethostbyname_r was already
introduced, so I have always been asking myself "uhhhhh, why do we
have gethostbyname?".  ;-)

-- 
Shawn.
