From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 22:24:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, lukass@etek.chalmers.se,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoR3W-00086z-Ad
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWFHUYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFHUYf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:24:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34185 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964964AbWFHUYe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:24:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 73FA11D64;
	Thu,  8 Jun 2006 22:24:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 685E41D63;
	Thu,  8 Jun 2006 22:24:33 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 30CD71D1C;
	Thu,  8 Jun 2006 22:24:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21511>

Hi,

On Thu, 8 Jun 2006, Sean wrote:

> On Thu, 08 Jun 2006 09:25:53 -0700
> Junio C Hamano <junkio@cox.net> wrote:
> 
> 
> > The wording "--no-local" means you are looking at things
> > relative to a particular repository.  I.e. some configuration
> > variables come from repository-local file, and others from
> > somewhere else.  But I do not think that somewhere else is
> > "global".  We are reading from $HOME, which is different
> > depending on who is interacting with that same repository.  So I
> > would probably call the other one "--user" or something if I
> > were force to pick name.
> 
> --user or --home makes a lot of sense.  Alternatively you could
> just be explicit: --config=~ or --config=/etc/gitconfig where
> /.gitconfig is automatically appended to the path if it ends in
> a directory name.

I think --user makes more sense than --home, since it does not matter 
_where_ it is stored, but _when_ it is retreived.

In the same vein, I do not think it is user friendly to expect the user to 
remember if it was .gitconfig, .git or .gitrc.

Ciao,
Dscho
