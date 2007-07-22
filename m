From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 00:02:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230000020.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkRa-0001ok-N7
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762681AbXGVXCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762037AbXGVXCY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:02:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:46469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762681AbXGVXCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:02:23 -0400
Received: (qmail invoked by alias); 22 Jul 2007 23:02:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 23 Jul 2007 01:02:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hfwwVwLthy/juTC2ON5W9Gn8lHMWOc9VFrGTFvU
	YQG5nA3T/tOFOV
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53364>

Hi,

On Sun, 22 Jul 2007, Julian Phillips wrote:

> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> 
> > Well, I am really not interested in shooting myself in the foot, and 
> > having that option in checkout would make that much more likely.  So I 
> > really, really want to have this in git-branch.
> 
> Fair enough.  Your patch - so you get to choose.  I don't have any 
> strong objections (and no power to express any if I did :P) - just 
> airing my POV ;)

;-)

In related news, you got me convinced that my "solution" is not 
sufficient.  So I guess this patch has to wait until after 1.5.3 _and_ 
after we convinced Junio to put his BASE index extension in again.

FWIW once git-checkout is builtin, I'll add "--new-workdir" for it.  Deal?

Ciao,
Dscho
