From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Add support for remote.name.pushurl
Date: Tue, 23 Jun 2009 09:50:16 -0700
Message-ID: <20090623165016.GD11191@spearce.org>
References: <1245547316-10299-1-git-send-email-spearce@spearce.org> <1245547316-10299-2-git-send-email-spearce@spearce.org> <200906211930.43809.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 18:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ9CS-0003Sr-HD
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 18:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZFWQuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 12:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZFWQuO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 12:50:14 -0400
Received: from george.spearce.org ([209.20.77.23]:46856 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbZFWQuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 12:50:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B0F9A381FD; Tue, 23 Jun 2009 16:50:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906211930.43809.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122101>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> s?ndag 21 juni 2009 03:21:56 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> > index 19d31a1..9364e4a 100644
> > --- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> > +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> > @@ -102,7 +102,8 @@ protected void run() throws Exception {
> >  				refSpecs.add(spec.setForceUpdate(true));
> >  		}
> >  
> > -		final List<Transport> transports = Transport.openAll(db, remote);
> > +		final List<Transport> transports;
> > +		transports = Transport.openAll(db, remote, Transport.Operation.PUSH);
> 
> Nit-pick. We usually initialize in one statement. I'll squash that for you.

Actually I did that because otherwise we'd run over 80 columns on
that line.  If you let Eclipse format the code for you, it line
wraps onto a 2nd line anyway.  In such cases I personally just find
this format more readable.  But whatever.
 
-- 
Shawn.
