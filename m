From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 13:34:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605091331000.10174@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <20060509112641.GB3228@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, sean <seanlkml@sympatico.ca>,
	junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 13:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdQU6-00050k-10
	for gcvg-git@gmane.org; Tue, 09 May 2006 13:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWEILeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 07:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEILeY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 07:34:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:28086 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932226AbWEILeY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 07:34:24 -0400
Received: (qmail invoked by alias); 09 May 2006 11:34:22 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp043) with SMTP; 09 May 2006 13:34:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060509112641.GB3228@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19833>

Hi,

On Tue, 9 May 2006, Martin Waitz wrote:

> So why is everybody trying to munch all branch related data into
> one .ini style config file?
> 
> why not simply use the mechanisms we use elsewhere and build something
> like our remotes or the new HEAD file?

Because it is good to have one consistent tool to query/update what makes 
up the configuration. Of course, we really could go about it like M$ who 
invent a hundred an twenty three ways to do the same thing, all with their 
own set of bugs.

I admit that repo-config has not been as stable as it could have been. 
That was my fault, certainly. But with the help of the list, it has become 
more stable.

Now, if we decide upon a totally different config format, okay, that's 
what it takes. But please let's not have several different formats 
*again*.

Ciao,
Dscho
