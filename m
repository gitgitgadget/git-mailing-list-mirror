From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 13:22:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131321140.30505@racer.site>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <20080213105051.GA26522@coredump.intra.peff.net> <20080213112504.GA26627@coredump.intra.peff.net> <alpine.LSU.1.00.0802131213270.30505@racer.site>
 <m3fxvxc87u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Rhodes, Kate" <masukomi@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHZR-0004Zi-Pt
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYBMNWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbYBMNWD
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:22:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:43465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752153AbYBMNWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:22:00 -0500
Received: (qmail invoked by alias); 13 Feb 2008 13:21:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 13 Feb 2008 14:21:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fOplggoCf7gWumh77lhcHGD1UIVXpWovUmI0+Ka
	8fT7RiTlPzNvjz
X-X-Sender: gene099@racer.site
In-Reply-To: <m3fxvxc87u.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73787>

Hi,

On Wed, 13 Feb 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 13 Feb 2008, Jeff King wrote:
> > >  	}
> > > +	if (!hashcmp(sha1, empty_tree.sha1))
> > > +		return &empty_tree;
> > >  	return NULL;
> > >  }
> > 
> > Heh.  This is cute.  But it is also a bit hard to reference, no?  I mean, 
> > you have to remember the SHA-1 of it...
> > 
> > Maybe {} ?
> 
> Or NULL?

I was talking about a special handling: "{}" is not a valid refname.  But 
"NULL" _is_.  So I wanted to avoid that "NULL" explicitely.

Ciao,
Dscho
