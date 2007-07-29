From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sun, 29 Jul 2007 21:02:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707292100500.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280115370.14781@racer.site> <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280152120.14781@racer.site> <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707291645580.14781@racer.site> <7vodhvm1dg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFEz3-0000sG-Jl
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 22:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933433AbXG2UDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 16:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933354AbXG2UDP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 16:03:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:42653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763354AbXG2UDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 16:03:13 -0400
Received: (qmail invoked by alias); 29 Jul 2007 20:03:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 29 Jul 2007 22:03:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jJQRsqt9jiVNMUQjGXnI8jQh0qau4Upmmxzyipr
	O7S7XrKQy26MTV
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodhvm1dg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54135>

Hi,

On Sun, 29 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I still have a problem with what should happen if both "core.bare == true" 
> > and "core.worktree = /some/where/over/the/rainbow".  Should it be bare, or 
> > should it have a working tree?
> 
> They sound contradicting with each other to me.  Isn't that a
> clear configuration error?

Yes.  But why not play nice?

Okay, the real reason I do not want to catch this error is because it 
complicates my code.

But really, why not say "worktree takes precedence"?

BTW I realised that callers of setup_git_directory_gently() might forget 
the check for the repository format version...

Ciao,
Dscho
