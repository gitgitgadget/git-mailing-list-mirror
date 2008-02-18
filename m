From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
 branch
Date: Mon, 18 Feb 2008 17:34:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181733400.30505@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR9tw-0004Tz-7G
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbYBRRfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYBRRfB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:35:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:50110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751754AbYBRRe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:34:59 -0500
Received: (qmail invoked by alias); 18 Feb 2008 17:34:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 18 Feb 2008 18:34:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/l3Zk96mfl4W8ITQ3ugMOGPad1fXhAdAMu84Db+X
	UTdpvBRL2yYE20
X-X-Sender: gene099@racer.site
In-Reply-To: <20080218155546.GA8934@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74317>

Hi,

On Mon, 18 Feb 2008, Clemens Buchacher wrote:

> diff --git a/http-push.c b/http-push.c
> index f9b77d6..e98c52f 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2138,6 +2138,8 @@ static int delete_remote_branch(char *pattern, int force)
>  
>  	/* Send delete request */
>  	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
> +	if (dry_run)
> +		return 0;

Good catch.

Thanks for the patch, I think it good.  Now, if we only had automated 
tests... ;-)

Ciao,
Dscho
