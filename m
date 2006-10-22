From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Build in shortlog
Date: Sun, 22 Oct 2006 22:50:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610222248350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <453BA8E9.8010703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Oct 22 22:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkGx-0004G9-Fv
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJVUuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJVUuM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:50:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:40859 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751359AbWJVUuK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 16:50:10 -0400
Received: (qmail invoked by alias); 22 Oct 2006 20:50:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 22 Oct 2006 22:50:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <453BA8E9.8010703@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29788>

Hi,

On Sun, 22 Oct 2006, A Large Angry SCM wrote:

> Johannes Schindelin wrote:
> [...]
> > diff --git a/Makefile b/Makefile
> > index 018dad2..0beda57 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -106,7 +106,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
> >   # CFLAGS and LDFLAGS are for the users to override from the command line.
> >  -CFLAGS = -g -O2 -Wall
> > +CFLAGS = -g -O0 -Wall
> >  LDFLAGS =
> >  ALL_CFLAGS = $(CFLAGS)
> >  ALL_LDFLAGS = $(LDFLAGS)
> > @@ -178,7 +178,7 @@ SCRIPT_SH = \
> [...]
> 
> This part of your patch needs some explanation.

Easy. Too many Czech beer, and not enough sleep. Therefore not enough 
removing debug remnants.

Junio, if you want to apply, could you please edit this part out?

Ciao,
Dscho
