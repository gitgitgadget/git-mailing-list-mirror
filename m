From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Fri, 26 Aug 2005 15:04:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508261501510.18279@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043B9B85@scsmsx401.amr.corp.intel.com>
 <7vr7chmqop.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 15:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8dt2-0003rI-0a
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 15:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVHZNEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 09:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVHZNEp
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 09:04:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52909 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751567AbVHZNEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 09:04:45 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 070BD13C7C2; Fri, 26 Aug 2005 15:04:44 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DFB3C9ABE1; Fri, 26 Aug 2005 15:04:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C55FA9A1B1; Fri, 26 Aug 2005 15:04:43 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C74E013CA8E; Fri, 26 Aug 2005 15:04:42 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7chmqop.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7811>

Hi,

On Thu, 25 Aug 2005, Junio C Hamano wrote:

> This patch is to show my current thinking.  Please let me know
> what you think.

I like it. As Linus stated, the index originally had a different role from 
what it has now, so it really should be an internal git thing, i.e. the 
git user should not expect the index not to change when pulling.

Ciao,
Dscho
