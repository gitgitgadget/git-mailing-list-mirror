From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 20:53:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706102052450.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <200706101514.14954.johan@herland.net> <Pine.LNX.4.64.0706101952180.4059@racer.site>
 <200706102120.55758.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:56:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxTWT-0007Kl-Bu
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331AbXFJT4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758698AbXFJT4T
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:56:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:47367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758331AbXFJT4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:56:18 -0400
Received: (qmail invoked by alias); 10 Jun 2007 19:56:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 10 Jun 2007 21:56:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+obwYwv26oqxYiV57usUg3wmM/rwe9fSMJ+9gzAh
	bszUvDo73Ai9Cb
X-X-Sender: gene099@racer.site
In-Reply-To: <200706102120.55758.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49762>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> On Sunday 10 June 2007, Johannes Schindelin wrote:
> > On Sun, 10 Jun 2007, Johan Herland wrote:
> > > Small typo here. "core.showannotaions" should be "core.showannotations",
> > > I guess.
> > 
> > Yep. I tested it with "core.shownotes", but decided before sending the 
> > patch that the name would be inconsistent with the rest of the code.
> > 
> > However, as I suggested later, I could imagine that an even better way 
> > could be to have "core.annotationsRef", overrideable by 
> > GIT_ANNOTATIONS_REF, which could possibly even be a list of refs.
> > 
> > BTW I am not married to calling it "annotations". If you like "notes" 
> > better, I'm fine with it.
> 
> No problem. Actually I really wanted to call my first
> proof-of-concept "annotations", and not "notes", but I
> figured it would be confused with the "annotate-as-in-blame"
> concept. Besides there is already a git-annotate command...

Not to forget that note is shorter to type.

Ciao,
Dscho
