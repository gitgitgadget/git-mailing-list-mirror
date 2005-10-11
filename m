From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Support custom build options in config.mak
Date: Tue, 11 Oct 2005 13:18:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510111308520.23242@iabervon.org>
References: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Oct 11 19:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPNhJ-0001J1-5K
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 19:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVJKRNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 13:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVJKRNt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 13:13:49 -0400
Received: from iabervon.org ([66.92.72.58]:23307 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932229AbVJKRNs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 13:13:48 -0400
Received: (qmail 3487 invoked by uid 1000); 11 Oct 2005 13:18:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Oct 2005 13:18:42 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9976>

On Tue, 11 Oct 2005, Johannes Schindelin wrote:

> +ifneq (,$(wildcard config.mak))
> +include config.mak
> +endif
> +

You can just do:

-include config.mak

for the same effect; it includes the file if it exists, and doesn't 
complain if it doesn't exist. (It also means that make has a clearer idea 
of what it's doing, which doesn't matter in this case, but is good in 
general.)

	-Daniel
*This .sig left intentionally blank*
