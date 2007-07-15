From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 13:48:46 +0200
Message-ID: <469A099E.6060906@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu>	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>	 <46994BDF.6050803@alum.mit.edu> <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, Martin Langhoff <martin.langhoff@gmail.com>,
        Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
        dev <dev@cvs2svn.tigris.org>
To: David Frech <david@nimblemachines.com>
X-From: dev-return-2055-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 13:48:54 2007
Return-path: <dev-return-2055-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IA2ar-0007tx-G0
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 13:48:53 +0200
Received: (qmail 27937 invoked by uid 5000); 15 Jul 2007 11:48:50 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 27926 invoked from network); 15 Jul 2007 11:48:50 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAE6mmUbAbSoIh2dsb2JhbACPPAEBAQgKJw
X-IronPort-AV: i="4.16,540,1175497200"; 
   d="scan'208"; a="77332950:sNHT19161338"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52544>

David Frech wrote:
> I have a modest svn repo (about 800 commits) that contains fifteen or
> so small projects. It started life as a CVS repo, and as the projects
> grew and changed, and as I learned more about CVS, things got moved
> around. Later, when I got interested in svn (in 2005) I converted the
> repo, using cvs2svn. It got a few things wrong - mostly, that it
> thought there was one project in the repo, and created toplevel
> trunk/, branches/, and tags/ directories, and lumped everything below
> these.

I know this tangential to the main point of your post, but BTW
multiproject conversions were added to cvs2svn in release 1.5.

> It took a day and half to get the svn dump parsing right (it's an
> egregiously bad format) but only a couple of hours to write the
> fast-import backend.

I'm surprised you think that; I find the svn dump format quite easy and
straightforward.  (Of course it assumes some Subversionisms, like easy
deep directory copies, which I can imagine would be annoying in other
contexts.)  What don't you like about the format?

> Having done all this, I realized that this is a good way to go.
> Separating, as Michael suggests, the "parsing" part from the "commit
> generating" part, not only makes the tools easier to write, but makes
> them more flexible. If hg or bzr had a git-like fast-import (maybe
> they do) it would take me about 35 minutes to target that instead. And
> in the process I came across some "missing features" in fast-import,
> which Shawn Pearce was able to quickly add.

Yes, fast-import is a very easy-to-write format and looks to be very
well documented.  I don't think that having to write output in
fast-import format would be any kind of a hindrance for such a tool.

Michael
