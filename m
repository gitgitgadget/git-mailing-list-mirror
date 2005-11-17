From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Fri, 18 Nov 2005 00:28:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051117230723.GD26122@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:30:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EctBd-0006JH-Pk
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVKQX26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVKQX26
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:28:58 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46550 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964946AbVKQX26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:28:58 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5DE3D13F199; Fri, 18 Nov 2005 00:28:57 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 419409F34A; Fri, 18 Nov 2005 00:28:57 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2A15A98FA6; Fri, 18 Nov 2005 00:28:57 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85ED613F199; Fri, 18 Nov 2005 00:28:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20051117230723.GD26122@nowhere.earth>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12174>

Hi,

On Fri, 18 Nov 2005, Yann Dirson wrote:

> Current commit objects refer to a child tree, but to parent _commits_.
> Whereas it seems necessary to walk through the history line, and
> easily get a changelog, it is semantically quite not right:

Yes, it is. You base *your* work on *some* work. So, even if the trees may 
be equal, the base isn't.

> Indeed that emphasizes that the history lines are on living on a
> higher level of abstraction that commits.  Now what if we used
> trees->tree commits, instead of the current commits->tree ones ?

Now, how exactly would that be more abstract? Trees are just that: 
collections of files. Noone tells you what the idea was, which led from 
the last tree(s) to this one. That is not abstract.

> Any genius with a solution out there ? :)

Not a genius, but me: Write down your ideas in the commit message. That it 
the place to put abstract thoughts into.

Ciao,
Dscho
