From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Sun, 11 Sep 2005 11:56:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509111153380.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
 <7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEOZI-0005Xn-Ee
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVIKJ4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVIKJ4I
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:56:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:57249 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964850AbVIKJ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:56:07 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E079A136582; Sun, 11 Sep 2005 11:56:06 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C18A89C32B; Sun, 11 Sep 2005 11:56:06 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E20282816; Sun, 11 Sep 2005 11:56:06 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA0B2136582; Sun, 11 Sep 2005 11:56:05 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8287>

Hi,

On Fri, 26 Aug 2005, Junio C Hamano wrote:

> Come to think of it, it may be cleaner to simply forbid
> fast-forward fetching into the current repository (whether it is
> "git fetch" or "git pull").  At least in your workflow you do
> not do that ever anyway.
> 
> Johannes, what do you think, as the original advocate of "push in
> reverse"?

I'm fine with it.

Although it might make more sense to check for dirty state, and 
fast-forward only for a clean state (together with a checkout of the new 
HEAD).

Ciao,
Dscho
