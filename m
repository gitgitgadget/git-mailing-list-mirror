From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Thu, 22 Dec 2005 12:16:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 12:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpOQp-0001gI-Eu
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 12:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLVLQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 06:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVLVLQJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 06:16:09 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50848 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932195AbVLVLQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 06:16:06 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C722113FD4C; Thu, 22 Dec 2005 12:16:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AC4669E38A; Thu, 22 Dec 2005 12:16:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 995E09E231; Thu, 22 Dec 2005 12:16:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 02D4913FD4C; Thu, 22 Dec 2005 12:16:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13942>

Hi,

On Wed, 21 Dec 2005, Linus Torvalds wrote:

> On Wed, 21 Dec 2005, Junio C Hamano wrote:
> > 
> > How about doing something like this patch first, and then decide
> > what the default should be?

I see you already applied it, with a sane default. That's great!

> I'm certainly ok with the short format by default. And making it 
> configurable per repo sounds fine, although at the same time I wonder if 
> that perhaps confuses people more (something that works in one project one 
> way works subtly differently in another project..)

I cannot think of a saner way to have an overridable policy. Just provide 
a template config, and you're done. Everyone gets those flags per default, 
and if someone does not like it: go ahead, change it yourself!

Besides, you are usually calling git-whatchanged in your private working 
tree, where not many people can change the config.

Ciao,
Dscho
