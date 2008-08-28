From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 11:09:29 -0300
Message-ID: <20080828140929.GB3584@khazad-dum.debian.net>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	stgit@packages.debian.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiCt-0000vY-1u
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYH1OJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbYH1OJe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:09:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51675 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbYH1OJd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 10:09:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A68BF15A6FC;
	Thu, 28 Aug 2008 10:09:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 28 Aug 2008 10:09:32 -0400
X-Sasl-enc: cytxgk9kS+Woy/b6wVBzvTCvozdXsCD8JwqNDGUZmAtP 1219932572
Received: from thorin.khazad-dum.debian.net (unknown [201.82.166.239])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4336A22D8E;
	Thu, 28 Aug 2008 10:09:32 -0400 (EDT)
Received: by thorin.khazad-dum.debian.net (Postfix, from userid 1000)
	id 4177E1E93F2; Thu, 28 Aug 2008 11:09:29 -0300 (ART)
Content-Disposition: inline
In-Reply-To: <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F
	1CDB 0FE3
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94058>

(Debian maintainer(s) for stgit added to CC through the generic package
redirect address).

On Fri, 22 Aug 2008, Catalin Marinas wrote:
> 2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> > Since it is now packaged by Debian is it still necessary to be
> > maintaining Debian packaging?
> 
> This is mainly to make it easier for Debian maintainers. Someone might
> also want to build a .deb package for a different version or flavour
> of Debian.

Well, I happen to be a heavy STGIT user, and also a senior Debian
developer (I have been a DD for over 10 years), so I am entitled to
reply to this thread I suppose :-)

Whatever people told you guys, the sad truth is that for the
overwhelming majority of packages, the mere presence of a debian/ dir
upstream is taken as a warning sign by any seasoned Debian developer
(i.e. it is so often a problem, we take it as a bad sign).  It almost
never helps.  I have no idea where stgit is in that regard, though.  And
I have NOT checked the "upstream version of the Debian packaging", so
please don't take this personally.

But I can tell you that most DDs would prefer that upstream dumped the
debian/ dir, unless it is kept *really* current.  And really, at that
point, you are losing a lot of the benefits of a downstream maintainer
anyway (i.e. you are not delegating the whole issue to him, so that you
can ignore the packaging and just pay attention to stgit itself).

Of course, this changes a lot when upstream is also a Debian developer
and spends a few hours per week keeping up-to-date with Debian policy
and toolset changes, etc.

> > Having a look at the Debian version, they have made quite a few changes
> > against our packaging.  It might be worth getting some patches from
> > them that are not specific to Debian policy (like the setup of bash
> > completion).
> 
> I don't follow the Debian package much but I'll have a look to see the
> differences.

I have looked at it once or twice.  From what I recall, it is mostly
trying to make sure the tree is *really* clean, and moving some files to
where Debian wants them.  Also, it breaks the stuff into two packages,
stgit and stgit-contrib, and updates a lot of the packaging metadata.

I think you guys should CC the Debian developer on any threads about the
debian/ dir.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
