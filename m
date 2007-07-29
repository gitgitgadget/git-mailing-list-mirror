From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sun, 29 Jul 2007 16:53:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291645580.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280115370.14781@racer.site> <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280152120.14781@racer.site> <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFB5c-0006g6-DC
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 17:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763985AbXG2Pxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 11:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763964AbXG2Pxf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 11:53:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:60864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763966AbXG2Pxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 11:53:33 -0400
Received: (qmail invoked by alias); 29 Jul 2007 15:53:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 29 Jul 2007 17:53:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/N27hrVpDNy3XtMqwm4lSnEc9/X+pEiUx+UGJzp0
	B0lKdyg8kUEyPm
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54117>

Hi,

I still have a problem with what should happen if both "core.bare == true" 
and "core.worktree = /some/where/over/the/rainbow".  Should it be bare, or 
should it have a working tree?

So here is what I plan to support so far:

--work-tree= overrides GIT_WORK_TREE, which overrides core.worktree, which 
overrides core.bare, which overrides GIT_DIR/.. when GIT_DIR ends in 
/.git, which overrides the directory in which .git/ was found.

Does that look okay?

Ciao,
Dscho
