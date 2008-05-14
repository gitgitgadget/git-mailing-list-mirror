From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: resurrect "gc --auto" at the end
Date: Wed, 14 May 2008 16:07:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141607210.30431@racer>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0804021538220.4008@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwIbJ-0004Az-By
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 17:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742AbYENPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 11:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758551AbYENPHr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 11:07:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:42408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757849AbYENPHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 11:07:46 -0400
Received: (qmail invoked by alias); 14 May 2008 15:07:44 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp011) with SMTP; 14 May 2008 17:07:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/alCBeH1XaYDu/UO3ecLq4HcpL5TxjdYeVmtzdMu
	UmeUrFpEQvzHUb
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LSU.1.00.0804021538220.4008@racer.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82105>

Hi,

On Wed, 2 Apr 2008, Johannes Schindelin wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As the scripted version of git-commit did, we now call gc --auto just 
> before the post-commit hook.
> 
> Any errors of gc --auto should be non-fatal, so we do not catch those; the 
> user should see them anyway.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Junio wrote:
> 	>
> 	>  * "git commit" used to have one [call to 'gc --auto'] at the 
> 	>    end in the scripted version, but seems to have lost it in C
> 	>    rewrite.
> 
> 	How about this?

Any news on this?

Ciao,
Dscho
