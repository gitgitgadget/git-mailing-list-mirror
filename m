From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 16:53:05 -0400
Message-ID: <20061020205305.GG18019@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<45390168.6020502@utoronto.ca> <20061020172125.GF18019@spearce.org>
	<Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 22:53:23 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1Mm-0004am-LN
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 22:53:20 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb1Me-0005yH-E9; Fri, 20 Oct 2006 21:53:12 +0100
Received: from corvette.plexpod.net ([64.38.20.226])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <spearce@spearce.org>) id 1Gb1Mb-0005yB-So
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 21:53:10 +0100
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
	helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gb1MR-0000vH-9O; Fri, 20 Oct 2006 16:52:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D22B120FB79; Fri, 20 Oct 2006 16:53:05 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - lists.canonical.com
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29537>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 20 Oct 2006, Shawn Pearce wrote:
> > 
> > I renamed hundreds of small files in one shot and also did a few
> > hundered adds and deletes of other small XML files.  Git generated
> > a lot of those unrelated adds/deletes as rename/modifies, as their
> > content was very similiar.  Some people involved in the project
> > freaked as the files actually had nothing in common with one
> > another... except for a lot of XML elements (as they shared the
> > same DTD).
> 
> Heh. We can probably tweak the heuristics (one of the _great_ things about 
> content detection is that you can fix it after the fact, unlike the 
> alternative).
> 
> That said, I've personally actually found the content-based similarity 
> analysis to often be quite informative, even when (and perhaps 
> _especially_ when) it ended up showing something that the actual author of 
> the thing didn't intend.
> 
> So yeah, I've seen a few strange cases myself, but they've actually been 
> interesting. Like seeing how much of a file was just a copyright license, 
> and then a file being considered a "copy" just because it didn't actually 
> introduce any real new code.

Aside from that one strange case I just mentioned I've always seen
the strategy to work very well.  Its never done something I didn't
expect and I've never seen copies or that I didn't expect to see,
knowing what the author of the change did.

So even though I had a little bit of trouble with that rename
situation above I'm _very_ happy with the way Git handles renames.

And the truth is that case above really was quite correct: XML is
very verbose.  When 70% of the file is just required XML to frame
the other 30% of the file's payload its not surprising that files
are considered to be similar when they only differ by a little bit
of payload.
