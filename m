From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Tue, 30 Oct 2007 15:05:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301504270.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 30 16:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImsfC-00011G-RN
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 16:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbXJ3PFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXJ3PFm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 11:05:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:57934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbXJ3PFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 11:05:41 -0400
Received: (qmail invoked by alias); 30 Oct 2007 15:05:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 30 Oct 2007 16:05:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SXwMpPnOSl5bCYH0uZX+Q93kYITpmAS43n7C8k9
	roAjfZ4Go/xugz
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 30 Oct 2007, Peter Karlsson wrote:

> Benoit SIGOURE:
> 
> > I think you can use grafts do achieve this.
> 
> That seems to work, but the grafts list doesn't seem to propagate when I 
> push/pull/clone. Is it possible to get that to work?

No.  Use filter-branch, and publish the cleaned up history (possibly as a 
new branch/repo).

Ciao,
Dscho
