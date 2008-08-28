From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 21:24:50 +0200
Message-ID: <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	stgit@packages.debian.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYn7z-0004kh-7h
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYH1TYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYH1TYv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:24:51 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:51965 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbYH1TYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:24:50 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 5A231B019C;
	Thu, 28 Aug 2008 21:24:47 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id DC48AB020E;
	Thu, 28 Aug 2008 21:24:45 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A2A3AA003; Thu, 28 Aug 2008 21:24:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828140929.GB3584@khazad-dum.debian.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94120>

On Thu, Aug 28, 2008 at 11:09:29AM -0300, Henrique de Moraes Holschuh wrote:
> (Debian maintainer(s) for stgit added to CC through the generic package
> redirect address).
> 
> On Fri, 22 Aug 2008, Catalin Marinas wrote:
> > 2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> > > Since it is now packaged by Debian is it still necessary to be
> > > maintaining Debian packaging?
> > 
> > This is mainly to make it easier for Debian maintainers. Someone might
> > also want to build a .deb package for a different version or flavour
> > of Debian.
> 
> Well, I happen to be a heavy STGIT user, and also a senior Debian
> developer (I have been a DD for over 10 years), so I am entitled to
> reply to this thread I suppose :-)
> 
> Whatever people told you guys, the sad truth is that for the
> overwhelming majority of packages, the mere presence of a debian/ dir
> upstream is taken as a warning sign by any seasoned Debian developer
> (i.e. it is so often a problem, we take it as a bad sign).  It almost
> never helps.  I have no idea where stgit is in that regard, though.  And
> I have NOT checked the "upstream version of the Debian packaging", so
> please don't take this personally.

In this case, they are mostly in sync, except that lately I have not
been very active on the stgit front (and on the debian front as well
BTW), so that I did not take the time to formalize a set of patches
for integration of the latest changes into stgit.

And most of the problem then boils down to the current package diffs
not being handled as a series of patches, which is quite a shame for
stgit :).  Indeed I had started trying to change that at the very
beginning of my involvment in the package, but finally decided I had
no time for that - and I'm also quite frustrated by the various ways I
have tried to maintain debian packages as patch series, unfortunately
(eg. see my experiment in debian/README.maint in the tau package).  I
still have to come with a decent way of doing that.


> Of course, this changes a lot when upstream is also a Debian developer
> and spends a few hours per week keeping up-to-date with Debian policy
> and toolset changes, etc.

Hey, that's not far of what used to happen :)

Another benefit to having uptodate packaging upstream would be to have
deb snapshots regularly generated, alhough we don't take advantage of
this for the moment.


> I think you guys should CC the Debian developer on any threads about the
> debian/ dir.

I'm on the ml too, but CC'ing never hurts, especially since other
people can subscribe to the address via the Package Tracking System.
