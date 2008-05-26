From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 12:29:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261227440.30431@racer>
References: <20080524043118.GA23118@laptop>  <m3ve142jkc.fsf@localhost.localdomain>  <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>  <200805241259.13132.jnareb@gmail.com> <483A7B1F.1050608@op5.se>  <alpine.DEB.1.00.0805261113050.30431@racer>
  <fcaeb9bf0805260357t2bce7753vab5331bb21d98e4b@mail.gmail.com>  <alpine.DEB.1.00.0805261200330.30431@racer> <fcaeb9bf0805260407r6a1bea23v3861d3c43df01939@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 13:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0auH-0002dy-0w
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 13:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbYEZL3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 07:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbYEZL3d
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 07:29:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:36318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754081AbYEZL3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 07:29:33 -0400
Received: (qmail invoked by alias); 26 May 2008 11:29:31 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp035) with SMTP; 26 May 2008 13:29:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199zSJ19nl99Zr/LAe3IwcppSvCIEGRkfIGqGf1jt
	h2J9jAeLW6HLdL
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0805260407r6a1bea23v3861d3c43df01939@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82923>

Hi,

On Mon, 26 May 2008, Nguyen Thai Ngoc Duy wrote:

> On Mon, May 26, 2008 at 6:00 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 26 May 2008, Nguyen Thai Ngoc Duy wrote:
> >
> >> On Mon, May 26, 2008 at 5:16 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> > Besides, it would be a kludge at best to work _twice_ to find out 
> >> > the search terms, once in the external grep, and a second time in 
> >> > the coloring code.  So I think it should not be done.
> >>
> >> I think if it's GNU grep, just passing it --color, it will grep and 
> >> colorize search terms in one turn.
> >
> > And what tells you that the called grep is GNU grep?
> 
> A newly added macro like HAS_GNU_GREP? Granted it won't work all the
> time. The user who set the macro should know what he is doing. This
> approach is IMHO fine as long as we don't allow color customization.

IMO this is just a kludge that is not even necessary, because the whole 
notion of relying on an external grep's colorization is crap.

The OP has a patch that adds colorization to Git's internal grep code.  
The user specifies "--color" with grep?  Fine, then it's no external grep.  
Full stop.

Just like the original patch implements it.  Nice, simple, and easy.  What 
is so wrong with that?

Ciao,
Dscho
