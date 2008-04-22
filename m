From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 14:49:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:51:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoItV-0006kb-7K
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbYDVNtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYDVNtf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:49:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:49784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756507AbYDVNte (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:49:34 -0400
Received: (qmail invoked by alias); 22 Apr 2008 13:49:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp041) with SMTP; 22 Apr 2008 15:49:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TSsgGcLeTAqKoNuQ01WnMCvI5rOYDXS0Jis89x3
	rPvkWmoxiKdKae
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422133926.GB3098@mithlond.arda.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80119>

Hi,

On Tue, 22 Apr 2008, Teemu Likonen wrote:

> Johannes Schindelin wrote (2008-04-22 13:56 +0100):
> 
> > With the --mirror mode, you can no longer discern clearly between
> > local and remote branches.  This is basically what we had in the
> > beginning, before the "separate remotes layout".
> 
> Hmm, to me it looks like --mirror is for mirroring remote repository and 
> hence the "+" makes sense in here too. It's like "I want to make my 
> repository a copy of that remote repository" hence the name 'mirror'. 
> It'll possibly overwrite local branches but in my way of thinking 
> mirroring implies that possibility. The 'git remote' manual says that 
> --mirror "only makes sense in bare repositories", so the manual seems to 
> guide towards not having local working directory nor changes.

Okay, how about this: take Peff's patch, but add a warning if --mirror is 
used on a non-bare repository?

Ciao,
Dscho
