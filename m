From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 6 Apr 2007 20:18:52 -0400
Message-ID: <20070407001852.GB24803@athena.road.mcmartin.ca>
References: <20070406054204.GA13108@Hermes.local> <7v7ispjhtx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704061502000.6730@woody.linux-foundation.org> <86mz1lt8bg.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0704061637280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 03:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyf4-0000Eq-Fg
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 02:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473AbXDGAUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbXDGAUF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 20:20:05 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:43393 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933473AbXDGAUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 20:20:02 -0400
Received: from localhost (stout [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 9DE375840D8;
	Fri,  6 Apr 2007 20:20:00 -0400 (EDT)
Received: from fattire.cabal.ca (cabal.ca [134.117.69.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id F2BF25840D7;
	Fri,  6 Apr 2007 20:19:59 -0400 (EDT)
Received: from athena.road.mcmartin.ca (206-248-151-76.dsl.ncf.ca [206.248.151.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "roadwarrior.mcmartin.ca", Issuer "there.is.no.cabal.ca" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 9CF34837DD;
	Fri,  6 Apr 2007 20:19:59 -0400 (EDT)
Received: by athena.road.mcmartin.ca (Postfix, from userid 1000)
	id 738153B06E; Fri,  6 Apr 2007 20:18:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704061637280.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at engsoc.carleton.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43949>

On Fri, Apr 06, 2007 at 04:41:08PM -0700, Linus Torvalds wrote:
> And "polish" and "Polish" is the same word, right? AnD i cOuLD wRite 
> THInGs LiKE thiS, aND it WouLd bE eaSiER tO REad, RiGHt?
> 

Or for a more humorous case that bit me until I reformatted my MacOSX machine
as case-sensitive HFS+, how xt_conntrack.h and xt_CONNTRACK.h are the same
file...

Really makes looking at git-diff output interesting.

Cheers,
	Kyle
