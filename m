From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: CVS -> SVN -> Git
Date: Thu, 19 Jul 2007 14:02:07 +0200
Message-ID: <469F52BF.8050300@bluegap.ch>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu>	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>	 <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com> <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, Michael Haggerty <mhagger@alum.mit.edu>,
  Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
  dev <dev@cvs2svn.tigris.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: dev-return-2065-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Jul 19 14:02:41 2007
Return-path: <dev-return-2065-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IBUiN-0000yd-Ds
	for gcvscd-dev@gmane.org; Thu, 19 Jul 2007 14:02:39 +0200
Received: (qmail 4510 invoked by uid 5000); 19 Jul 2007 12:02:37 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 4496 invoked from network); 19 Jul 2007 12:02:37 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAJbvnkZYxjr4/2dsb2JhbAA
X-IronPort-AV: i="4.16,556,1175497200"; 
   d="scan'208"; a="62465807:sNHT63489811"
X-IRONPORT: SCANNED
User-Agent: Icedove 1.5.0.12 (X11/20070607)
In-Reply-To: <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52977>

Hi,

Martin Langhoff wrote:
> cvs2svn has all the "wtf-did-cvs-mean-by-that" algorithms that are
> very hard to write and maintain, and it seems to be the best one at
> that. Of course, it also writes SVN repos -- but I'm sure that's the
> easiest part.
> 
>     We don't need no meta VCS for any of this.

Sure, we certainly need a meta format of some sort (not a full blown 
VCS, agreed, but somehow we need to represent commits, tags and 
branches). And IMO, the subversion based format is not a good one, 
because it treats branches and tags very different from most other 
systems (and from what it should be from a users perspective: an atomic 
operation).

We (Michael, Oswald and me) have discussed joining efforts of my cvs to 
monotone converter, but I quickly dropped that idea because the cvs2svn 
converter is too subversion specific. If cvs2svn wants to become a 
universal cvs importer, it needs to get rid of those assumptions (and do 
more work to unify tagging and branching).

Regards

Markus
