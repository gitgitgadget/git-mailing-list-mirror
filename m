From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix rebase interactive to allow specifying branch to
 rebase along with the base
Date: Wed, 1 Aug 2007 23:36:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708012336170.14781@racer.site>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site>
 <20070712222640.GA30532@steel.home> <Pine.LNX.4.64.0708011654510.14781@racer.site>
 <20070801214556.GA2911@steel.home> <20070801223241.GB2911@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMoq-0008M1-4Q
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbXHAWhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbXHAWhY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:37:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:40060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754026AbXHAWhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:37:23 -0400
Received: (qmail invoked by alias); 01 Aug 2007 22:37:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 02 Aug 2007 00:37:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3wSoR6f73FUdJcCf4fZaLEKfNJkU6bIst5ZZmKh
	qiGPTUZM1BEGTh
X-X-Sender: gene099@racer.site
In-Reply-To: <20070801223241.GB2911@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54492>

Hi,

On Thu, 2 Aug 2007, Alex Riesen wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 061cd0a..b42dee8 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -404,6 +404,7 @@ do
>  		esac
>  
>  		require_clean_work_tree
> +		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
>  
>  		if test ! -z "$2"
>  		then
> @@ -418,7 +419,6 @@ do
>  
>  		test -z "$ONTO" && ONTO=$UPSTREAM
>  
> -		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
>  		: > "$DOTEST"/interactive || die "Could not mark as interactive"
>  		git symbolic-ref HEAD > "$DOTEST"/head-name ||
>  			die "Could not get HEAD"

Heh.  I take that as an ACK from you to my patch?  Mine has a test case, 
too ;-)

Ciao,
Dscho
