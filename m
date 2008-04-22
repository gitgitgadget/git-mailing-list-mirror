From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 16:08:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221607190.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local> <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness> <20080422140440.GC3098@mithlond.arda.local> <480DF1E7.5040900@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 17:11:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoK6s-0002fb-6b
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 17:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbYDVPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 11:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbYDVPHr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 11:07:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:43162 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755168AbYDVPHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 11:07:47 -0400
Received: (qmail invoked by alias); 22 Apr 2008 15:07:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp019) with SMTP; 22 Apr 2008 17:07:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cmr5TH6CcguCYbiEiVlg3kWKrU0ajv3XnO56wO/
	ffSxV76mCid/Uk
X-X-Sender: user@eeepc-johanness
In-Reply-To: <480DF1E7.5040900@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80128>

Hi,

On Tue, 22 Apr 2008, Paolo Bonzini wrote:

> > > Okay, how about this: take Peff's patch, but add a warning if 
> > > --mirror is used on a non-bare repository?
> > 
> > Sounds good to me. Indeed, giving a warning is _very_ good idea as 
> > --mirror is potentially, even likely, destructive with local changes 
> > and working directory.
> 
> What about changing --mirror to add a push line instead of a fetch line?

I would not expect --mirror to add a push line when "git-remote add" 
without --mirror does not a push line either.

Ciao,
Dscho
