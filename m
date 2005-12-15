From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 16:40:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512151638260.3104@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com> 
 <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>  <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
  <7vlkymph4f.fsf@assigned-by-dhcp.cox.net> <81b0412b0512150654o49e1edacu67b88df6347736d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 16:42:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmvDb-0001tJ-Vo
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 16:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVLOPk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 10:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVLOPk3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 10:40:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26245 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750772AbVLOPk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 10:40:28 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0627613FB65; Thu, 15 Dec 2005 16:40:28 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D4DD49DE20; Thu, 15 Dec 2005 16:40:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B49FD9DDF7; Thu, 15 Dec 2005 16:40:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FD8913FB65; Thu, 15 Dec 2005 16:40:27 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512150654o49e1edacu67b88df6347736d2@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13700>

Hi,

On Thu, 15 Dec 2005, Alex Riesen wrote:

> > not make any sense to me; I am puzzled ... what are you trying
> > to achieve with "git pull . ref1:HEAD"?
> 
> merge branch ref1 into current. Is that not a correct refspec?

No, it is not correct. To pull means that you want to merge the fetched 
ref (your ref1), and store the result in the current branch.

But if you write "ref1:HEAD", you pretend that you want to fast-forward 
the local branch "HEAD" to ref1, and get an error if it is not 
forwardable.

In your case, I guess, "git pull ref1" is what you meant.

Hth,
Dscho
