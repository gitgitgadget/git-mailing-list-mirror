From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] git-instaweb: store parameters in config
Date: Wed, 26 Jul 2006 21:53:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262147280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261633320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bcorxbd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 21:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5pRo-00069s-6K
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWGZTxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWGZTxc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:53:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:62380 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751339AbWGZTxb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 15:53:31 -0400
Received: (qmail invoked by alias); 26 Jul 2006 19:53:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 26 Jul 2006 21:53:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bcorxbd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24242>

Hi,

On Wed, 26 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It already reads the config for defaults, and now it also stores
> > the last passed parameters in the config.
> 
> This might need to be conditional -- usually people override the
> default from the command line as a one-shot thing, and storing
> them in the configuration file would upset them.

I agree that this should be conditional, but the other way round, no? 
git-instaweb is meant as a one-shot install thing, so I would like to do 
this in some arbitrary repo:

	git-instaweb

and see a browser. Okay, so it does not work: I do not have LigHTTP, and 
my apache is not in the path (and you need to specify the modules-path 
anyway, if it is different than /usr/lib/apache2/modules), so I do

	git-instaweb --httpd=/usr/local/apache2/bin/httpd\ -f \
		--module-path=/usr/local/apache2/modules

Works! After I played a little with it (or rebooted the computer), I would 
like to start it again:

	git-instaweb

My point being: you do not really need a different configuration with 
git-instaweb, once you got it right.

Ciao,
Dscho
