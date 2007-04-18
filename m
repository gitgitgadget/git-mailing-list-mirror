From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 13:32:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704181330450.12094@racer.site>
References: <200704171041.46176.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
 <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
 <20070417235649.GE31488@curie-int.orbis-terrarum.net>
 <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He8Os-0006OH-2W
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 13:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbXDRLcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 07:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422876AbXDRLcb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 07:32:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:33157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422862AbXDRLcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 07:32:16 -0400
Received: (qmail invoked by alias); 18 Apr 2007 11:32:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 18 Apr 2007 13:32:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w7qIaNevwAsHEwHTXdB5SMvglDRQWAy6ppskpVC
	fzFmood0qRP3zH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44889>

Hi,

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
> > As for a usage case:
> > - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
> >   same output)
> > - Copies some file outside of the tree (the user is NOT smart enough,
> >   and resists all reasonable attempts at edumacation)
> > - Modifies said file outside of tree.
> > - Contacts maintainer with entire changed file.
> > - User vanishes off the internet.
> >
> > The entire file he sent if it's CVS, contains a $Header$ that uniquely
> > identifies the file (path and revision), and the maintainer can simply
> > drop the file in, and 'cvs diff -r$OLDREV $FILE'.
> > If it's git, the maintainer drops the file in, and does 'git diff
> > $OLDSHA1 $FILE'.
> 
> I personally hope that the maintainer drops such a non-patch
> that originates from a PEBKAC.

Me, too. Although people really believe strange things. When I asked such 
a guy on another list, if he could send me a patch instead of a complete 
file, he shouted loudly at me that patches were obsolete. Yes. Really. I 
begged to differ, but I guess he still believes that.

Ciao,
Dscho
