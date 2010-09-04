From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 13:20:42 -0700 (PDT)
Message-ID: <m3tym5mfce.fsf@localhost.localdomain>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
	<AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
	<20100904181405.GB4887@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 04 22:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrzSf-0000N2-42
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 22:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab0IDUfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 16:35:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab0IDUe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 16:34:58 -0400
Received: by fxm13 with SMTP id 13so1908912fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=N7SuvpBUY5nF7MpNHwSVXnfEBSM0w8VIFKNVuU8henQ=;
        b=g6V7HNxvUaN5YSiOxI4mo9DDfUed9x3HTzNy7K2TOS2L5KWoP1QSrPSWhDeyA8dThN
         j1mZd2/4M3ifZnqonuxLKlhZ9B2YTBuUqMYek09exHqBrl0feXz/SLgGlAPq5p6kekp8
         N5y1QuwETbS1pcE04QeLA7P7JJwL3Av8ZQxDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dTPPwhwuUg3SdeMJFKkcTa9thy/6KqGOEpok/4wt6W2eNrCYacmFVMoQ8GM1aAmVCZ
         uI7a4pHAegBB3BrEDsCrQo3YJ2Hho4loU9SUtGOkerDD5fENqEo5lePf3BHnN1IS8vOK
         q/UajF77XPcGpIq9pDZ4/N4asDmlJ3TSADyZ4=
Received: by 10.223.105.76 with SMTP id s12mr12894fao.107.1283631644492;
        Sat, 04 Sep 2010 13:20:44 -0700 (PDT)
Received: from localhost.localdomain (abwp23.neoplus.adsl.tpnet.pl [83.8.239.23])
        by mx.google.com with ESMTPS id a6sm1564883faa.44.2010.09.04.13.20.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 13:20:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o84KJvUr015708;
	Sat, 4 Sep 2010 22:20:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o84KJUET015697;
	Sat, 4 Sep 2010 22:19:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100904181405.GB4887@thunk.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155356>

Ted Ts'o <tytso@mit.edu> writes:
> On Sat, Sep 04, 2010 at 03:50:29PM +0100, Luke Kenneth Casson Leighton wrote:
> > 
> > :)  the legality or illegality isn't interesting - or is a... red
> > herring, being one of the unfortunate anarchistic-word-associations
> > with the concept of "file sharing".  the robustness and convenience
> > aspects - to developers not users - is where it gets reaaally
> > interesting.
> 
> I ask the question because I think being clear about what goals might
> be are critically important.  If in fact the goals is to evade
> detection be spreading out responsibility for code which is illegal in
> some jurisdictions (even if they are commonly used and approved of by
> people who aren't spending millions of dollars purchasing
> congresscritters), there are many additional requirements that are
> imposed on such a system.
> 
> If the goal is speeding up git downloads, then we need to be careful
> about exactly what problem we are trying to solve.
> 
> >  i do not know of a single free software development tool - not a
> > single one - which is peer-to-peer distributed.  just... none.  what
> > does that say??  and we have people bitching about how great but
> > non-free skype is.  there seems to be a complete lack of understanding
> > of the benefits of peer-to-peer infrastructure in the free software
> > community as a whole, and a complete lack of interest in the benefits,
> > too...

Luke, you don't have to be peer-to-peer to be decentralized and
distributed.  People from what I understand bitch most about
centralized (and closed) services.
 
> Maybe it's because the benefits don't exist for many people?  At least
> where I live, my local ISP (Comcast, which is very common internet
> provider in the States) deliberately degrades the transfer of
> peer2peer downloads.  As a result, it doesn't make sense for me to use
> bittorrent to download the latest Ubuntu or Fedora iso image.  It's in
> fact much faster for me to download it from an ftp site or a web site.
> 
> And git is *extremely* efficient about its network usage, since it
> sends compressed deltas --- especially if you already have a base
> responsitory established.  For example, I took a git repository which
> I haven't touched since August 4th --- exactly one month ago --- and
> did a "git fetch" to bring it up to date by downloading from
> git.kernel.org.  How much network traffic was required, after being
> one month behind?  2.8MB of bytes received, 133k of bytes transmitted.

I think the major problem git-p2p wants to solve is if base repository
is *not* established, i.e. the initial fetch / full clone operation.
 
Note that with --reference argument to git clone, if you have similar
related repository, you don't have to do a full fetch cloning a fork
of repository you already have (e.g. you have Linus repo, and want to
fetch linux-next).

> That's not a lot.  And it's well within the capabilities of even a
> really busy server to handle.  Remember, peer2peer only helps if the
> aggregate network bandwidth of the peers is greater than (a) your
> download pipe, or (b) a central server's upload pipe.  And if we're
> only transmitting 2.8MB, and a git.kernel.org has an aggregate
> connection of over a gigabit per second to the internet --- it's not
> likely that peer2peer would in fact result in a faster download.  Nor
> is it likely that that git updates are likely to be something which
> the kernel.org folks would even notice as a sizeable percentage of
> their usable network bandwidth.  First of all, ISO image files are
> much bigger, and secondly, there are many more users downloading ISO
> files than there are developers downloading git updates, and certainly
> relatively few developers downloading full git repositories (since
> everybody genreally tries really hard to only do this once).

Well, full initial clone of Linux kernel repository (or any other
large project with long history) is quite large.  Also, not all
projects have big upload pipe.

Additional problem is that clone is currrently non-resumable (at all),
so if you have flaky web connection it might be hard to do initial
clone.


One way of solving this problem that (as I have heard some projects
use) is to prepare "initial" bundle; this bundle can be downloaded via
HTTP or FTP resumably, or be shared via ordinary P2P like BitTorrent.

The initial pack could be 'kept' (nt subject to repacking); with some
code it could serve as canonical starting packfile for cloning, I
think.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
