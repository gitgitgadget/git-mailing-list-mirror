From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Bradford C. Smith] [PATCH 2/2] use lockfile.c routines in
 git_commit_set_multivar()
Date: Thu, 26 Jul 2007 04:31:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260431240.14781@racer.site>
References: <7v7ioocatt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:32:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDu57-0008VD-0k
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXGZDb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757030AbXGZDb7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:31:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:36774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757519AbXGZDb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:31:58 -0400
Received: (qmail invoked by alias); 26 Jul 2007 03:31:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 26 Jul 2007 05:31:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BuDoze8rBoB8XxsCJPr045sDQNuHad0jvbP83c/
	vIQl2e3aDChPNq
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ioocatt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53755>

Hi,

On Wed, 25 Jul 2007, Junio C Hamano wrote:

>     From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
>     Subject: [PATCH 2/2] use lockfile.c routines in git_commit_set_multivar()
>     Date: Wed, 25 Jul 2007 12:49:53 -0400
>     Message-Id: <11853821962210-git-send-email-bradford.carl.smith@gmail.com>
> 
>     Changed git_commit_set_multivar() to use the routines provided by
>     lockfile.c to reduce code duplication and ensure consistent behavior.
> 
>     Signed-off-by: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
> 
> Dscho, I think this is worth doing regardless of that "symlinked
> config" issue.  I haven't followed the code closely enough,
> though.
> 
> What do you think?

I think that I will review it tomorrow; this darned work-tree stuff took 
way longer than expected.

Ciao,
Dscho
