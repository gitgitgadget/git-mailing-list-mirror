From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git.xs problem, was Re: [PATCH] cvsserver: avoid warning about active
 db handles
Date: Tue, 25 Jul 2006 18:10:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44C6099A.5010205@catalyst.net.nz> <Pine.LNX.4.63.0607251649190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060725155259.GU13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 18:10:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5PUW-0000iM-JL
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 18:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWGYQKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWGYQKc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 12:10:32 -0400
Received: from mail.gmx.net ([213.165.64.21]:56527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932437AbWGYQKc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 12:10:32 -0400
Received: (qmail invoked by alias); 25 Jul 2006 16:10:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 25 Jul 2006 18:10:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060725155259.GU13776@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24178>

Hi,

On Tue, 25 Jul 2006, Petr Baudis wrote:

>   Hi,
> 
> Dear diary, on Tue, Jul 25, 2006 at 04:53:16PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> 
> > I still have the problem on at least two of my boxes that Git.xs does not 
> > load.
> 
>   What is the problem? I must have overlooked it, sorry. :-(

Still that darn private_Error.pm thing requiring Scalar::Util, IIRC.

Ciao,
Dscho
