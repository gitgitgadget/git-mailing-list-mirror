From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 20:44:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801272043040.23907@racer.site>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, j.sixt@viscovery.net, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:45:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJENx-0007CU-IH
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 21:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbYA0UpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 15:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYA0UpS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 15:45:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:42232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753890AbYA0UpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 15:45:17 -0500
Received: (qmail invoked by alias); 27 Jan 2008 20:45:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 27 Jan 2008 21:45:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1YE5YNs217MuOARQnqdalkfg1HZrqsZmNCLzTV4
	Ezyn6X5ksXJIKU
X-X-Sender: gene099@racer.site
In-Reply-To: <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71829>

Hi,

On Sun, 27 Jan 2008, Shawn Bohrer wrote:

> base + current already includes the trailing slash so adding
> one removes the first character of the next directory.
> 
> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
> ---
> 
> This fixes the oops part of the issue Johannes found,

have I?

> but doesn't address the fact that we probably should remove files that 
> aren't a part of the repository at in the first place.

I am sorry, but I cannot begin to see what this commit tries to 
accomplish.  Yes, sure, there is an off-by-one error, and your commit 
message says how that was fixed.  But I miss a description what usage it 
would affect, i.e. when this bug triggers.

I imagine that you would be as lost as me, reading that commit message 6 
months from now, trying to understand why that change was made.

Ciao,
Dscho
