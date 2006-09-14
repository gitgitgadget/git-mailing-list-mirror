From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Monotone-devel] cvs import
Date: Wed, 13 Sep 2006 22:30:17 -0400
Message-ID: <20060914023017.GA31889@spearce.org>
References: <45084400.1090906@bluegap.ch> <20060913225200.GA10186@frances.vorpus.org> <1158190921.29313.175.camel@neko.keithp.com> <20060914003242.GA19228@frances.vorpus.org> <9e4733910609131757l7ce4b637oae18b523b1b7f0a4@mail.gmail.com> <20060914015324.GX29625@bcd.geek.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Keith Packard <keithp@keithp.com>,
	dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Git Mailing List <git@vger.kernel.org>
X-From: dev-return-1632-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 04:30:32 2006
Return-path: <dev-return-1632-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNgzn-0005Y0-4Z
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 04:30:31 +0200
Received: (qmail 4314 invoked by uid 5000); 14 Sep 2006 02:30:28 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 4304 invoked from network); 14 Sep 2006 02:30:28 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAEpbCEWBTooeAgkOKg
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26762718:sNHT18541222"
X-IRONPORT: SCANNED
To: Daniel Carosone <dan@geek.com.au>
Content-Disposition: inline
In-Reply-To: <20060914015324.GX29625@bcd.geek.com.au>
Sender: spearce@spearce.org
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - cvs2svn.tigris.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26975>

Daniel Carosone <dan@geek.com.au> wrote:
> On Wed, Sep 13, 2006 at 08:57:33PM -0400, Jon Smirl wrote:
> > Mozilla is 120,000 files. The complexity comes from 10 years worth of
> > history. A few of the files have around 1,700 revisions. There are
> > about 1,600 branches and 1,000 tags. The branch number is inflated
> > because cvs2svn is generating extra branches, the real number is
> > around 700. The CVS repo takes 4.2GB disk space. cvs2svn turns this
> > into 250,000 commits over about 1M unique revisions.
> 
> Those numbers are pretty close to those in the NetBSD repository, and
> between them these probably represent just about the most extensive
> public CVS test data available. 

I don't know exactly how big it is but the Gentoo CVS repository
is also considered to be very large (about the size of the Mozilla
repository) and just as difficult to import.  Its either crashed or
taken about a month to process with the current Git CVS->Git tools.

Since I know that the bulk of the Gentoo CVS repository is the
portage tree I did a quick find|wc -l in my /usr/portage; its about
124,500 files.

Its interesting that Gentoo has almost as large of a repository given
that its such a young project, compared to NetBSD and Mozilla.  :-)

-- 
Shawn.
