From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: Don't number patches when there's only
 one
Date: Mon, 22 Oct 2007 10:44:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221044080.25221@racer.site>
References: <20071021144637.762085BB92@nox.op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 11:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijtq9-0000KZ-Rx
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 11:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbXJVJog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbXJVJog
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 05:44:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:58269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750869AbXJVJog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 05:44:36 -0400
Received: (qmail invoked by alias); 22 Oct 2007 09:44:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 22 Oct 2007 11:44:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZjgwVlMmZfgq+nZsCX/uM0VmvtDpXgHnNMXUjwU
	3xG2HScYQ3YnID
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021144637.762085BB92@nox.op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61976>

Hi,

On Sun, 21 Oct 2007, Andreas Ericsson wrote:

> [PATCH 1/1] looks a bit silly, and automagically handling this in 
> git-format-patch makes some scripting around it a lot more pleasant.

I think you should not use "-n" if you do not want to have the numbers.  
In circumstances as yours, where you can have patch series larger than 
one, I imagine that the "[PATCH 1/1]" bears an important information, 
which is not present in "[PATCH]": this patch series contains only one 
patch.

IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
me.

Ciao,
Dscho
