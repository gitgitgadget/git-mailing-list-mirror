From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 23:15:21 +0200
Message-ID: <20060913211521.GA3336@ugly.local>
References: <45084400.1090906@bluegap.ch> <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com> <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com> <4508724D.2050701@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org
X-From: dev-return-1622-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Wed Sep 13 23:15:37 2006
Return-path: <dev-return-1622-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNc50-0000hT-9I
	for gcvscd-dev@gmane.org; Wed, 13 Sep 2006 23:15:34 +0200
Received: (qmail 17866 invoked by uid 5000); 13 Sep 2006 21:15:32 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 17856 invoked from network); 13 Sep 2006 21:15:32 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAIARCEWLbAICBw4HBh0
X-IronPort-AV: i="4.09,160,1157353200"; 
   d="scan'208"; a="33877436:sNHT16389786"
X-IRONPORT: SCANNED
To: Markus Schiltknecht <markus@bluegap.ch>
Mail-Followup-To: Markus Schiltknecht <markus@bluegap.ch>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org
Content-Disposition: inline
In-Reply-To: <4508724D.2050701@bluegap.ch>
User-Agent: Mutt/1.5.13 (2006-08-16)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26948>

On Wed, Sep 13, 2006 at 11:04:13PM +0200, Markus Schiltknecht wrote:
> Martin Langhoff wrote:
> >One thing that bothers me in the cvs2svn algorithm is
> >that is not stable in its decisions about where the branching point is
> >-- run the import twice at different times and it may tell you that
> >the branching point has moved.
> 
> Huh? Really? Why is that? I don't see reasons for such a thing happening 
> when studying the algorithm.
> 
that's certainly due to some hash being iterated. python intentionally
randomizes this to make wrong assumptions obvious.
there is actually a patch pending to improve the branch source selection
drastically. maybe this is affected as well.

> For sure the proposed dependency-resolving algorithm which does not rely 
> on timestamps does not have that problem.
> 
i think that's unrelated.

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
