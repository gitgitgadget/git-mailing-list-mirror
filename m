From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make fetch-pack play nicer with servers which do not
 speak multi_ack
Date: Wed, 26 Oct 2005 01:53:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260150400.31269@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy84igfrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510251104470.24174@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vll0hcgv3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 01:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYbs-00015O-Ah
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVJYXxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVJYXxh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:53:37 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11156 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932489AbVJYXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:53:37 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 57B9113EEF1; Wed, 26 Oct 2005 01:53:36 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 383F2B0D71; Wed, 26 Oct 2005 01:53:36 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1CACFB00FD; Wed, 26 Oct 2005 01:53:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0000213EEF1; Wed, 26 Oct 2005 01:53:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll0hcgv3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10639>

Hi,

On Tue, 25 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > You're right. Complete common refs are sent even if they are ancestors 
> > of other complete common refs. I'll think about that.
> 
> I think you should be able to do something similar to what
> git-show-branch --independent does, except that the current
> show-branch implementation sucks.

I have a patch simmering, but I hesitate to send it out, lest you go and 
put it into master before I found the obvious bugs ;-)

> It wastes one-bit per ref head, which is not too bad if we deal only 
> with branches (who would sanely keep more than 29 branches in a repo 
> except Jeff ;-) [...]

Well, I do! I *love* topic branches. Sometimes I even interrupt my 
regular work to create a random one ;-)
