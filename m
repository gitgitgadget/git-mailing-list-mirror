From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation for git-log --follow
Date: Fri, 13 Jul 2007 15:47:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707131540490.14781@racer.site>
References: <20070712145230.GA21590@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 16:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9MR0-0003wC-E4
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 16:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760310AbXGMOru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 10:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760181AbXGMOru
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 10:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:53144 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759349AbXGMOrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 10:47:49 -0400
Received: (qmail invoked by alias); 13 Jul 2007 14:47:47 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 13 Jul 2007 16:47:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gEnAUzlMg9g2BxEPyhtoBiqcJABVHPGyJlI7sfq
	qE6BIm3Y8dJjAL
X-X-Sender: gene099@racer.site
In-Reply-To: <20070712145230.GA21590@dervierte>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52396>

Hi,

On Thu, 12 Jul 2007, Steven Walter wrote:

> +--follow::
> +	Continue listing the history of a file beyond renames.
> +

Maybe say "Follow the history of a file beyond renames"?

> @@ -91,6 +94,12 @@ git log -r --name-status release..test::
>  	in the "release" branch, along with the list of paths
>  	each commit modifies.
>  
> +git log --follow builtin-rev-list.c::
> +
> +	Shows the commits that changed builtin-rev-list.c, including
> +	those commits that occurred before the file was given its
> +	present name.
> +

This is not particularly clear IMHO.  Probably it would be a good thing to 
contrast vs no-follow:

	The output of "git log builtin-rev-list.c" stops with commit 
	"v1.4.0-rc1~126", as if the file was created there.

	With "--follow", git will detect that this file was renamed 
	from "rev-list.c" and minimally modified in that commit.  After 
	this, it will continue with the log, using the file name 
	"rev-list.c".

Ciao,
Dscho
