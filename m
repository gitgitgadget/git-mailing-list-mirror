From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 00:19:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710050019040.4174@racer.site>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
 <fe3pp3$8p1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Soria <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdZzM-0007Ld-0s
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 01:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760250AbXJDXTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 19:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760061AbXJDXTm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 19:19:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:39854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755944AbXJDXTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 19:19:41 -0400
Received: (qmail invoked by alias); 04 Oct 2007 23:19:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 05 Oct 2007 01:19:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18y3uEHpvwyhh97M1qePzTnvR+h6LkvrGKUAy5tU2
	V/fS0TKF5M3qMM
X-X-Sender: gene099@racer.site
In-Reply-To: <fe3pp3$8p1$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60020>

Hi,

On Thu, 4 Oct 2007, David Soria wrote:

> Am Thu, 04 Oct 2007 17:38:25 +0200 schrieb Paolo Ciarrocchi:
> 
> > Hi all,
> > I was just wondering why git commit doesn't default to "-a" (yes, it's
> > another question that came up during a chat with a mercurial user) and
> > I didn't find an answer to that.
> 
> 
> in fact i do just a git-config alias.commit 'commit -a' in my repository

Which will not work, because we do not allow overriding of 
programs/builtins by aliases.

This has technical reasons and cannot be fixed.

Ciao,
Dscho
