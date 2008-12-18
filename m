From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 20:47:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812182046060.6952@intel-tinevez-2-302>
References: <20081217204749.GA18261@janet.wally> <20081218043734.GD20749@coredump.intra.peff.net> <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302> <20081218140411.GB6706@coredump.intra.peff.net> <alpine.DEB.1.00.0812181723340.6952@intel-tinevez-2-302>
 <20081218163654.GR5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Neil Roberts <bpeeluk@yahoo.co.uk>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDOrK-0007NL-HF
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYLRTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYLRTrR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:47:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:54181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752041AbYLRTrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:47:16 -0500
Received: (qmail invoked by alias); 18 Dec 2008 19:47:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 18 Dec 2008 20:47:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191Ex9ECfF1s1qGMfKJ3RF6DRfEvfFNFTK6W0b5ce
	WDcDTP41463rPp
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20081218163654.GR5691@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103485>

Hi,

On Thu, 18 Dec 2008, Miklos Vajna wrote:

> On Thu, Dec 18, 2008 at 05:24:00PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Thu, 18 Dec 2008, Jeff King wrote:
> > 
> > > It _would_ be a nicer workflow to say "I don't want these changes 
> > > yet" and selectively put them elsewhere, test what's in the working 
> > > tree, commit, and then grab some more changes from your stash. But 
> > > we don't have interactive stashing and unstashing yet, which would 
> > > be required for that.
> > 
> > git stash -i... Yes, I'd like that!
> 
> Or git checkout -i?

Frankly, I need to move changes away much more often.  Plus, you could 
have what you wished for with a "git checkout -- <path> && git stash -i".  
It's just that you would move out the changes you would not want yet.

Ciao,
Dscho
