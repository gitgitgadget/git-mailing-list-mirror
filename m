From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:37:03 -0400
Message-ID: <20061018213703.GE19194@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <20061018172945.c0c58c38.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Duffy <cduffy@spamcop.net>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Wed Oct 18 23:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJ6I-0001HX-CL
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbWJRVhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423009AbWJRVhL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:37:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19617 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423007AbWJRVhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:37:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJ60-0004mb-7A; Wed, 18 Oct 2006 17:37:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4B96320E42A; Wed, 18 Oct 2006 17:37:04 -0400 (EDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061018172945.c0c58c38.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29272>

Sean <seanlkml@sympatico.ca> wrote:
> On Wed, 18 Oct 2006 16:04:52 -0500
> Charles Duffy <cduffy@spamcop.net> wrote:
> 
> > Example time!
> > 
> > There's a plugin for Bzr which adds support for Cygwin-compatible 
> > symlink support on Windows. (IIRC, this involves monkey-patching some of 
> > the Python standard library bits).
> > 
> > Now, this is something which is *proposed* as a feature to be merged 
> > into upstream bzr, and it may happen at some point. That said, when I 
> > have a Windows-using coworker who wants to check out a repository that 
> > has symlinks in it (with his win32-native, no-cygwin-required bzr 
> > upstream binary), I don't need to tell him to go download and build bzr 
> > from a third party; instead, I just need to tell him to run a single 
> > command to check out the plugin in question into the bzr plugins folder.
> > 
> >  From an end-user convenience perspective, it's a pretty significant win.
> 
> You'll need a better example than that.  Git has supported a version
> of Cygwin-compatible symlink support on Windows for quite some time.
> And no plugins were needed.

Actually I think the only part of that example that was really
interesting was that Bzr runs natively on Windows and that Bzr's
native method of extending the tool with additional features doesn't
require Cygwin.


Today Git doesn't run natively on Windows.  It runs slowly through
Cygwin, thanks to lots of various overheads in different places.
And due to the crappy disk drive in my Windows box.  :-)

Today Git is typically extended (at least initially in prototyping
mode) through Perl, Python, TCL or Bourne shell scripts.  Although
the first three are available natively on Windows the last requires
Cygwin... and we've had some issues with ActiveState Perl on Windows
in the past too.

-- 
Shawn.
