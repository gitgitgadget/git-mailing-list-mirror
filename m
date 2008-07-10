From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Thu, 10 Jul 2008 12:51:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807101248360.3135@eeepc-johanness>
References: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org> <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
 <20080709075345.GA22022@glandium.org> <7vhcazlbch.fsf@gitster.siamese.dyndns.org> <20080709085651.GA23453@glandium.org> <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness> <20080710072420.GA5167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 12:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGtl5-00052g-K8
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 12:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbYGJKvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbYGJKvT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 06:51:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:55319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753218AbYGJKvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 06:51:19 -0400
Received: (qmail invoked by alias); 10 Jul 2008 10:51:17 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.253.132]
  by mail.gmx.net (mp027) with SMTP; 10 Jul 2008 12:51:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IwywgiIWID3SsxB2JVocTLUVfXwdd2uy38fYUIf
	B93j2EbY7m3snH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080710072420.GA5167@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87968>

Hi,

On Thu, 10 Jul 2008, Jeff King wrote:

> On Wed, Jul 09, 2008 at 01:43:07PM +0200, Johannes Schindelin wrote:
> 
> > > Note that http://user:pass@server/path/ /should/ work (but that 
> > > would need validation), though not a good idea on command line.
> > 
> > Well, now that the programs using URLs are all builtins, we can 
> > actually do something about it.  We can edit out the "user[:pass]@" 
> > part out of argv, which usually means that "ps" will not see it 
> > anymore.
> 
> Wouldn't there still be a race condition for publicly broadcasting your 
> password via ps?

Yes.  For a brief amount of time, but yes.

BTW I thought I remembered one program xxx'ing out the password via argv, 
but unfortunately I do not remember which one it was.

Anyway, was just an idea.

Ciao,
Dscho
