From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Tue, 22 Jul 2008 22:08:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222207110.8986@racer>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLP6m-0004Yc-14
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbYGVVIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYGVVIU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:08:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:47901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755451AbYGVVIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:08:19 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:08:17 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp029) with SMTP; 22 Jul 2008 23:08:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0yQ971M20SQuLI8hpmhJlu/jobuohfkLbcJqhMB
	x6B5voitwRkeqJ
X-X-Sender: gene099@racer
In-Reply-To: <20080722210354.GD5113@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89529>

Hi,

On Tue, 22 Jul 2008, Alex Riesen wrote:

> +	if (autocorrect && (main_cmds.cnt < 2 ||
> +		best_similarity < similarity(main_cmds.names[1]->name))) {
>  		if (!*cwd)
>  			exit(1);
>  		if (chdir(cwd))

In that case, you need to put in the "one of these" / "this" conditional 
again, which I ripped out because I do not need it any more.

Ciao,
Dscho
