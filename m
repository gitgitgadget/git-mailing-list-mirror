From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 20:24:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282014130.19187@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
 <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:26:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYz8-0000o0-Aw
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965927AbYD1TYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965910AbYD1TYl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:24:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:59468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965530AbYD1TYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:24:40 -0400
Received: (qmail invoked by alias); 28 Apr 2008 19:24:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 28 Apr 2008 21:24:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SpnsAmNqSLj3vwq9XeWEVKZ5dZYkTZpy+1SUw6G
	MFBopB4tVZku9c
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428190047.GG26880@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80593>

Hi,

On Mon, 28 Apr 2008, Miklos Vajna wrote:

> On Mon, Apr 28, 2008 at 07:37:54PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Isn't the problem that git-daemon loses its connection to the syslog 
> > > daemon when logrotate sighups syslog?
> 
> Right, but logrotate could send SIGHUP to git-daemon as well.

Probably.  But I do not understand how git-daemon just hangs when trying 
to close() something from within syslog().  Maybe my analysis is 
completely wrong, and I should do something completely different.

Ciao,
Dscho
