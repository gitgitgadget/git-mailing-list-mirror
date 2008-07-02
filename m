From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 2 Jul 2008 14:13:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021412300.9925@racer>
References: <20080701101114.GA6379@sigill.intra.peff.net> <1214912674-9443-1-git-send-email-trast@student.ethz.ch> <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org> <20080702080200.GA21367@sigill.intra.peff.net> <7vd4lwemja.fsf@gitster.siamese.dyndns.org>
 <20080702083214.GA22301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2Ct-0001Un-NF
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYGBNPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYGBNPt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:15:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34788 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752185AbYGBNPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:15:49 -0400
Received: (qmail invoked by alias); 02 Jul 2008 13:15:46 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp005) with SMTP; 02 Jul 2008 15:15:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gOxYPfoOgj0ou2etk3thEAARS+k7huYPmS6G0Wa
	ZxT18IW0y+/6uz
X-X-Sender: gene099@racer
In-Reply-To: <20080702083214.GA22301@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87131>

Hi,

On Wed, 2 Jul 2008, Jeff King wrote:

> On Wed, Jul 02, 2008 at 01:08:09AM -0700, Junio C Hamano wrote:
> 
> > > So if the problem is "old perl", I don't think it is an issue. Are 
> > > there modern perl installations in the wild that don't have 
> > > File::Temp?
> > 
> > The thing is, I think I heard quite similar explanation why Test::More 
> > is safe to use when the patch to add t/t9700 was submit.  Then what 
> > happened?
> 
> ISTR the Test::More problem was reported by Linus, who is a Fedora user? 
> I tried searching for any reasonable information on which of the core 
> perl modules are installed by default on Fedora systems, but didn't come 
> up with anything useful.
> 
> I really have no clue as to what is out there, and I suspect we must 
> either play it totally safe, or push the limits and wait for people to 
> complain about breakage.

I wonder why bother trying to import things when you do not need them to 
begin with!  I mean, it is _obvious_ that in this case, we want .git/ to 
be writable _anyway_, so why not stick with a fixed name in that?

Ciao,
Dscho
