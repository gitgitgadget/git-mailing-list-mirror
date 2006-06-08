From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2]: amendment
Date: Thu, 8 Jun 2006 22:11:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082209380.28323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081719400.27335@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7j3r8uab.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoQr6-0005m4-Qi
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWFHULl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWFHULk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:11:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8420 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964967AbWFHULk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:11:40 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 27645BAA;
	Thu,  8 Jun 2006 22:11:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1BA98B68;
	Thu,  8 Jun 2006 22:11:39 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 08BC8B4E;
	Thu,  8 Jun 2006 22:11:39 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j3r8uab.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21507>

Hi,

On Thu, 8 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I completely forgot that with a global config, it makes sense to have 
> > aliases even if we are not in a git repository.
> >
> > So, in git.c, handle_alias() the "if (nongit)" makes no sense any longer. 
> > If I have to revise the patch anyway, I will include the change, but if 
> > you decide to take it, please change that.
> >
> > Ciao,
> > Dscho
> >
> > P.S.: There might be other users (such as git-peek-remote) who want that 
> > change, too.
> 
> Well, this is pretty late in the 1.4.0 game and honestly I am
> pretty reluctant to merge this in, push 1.4.0 out in 48 hours
> and leave for nearly a week.

Sorry, I timed that rather badly.

> My preference is to cook this in "next" for a while and merge it
> post 1.4.0.

Judging from the flurry of creative flag naming wishes, I think that will 
do just fine.

Ciao,
Dscho
