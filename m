From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Implementing diff, was Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 17:47:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509251745160.17672@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
 <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 17:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJYjX-00017i-Fu
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 17:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVIYPrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 11:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbVIYPrZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 11:47:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45265 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751516AbVIYPrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 11:47:24 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A252613C510; Sun, 25 Sep 2005 17:47:19 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 849319DA08; Sun, 25 Sep 2005 17:47:19 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 70CB19D9EC; Sun, 25 Sep 2005 17:47:19 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E776513C510; Sun, 25 Sep 2005 17:47:16 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9266>

Hi,

On Sun, 25 Sep 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > The GNU diff sources are hard enough to read that I don't think we want to 
> > try to merge the unified diff generation from there.
> 
> I was talking with GNU diff maintainer and his impression was
> that CVS folks may have done enough libification -- I'll find
> time to look at CVS code and see how much damage we are talking
> about.

I am not sure if it would be wise to completely do away with the current 
method: Often, I call git-diff with my own wdiff-helper. Also, options 
like "-b" to diff are very useful, and would have to be implemented, too.

Ciao,
Dscho
