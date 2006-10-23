From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 15:02:59 -0400
Message-ID: <20061023190259.GA7845@spearce.org>
References: <45357CC3.4040507@utoronto.ca> <200610232021.55625.jnareb@gmail.com> <1161628001.27312.8.camel@charis.lan.vernstok.nl> <200610232031.12399.jnareb@gmail.com> <Pine.LNX.4.64.0610231134450.3962@g5.osdl.org> <1161629801.27312.22.camel@charis.lan.vernstok.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 21:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc557-0002ST-Ow
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWJWTD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWJWTD0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:03:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55003 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965022AbWJWTDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 15:03:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gc54Y-0001Dv-1J; Mon, 23 Oct 2006 15:02:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE46121269E; Mon, 23 Oct 2006 15:02:59 -0400 (EDT)
To: Jelmer Vernooij <jelmer@samba.org>
Content-Disposition: inline
In-Reply-To: <1161629801.27312.22.camel@charis.lan.vernstok.nl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29862>

Jelmer Vernooij <jelmer@samba.org> wrote:
> On Mon, 2006-10-23 at 11:45 -0700, Linus Torvalds wrote:
> > On Mon, 23 Oct 2006, Jakub Narebski wrote:
> > > The place for timestamp and commiter info is in the revision metadata
> > > (in commit object in git). Not in revision id. Unless you think that
> > > "accidentally the same" doesn't happen...
> > Well, git and bzr really do share the same "stable" revision naming, 
> > although in git it's more indirect, and thus "covers" more.
> > 
[snip]
> > So you could more easily _fake_ a commit name in bzr, and depending on how 
> > things are done it might be more open to malicious attacks for that reason 
> > (or unintentionally - if two people apply the exact same patch from an 
> > email, and take the author/date info from the email like hit does, you 
> > might have clashes. But with a 64-bit random number, that's probably 
> > unlikely, unless you also hit some other bad luck like having the 
> > pseudo-random sequence seeded by "time()", and people just _happen_ to 
> > apply the email at the exact same second).
> Bzr stores a checksum of the commit separately from the revision id in
> the metadata of a revision. The revision is not used by itself to check
> the integrity of a revision.

I think Linus' original point here was that if you communicate the
revision id to another person and they fetch that revision there
is no assurance that the commit they have received is the exact
same commit you had.

In Git that assurance is implicitly present as the unique
identification you communicated to the other person is also that
integrity verification.  Therefore its nearly impossible to spoof.

-- 
Shawn.
