From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 23:03:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082300390.28654@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
 <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
 <Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
 <e6a2rt$n6p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 23:03:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRfO-0007bP-4I
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 23:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWFHVDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 17:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWFHVDn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 17:03:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:14563 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965002AbWFHVDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 17:03:43 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id CCB9F1D9A;
	Thu,  8 Jun 2006 23:03:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C107E1D15;
	Thu,  8 Jun 2006 23:03:41 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A3FCA1BEF;
	Thu,  8 Jun 2006 23:03:41 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6a2rt$n6p$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21516>

Hi,

On Thu, 8 Jun 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > BTW it is the same reason I would rather not see /etc/gitconfig: it 
> > meddles with an existing configuration. If you want to give defaults, you 
> > can use a skeleton for $HOME, and templates for $GIT_DIR. As a user, I 
> > would be very surprised if the behaviour of git changed from one day to 
> > the other without my changing anything.
> 
> I agree wholeheartily. I guess that the 'skeleton' part has yet to be
> written...

I don't know what exactly you mean: the skeleton copying part, or the 
default .gitconfig?

As for the skeleton copying part, on the machine I am writing this on, 
there is a /etc/skel/ directory, which is automatically copied to the 
$HOME of every newly created user.

As for the default .gitconfig (which you could put into /etc/skel/): if 
the default behaviour of git is not to your liking, just make a 
$HOME/.gitconfig, and once you are satisfied with it, stick a copy into 
/etc/skel!

Ciao,
Dscho
