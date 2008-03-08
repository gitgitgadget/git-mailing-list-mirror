From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/11] Allow for having for_each_ref() list some refs
 that aren't local
Date: Sun, 9 Mar 2008 00:22:41 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803090020430.3975@racer.site>
References: <alpine.LNX.1.00.0803081804170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8Nn-0004x8-6q
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYCHXWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYCHXWh
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:22:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:48930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751314AbYCHXWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:22:37 -0500
Received: (qmail invoked by alias); 08 Mar 2008 23:22:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 09 Mar 2008 00:22:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lgBNjFuvleLYGc7y5G0SWZTgjBK+wzjPEqQTEYN
	t7gnmKQLQNdwIj
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081804170.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76617>

Hi,

On Sat, 8 Mar 2008, Daniel Barkalow wrote:

> This is useful, for example, for listing the refs in a reference 
> repository during clone, when you don't have your own refs that cover 
> the objects that are in your alternate repository.

How about this commit oneline instead:

	for_each_ref(): Allow adding extra refs to be traversed

Hmm?

You can explain in the body that the SHA-1s are not verified locally, so 
that you can add extra refs that do not reference local objects.

Ciao,
Dscho
