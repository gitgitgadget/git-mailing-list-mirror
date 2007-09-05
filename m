From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Wed, 5 Sep 2007 11:15:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709051114340.28586@racer.site>
References: <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com>
 <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site>
 <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
 <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com>
 <Pine.LNX.4.64.0709041324420.28586@racer.site> <Pine.LNX.4.64.0709041356070.28586@racer.site>
 <20070904210200.GA32472@nospam.com> <46DE4B2E.70105@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@wingding.demon.nl, Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISrvU-0001E9-GK
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 12:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbXIEKPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 06:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbXIEKPs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 06:15:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:45354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756669AbXIEKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 06:15:47 -0400
Received: (qmail invoked by alias); 05 Sep 2007 10:15:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 05 Sep 2007 12:15:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+45B0PpGy4DIV21W4lIkcHVIEkh+UQK+TtHLwaFN
	SUdSFfbIiDvk9/
X-X-Sender: gene099@racer.site
In-Reply-To: <46DE4B2E.70105@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57707>

Hi,

On Wed, 5 Sep 2007, Marius Storm-Olsen wrote:

> Rutger Nijlunsing said the following on 04.09.2007 23:02:
> > On Tue, Sep 04, 2007 at 01:57:38PM +0100, Johannes Schindelin wrote:
> > > Now I am utterly confused.  MSDN says
> > > 	FILETIME
> > > 	Contains a 64-bit value representing the number of 100-nanosecond
> > > intervals since January 1, 1601 (UTC).
> > > Hmm.
> > 
> > [Warning: war stories ahead...]
> > If you really, really want to know more:
> > http://search.cpan.org/~shay/Win32-UTCFileTime-1.45/lib/Win32/UTCFileTime.pm
> 
> Thanks, seems like it's the right decision then to ensure that we use UTC
> throughout Git on Windows
> 
> Hannes & Dscho, looks like we should revert 
> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=683775c00d9fb95bcbe4632f95b67a96b902fa59 
> then, and rather apply Dscho's patch for a custom time() implementation. 
> Dscho, was the custom implementation of time() enough to fix the issues 
> for you?

Umm.  I am helplessly overloaded with non-Git work, and just made sure 
that it compiles ;-)  Besides, I did not really understand what I was 
doing; just copying your code to convert from FILETIME to time_t.

Sorry,
Dscho
