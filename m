From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] revisions: refactor init_revisions and 
 setup_revisions.
Date: Tue, 8 Jul 2008 13:43:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807081339270.4319@eeepc-johanness>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org> <alpine.DEB.1.00.0807081258010.4319@eeepc-johanness> <20080708110624.GF19202@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGBc9-00056u-Br
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbYGHLnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbYGHLnK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:43:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:33833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754306AbYGHLnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:43:09 -0400
Received: (qmail invoked by alias); 08 Jul 2008 11:43:07 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp013) with SMTP; 08 Jul 2008 13:43:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195tmUFZsV5fuZQmNl95C24Hvfl3pHbyy6b135Em4
	WHwOThuWA4nBk4
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080708110624.GF19202@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87753>

Hi,

On Tue, 8 Jul 2008, Pierre Habouzit wrote:

> On Tue, Jul 08, 2008 at 10:59:43AM +0000, Johannes Schindelin wrote:
> 
> > On Tue, 8 Jul 2008, Pierre Habouzit wrote:
> > 
> > > setup_revisions has been split in two: parse_revisions that does 
> > > (almost) only argument parsing, to be more like what parse-options 
> > > can do, and setup_revisions that does the rest.
> > 
> > I do not see the sense of this change, except
> 
> Well, it's required to remove "parse_revisions" at once if we one day 
> reach the goal of having only parse-opt based parsers.

We can do that, then.

We do not need to do that, now.

In the meantime, your patch series of already pretty large patches gets 
even larger, which prevents me from being able to review them.

Sad,
Dscho

P.S.: Please do not pull things at me like "it is so convenient to be able 
to drop "0, NULL, " for many sites".  That is not even funny.  This case 
does not need more convenience.  The other cases do.
