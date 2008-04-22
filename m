From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 13:56:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:57:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoI3Q-0002tF-AV
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYDVM4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYDVM4M
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:56:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:41174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752674AbYDVM4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:56:11 -0400
Received: (qmail invoked by alias); 22 Apr 2008 12:56:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 22 Apr 2008 14:56:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19obIELZzFoXA0lJ+qE9vXGKXktTSj6CuhCel3SVS
	FsAXHWosA8ob6M
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422124118.GA3098@mithlond.arda.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80110>

Hi,

On Tue, 22 Apr 2008, Teemu Likonen wrote:

> Local branches are under user's personal control, so if user wants to 
> save/keep the information of remote branches he can create local ones 
> out of them: git branch localcopy $remote/$branch

For your benefit, I just assume that you did not yet read my reply to 
Peff's mail.

With the --mirror mode, you can no longer discern clearly between local 
and remote branches.  This is basically what we had in the beginning, 
before the "separate remotes layout".

So your point is not valid, an update will interfer with "local" branches.

And when those branches are deleted via "git fetch", you will not be able 
to reconstruct them easily, because the reflogs are deleted, too.

Ciao,
Dscho
