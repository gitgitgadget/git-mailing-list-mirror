From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui blame: show previous commit
Date: Sun, 29 Jul 2007 12:40:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291238230.14781@racer.site>
References: <87myxfzhk6.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:40:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF78o-0004D3-4z
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbXG2Lkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761479AbXG2Lkv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:40:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:56084 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761478AbXG2Lkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 07:40:51 -0400
Received: (qmail invoked by alias); 29 Jul 2007 11:40:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 29 Jul 2007 13:40:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TJK87VBjTtPIRZdbuFkD2Wn2yZM1tVLq3euvzca
	SnfjRwhOZU4dMs
X-X-Sender: gene099@racer.site
In-Reply-To: <87myxfzhk6.fsf@mid.deneb.enyo.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54107>

Hi,

On Sun, 29 Jul 2007, Florian Weimer wrote:

> How can I view the previous commit touching a specific line, so that I
> can see what was there before?  For instance, the change could be
> whitespace-only, so that I want to dig deeper.

If you want to ignore whitespace changes, try the option "-w" to "git 
blame".  I have no idea if "git-gui blame" can use that option, but it 
should not be hard for you to find out, and provide a patch if it does 
not yet.

Hth,
Dscho
