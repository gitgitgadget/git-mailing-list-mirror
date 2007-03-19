From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 13:52:33 +0100
Message-ID: <20070319125233.GT18276@pasky.or.cz>
References: <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com> <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org, tytso@mit.edu, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 13:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHLu-0007Gr-H6
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 13:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbXCSMwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 08:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbXCSMwg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 08:52:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55742 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbXCSMwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 08:52:35 -0400
Received: (qmail 27025 invoked by uid 2001); 19 Mar 2007 13:52:33 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42612>

On Mon, Mar 19, 2007 at 01:37:18PM CET, Johannes Schindelin wrote:
> Yes, you could write a program which can compare objects from several 
> repos, but that is easy in fact: just set GIT_ALTERNATE_OBJECT_DIRECTORIES 
> and you're done. Without changing the core of Git at all!

But you'll also need to access refs.

And the key point here is reentrance - handling multiple repositories at
once is only part of this, actually probably the much bigger customer
would be multi-threaded programs. And easier creation of reusable
components and other libraries, and so on...

I believe the performance impact will be most likely absolutely
negligible. Of course we have no hard data, but I doubt it's this where
most of the CPU crunching is.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
