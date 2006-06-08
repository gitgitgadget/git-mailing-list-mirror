From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 23:10:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082308010.28722@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
 <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
 <Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP040660E676E00AD1631524AE8B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, lukass@etek.chalmers.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 23:10:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRm2-0000W0-C2
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 23:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWFHVKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWFHVKS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 17:10:18 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12209 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964964AbWFHVKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 17:10:17 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E959521C1;
	Thu,  8 Jun 2006 23:10:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DD3D021B9;
	Thu,  8 Jun 2006 23:10:15 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id AF8AA20E0;
	Thu,  8 Jun 2006 23:10:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP040660E676E00AD1631524AE8B0@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21517>

Hi,

On Thu, 8 Jun 2006, Sean wrote:

> On Thu, 8 Jun 2006 22:42:17 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > I'd like to know how --home tells you when this key is retreived.
> 
> I honestly don't know.  How does --user tell you when this key is 
> retrieved?

If I have --user vs. --repo, then I expect the setting to be active for 
the user vs. the repository, respectively.

> > The admin has no business messing around with the users' configuration. 
> > And if she absolutely wants to be a BOFH, she can fire up any editor, or 
> > copy .gitconfig to /root/.gitconfig, use git-config, and copy it back, or 
> > do what she does all the time: "su <user>". But frankly, we should not 
> > support a bad work flow.
> > 
> > BTW it is the same reason I would rather not see /etc/gitconfig: it 
> > meddles with an existing configuration. If you want to give defaults, you 
> > can use a skeleton for $HOME, and templates for $GIT_DIR. As a user, I 
> > would be very surprised if the behaviour of git changed from one day to 
> > the other without my changing anything.
> 
> This seems like a rather heavy handed policy for an application to enforce.
> To my mind, these types of decisions are best left up to administrators; 

Clearly, you have not met the same administrators as I did.

> obviously we can't guess all the creative ways git will be used beforehand.

That is right, but is it for somebody else to decide the creative way, or 
for you?

Ciao,
Dscho
