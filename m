From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adapt tutorial to cygwin and add test case
Date: Wed, 12 Oct 2005 13:04:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121302460.30679@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510111333160.27109@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu0fnsu6f.fsf@assigned-by-dhcp.cox.net> <pan.2005.10.12.01.27.25.688169@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 13:05:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPePK-0005oS-4n
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 13:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVJLLEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 07:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVJLLEN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 07:04:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2539 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751422AbVJLLEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 07:04:12 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4C3613EE77; Wed, 12 Oct 2005 13:04:11 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9FAA9ECA0; Wed, 12 Oct 2005 13:04:11 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8A6C99EC66; Wed, 12 Oct 2005 13:04:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 71A5F13EC57; Wed, 12 Oct 2005 13:04:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.12.01.27.25.688169@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10018>

Hi,

On Wed, 12 Oct 2005, Matthias Urlichs wrote:

> Hi, Junio C Hamano wrote:
> 
> > The Kosher way would be
> > 
> >     tree=$(git-write-tree)
> >     commit=$(echo 'Initial commit' | git-commit-tree $tree)
> >     git-update-ref HEAD $(commit)
> > 
> > but looks quite intimidating as a tutorial material.
> 
> ... which is probably why there's a "git commit" command these days.

Concur. The tutorial may contain technical details for the interested (and 
for those who broke their setup...), so at that stage, I'd prefer to see 
the convenient version.

Ciao,
Dscho
