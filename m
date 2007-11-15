From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BULLS**T PATCH] Allow Git to work at Insane Bank Corp
Date: Wed, 14 Nov 2007 21:27:59 -0500
Message-ID: <20071115022759.GJ14735@spearce.org>
References: <20071115015227.GA2116@spearce.org> <Pine.LNX.4.64.0711150211360.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 03:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsUSs-0007bR-Du
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 03:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbXKOC2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 21:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbXKOC2F
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 21:28:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48484 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXKOC2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 21:28:04 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsUSL-00068j-VH; Wed, 14 Nov 2007 21:27:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 769E220FBAE; Wed, 14 Nov 2007 21:27:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711150211360.4362@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65046>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 14 Nov 2007, Shawn O. Pearce wrote:
> 
> > For corporate security reasons it is obviously absolutely vital that
> > these Desktop.ini files exist in every directory of every system.
> 
> But seriously, some things like these should make it possible for one of 
> the fastest SCMs in the world (both in performance and in development) to 
> get some serious contracts.

Well, see, you can't actually use Git at Insane Bank Corp because it
wasn't put on the approved list of software.  Furthermore if it was
put on that list it would probably only ever be approved for use on
RedHat Linux, as on Windows there is Microsoft Visual Source Suck
and on Solaris there is Rational ConfusingCase.  All provide the
same function and therefore are exactly suitable for those platforms.

Any deviants get Desktop.ini files where they don't want them.

Keep in mind that Insane Bank Corp has approved the following OS
and database combinations, as they are all the same thing.  Any
mixing/matching is not permitted:

  OS         Database
  ------------------------------
  Windows    Microsoft SQL Server
  Solaris    Oracle
  AIX        IBM DB2
  Linux      MySQL

Because you can do anything that Oracle does with MySQL if Linux
is your OS.  Didn't you know that MySQL understands all of Oracle's
extended SQL syntax?  Silly developers.  :-)
 
> I mean, how does svn cope with something like that?

SVN probably doesn't care.  As in SVN probably only scans the working
directory, which you can tell it to ignore Desktop.ini files in.
When it looks at the SVN/ metadata directory in a checkout it
probably knows exactly what files its going after.  Extra files
don't matter to it.

In the fsfs and bdb backends SVN is probably again only going after
known filenames.  So it probably isn't impacted by extra crap shoved
into the directory.


I'm waiting for the next release of the desktop security software,
the one that adds an extra 1M binary header to the front of every one
of Java source files, because that's the only way they can protect
the data that never should have been on a portable computing device
in the first place.

I can't wait for Java 6 update 4 Special Edition for Insane Bank
Corp version to be rolled out to ignore those headers.  Or for the
Eclipse 3.3.1.1.1 release which will also ignore those headers.

-- 
Shawn.
