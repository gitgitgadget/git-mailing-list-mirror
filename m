From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Checklist clarifications: added "Commits", "Patch:"
 headings
Date: Mon, 30 Apr 2007 13:36:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301333400.29859@racer.site>
References: <r6q2xgws.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 13:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiUBJ-0004Nu-Vf
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 13:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031094AbXD3Lgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 07:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031093AbXD3Lgd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 07:36:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:34074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031094AbXD3Lgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 07:36:32 -0400
Received: (qmail invoked by alias); 30 Apr 2007 11:36:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 30 Apr 2007 13:36:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VmBhLNRoVtL3SbuShOyDU1IdFqDvCcpEwDCYmWW
	sHIC2oqLsoiYB0
X-X-Sender: gene099@racer.site
In-Reply-To: <r6q2xgws.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45860>

Hi,

On Mon, 30 Apr 2007, Jari Aalto wrote:

> +	- send your patch to <git@vger.kernel.org> by using
> +	  git-format-patch(1) with option "-M". See also
> +	  git-send-email(1).
>  	- do not PGP sign your patch
> -	- use "git format-patch -M" to create the patch

NACK.

I never use send-email myself. There are even technical issues to my 
excuse: sometimes I cannot send the mails from my machine. So, this should 
not be a _replacement_ for `git format-patch -M && send mail manually`, 
but only an _alternative_.

However, my impression was that many people had problems when first 
sending patches with send-email. There should be _at least_ a word of 
caution, that you should test the operation on something different than 
the Git list first.

Ciao,
Dscho
