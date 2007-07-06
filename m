From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Fri, 6 Jul 2007 04:18:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707060416460.4093@racer.site>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
 <20070705135824.GB5493@sigill.intra.peff.net> <468DB570.1090900@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 05:26:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6eSR-0001rB-1b
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 05:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760823AbXGFD0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 23:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759840AbXGFD0H
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 23:26:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:38100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754880AbXGFD0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 23:26:05 -0400
Received: (qmail invoked by alias); 06 Jul 2007 03:26:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 06 Jul 2007 05:26:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0aTQO5h60HaS1kDZNtO+cFqzmus5BcO9WtH+PKU
	VHkbLhaCBvmtG5
X-X-Sender: gene099@racer.site
In-Reply-To: <468DB570.1090900@freedesktop.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51718>

Hi,

On Thu, 5 Jul 2007, Josh Triplett wrote:

> bash has "set -o pipefail", but that would require bash.  However, you 
> could try setting pipefail, and ignoring any failure to set it; that 
> would give the more friendly behavior with bash, while still allowing 
> any /bin/sh in general.

I was aware of pipefail when I wrote that patch.  However, I have zero 
interest in a "solution" which works on bash, but fails on other shells.  

That is like allowing a precious few to overstep some serious line (and 
commuting them), but severely punish all others.  And that's wrong.  And 
to allow it to happen is wrong, too.

Ciao,
Dscho
