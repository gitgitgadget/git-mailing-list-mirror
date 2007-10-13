From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Fri, 12 Oct 2007 23:04:40 -0400
Message-ID: <20071013030439.GJ27899@spearce.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 05:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgXJC-0005IG-In
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 05:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbXJMDEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 23:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbXJMDEq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 23:04:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47611 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbXJMDEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 23:04:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgXIj-00076C-Mi; Fri, 12 Oct 2007 23:04:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 94AAA20FBAE; Fri, 12 Oct 2007 23:04:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60715>

Jakub Narebski <jnareb@gmail.com> wrote:
> Other
>  * SourceForge / Gna! / Google Projects support
>    (free) hosting with git facilities
>    FOSS hosting sites supporting git

We may find support for Git on SourceForge in the future, but not
on Google Projects anytime soon, if ever.

At the Google Summer of Code Mentor Summit last Saturday Dscho had a
short chat with someone from the Google Code group.  Apparently they
did at least look at Git briefly but concluded that they cannot
implement it on their site as our backend storage database is just
plain files on the local filesystem.

One of the reasons (probably among many but whatever) that I think
Google hired the "SVN guys" as employees is to develop a Google
specific backend for SVN (replaces fsfs and bdb) that stores the
SVN revision data in a Google BigTable cell rather than on the
local filesystem.  This allows Google to efficently manage the
entire site, including distributed replication, hot failover, etc...
BigTable is one of their key technologies at this point.

If you don't know about BigTable but want to know more you can
search for details about it via this awesome search engine I have
heard about: http://www.google.com/ :-)

I've managed to glean enough details on BigTable to know that the
Git backend is *not* easily layered on top of it.  But the SVN
fsfs backend is actually fairly easy to translate into BigTable,
so I imagine it didn't take the "SVN guys" very long to develop
the new backend, test it, and thus deploy SVN onto Google Projects.


Funny aside: If you really want to know about BigTable apparently
you also need to visit (one of?) the men's room in building 43
on the second floor.  There were tutorial posters hanging on the
wall describing how to use BigTable and Sawzall to summerize a
large dataset.  Most pubs hang sports pages from the local paper;
Google hangs BigTable documentation.  Nerds.  All of 'em.

-- 
Shawn.
