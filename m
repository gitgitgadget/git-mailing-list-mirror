From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: add --signoff option
Date: Sun, 30 Sep 2007 22:41:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302240450.28395@racer.site>
References: <11911689111797-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0709302229320.28395@racer.site> <C94CC989-096D-43B5-BA16-DBD4D84038C0@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:42:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Yo-0001e7-UK
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbXI3Vmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbXI3Vmj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:42:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58825 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752550AbXI3Vmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:42:38 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:42:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 30 Sep 2007 23:42:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+G+fAvUOKGSUEsCHHfO9MaNJ9I36TYZjzvstoDBa
	ueyR0MmnCHkJhI
X-X-Sender: gene099@racer.site
In-Reply-To: <C94CC989-096D-43B5-BA16-DBD4D84038C0@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59575>

Hi,

On Sun, 30 Sep 2007, Steffen Prohaska wrote:

> On Sep 30, 2007, at 11:30 PM, Johannes Schindelin wrote:
> 
> > On Sun, 30 Sep 2007, Steffen Prohaska wrote:
> > 
> > > When preparing a series of commits for upstream you may need to 
> > > signoff commits if you forgot to do so earlier.
> > 
> > Why not use format-patch's --signoff option for that?
> 
> format-patch is fine for mail. But if I either push the commits to a 
> shared repo (like msysgit's mob) or ask upstream to pull from my public 
> repo format-patch doesn't help directly.

Fair enough.  But maybe "rebase --interactive" is not too difficult, 
either?

Ciao,
Dscho
