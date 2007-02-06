From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] enable rerere by default
Date: Tue, 6 Feb 2007 16:03:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:04:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HERrc-0002V6-Re
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbXBFPEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXBFPEA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:04:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:41222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751651AbXBFPEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:04:00 -0500
Received: (qmail invoked by alias); 06 Feb 2007 15:03:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 06 Feb 2007 16:03:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38847>

Hi,

On Tue, 6 Feb 2007, Alex Riesen wrote:

> On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > Since the theme of the upcoming release is the (true) Wow factor, we
> > should enable this feature by default. New users are not likely to learn
> > of that feature otherwise.
> > 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > 
> >         I know it is quite late in the game for 1.5.0, but since the theme
> >         is usability and user-friendliness, I cannot think of a better
> >         release to enable rerere by default, if that should ever happen.
> > 
> >         Comments?
> 
> How do I disable rerere by default?

How'd you like it? Should this rather become a config variable, or do you 
want to make a file called "rr-cache" in the templates, which just 
contains a word "disabled"? (git-rerere checks if a _directory_ 
$GIT_DIR/rr-cache exists.)

Ciao,
Dscho
