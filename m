From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 17:41:28 +0200
Message-ID: <20080828154128.GB13169@diana.vm.bytemark.co.uk>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjIo-0000Wi-6H
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbYH1PTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbYH1PTp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:19:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4400 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYH1PTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:19:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYjcm-0003cI-00; Thu, 28 Aug 2008 16:41:28 +0100
Content-Disposition: inline
In-Reply-To: <20080828140929.GB3584@khazad-dum.debian.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94068>

On 2008-08-28 11:09:29 -0300, Henrique de Moraes Holschuh wrote:

> Whatever people told you guys, the sad truth is that for the
> overwhelming majority of packages, the mere presence of a debian/
> dir upstream is taken as a warning sign by any seasoned Debian
> developer (i.e. it is so often a problem, we take it as a bad sign).
> It almost never helps. I have no idea where stgit is in that regard,
> though. And I have NOT checked the "upstream version of the Debian
> packaging", so please don't take this personally.
>
> But I can tell you that most DDs would prefer that upstream dumped
> the debian/ dir, unless it is kept *really* current. And really, at
> that point, you are losing a lot of the benefits of a downstream
> maintainer anyway (i.e. you are not delegating the whole issue to
> him, so that you can ignore the packaging and just pay attention to
> stgit itself).
>
> Of course, this changes a lot when upstream is also a Debian
> developer and spends a few hours per week keeping up-to-date with
> Debian policy and toolset changes, etc.

So the optimal solution if we want to carry a debian/ directory (to
allow users to easily build their own .debs, or whatnot) would maybe
be to simply politely ask our Debian maintainer to send us patches or
pull requests to keep it up-to-date?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
