From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rsync update appears broken now
Date: Fri, 21 Oct 2005 02:01:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210157070.14563@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
 <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510201647490.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junio@twinsun.com>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:02:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkLe-000610-5R
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJUABS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJUABR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:01:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11667 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932556AbVJUABR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 20:01:17 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4DBC813EE24; Fri, 21 Oct 2005 02:01:16 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 318B29EF58; Fri, 21 Oct 2005 02:01:16 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E2AF79EDBD; Fri, 21 Oct 2005 02:01:15 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C6B8713F161; Fri, 21 Oct 2005 02:01:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510201647490.10477@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10390>

Hi,

On Thu, 20 Oct 2005, Linus Torvalds wrote:

> On Fri, 21 Oct 2005, Johannes Schindelin wrote:
> > 
> > Also, people having merged with (A) would not have to undo that merge as 
> > was suggested. The new (C) commit would contain the revert of (A).
> 
> Oh, they'll need to revert if they want to match Junios history. Otherwise 
> they'll always generate yet another merge when they pull.

So?

> Doesn't matter that the _tree_ state may be the same, the only thing that 
> matters is that their history will be different, and thus they will never 
> be able to fast-forwared to Junio's tree unless they revert their local 
> merge.

It does not have to be a fast-forward. After all, what is another merge? 
Since that merge does not have Junio as committer, close inspection of 
the commit will reveal that.

Of course, if you did not have local changes and merged, you might want to 
do a clean "git-fetch kernel.org +master:parent".

So, no need for a revert.

Ciao,
Dscho
