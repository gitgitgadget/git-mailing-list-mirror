From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 16:16:25 -0300
Message-ID: <20080828191625.GA17955@khazad-dum.debian.net>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net> <20080828154128.GB13169@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmzx-0002Sg-Mr
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYH1TQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYH1TQd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:16:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36121 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725AbYH1TQc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 15:16:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 56E9815BAB0;
	Thu, 28 Aug 2008 15:16:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 28 Aug 2008 15:16:29 -0400
X-Sasl-enc: w7G+Ar0iR71+7lYC6e0kUGBAWWpTYfaJUiryTAzqpaFs 1219950988
Received: from thorin.khazad-dum.debian.net (unknown [201.82.166.239])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DB53724ECB;
	Thu, 28 Aug 2008 15:16:28 -0400 (EDT)
Received: by thorin.khazad-dum.debian.net (Postfix, from userid 1000)
	id BB9491E943A; Thu, 28 Aug 2008 16:16:25 -0300 (ART)
Content-Disposition: inline
In-Reply-To: <20080828154128.GB13169@diana.vm.bytemark.co.uk>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F
	1CDB 0FE3
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94118>

On Thu, 28 Aug 2008, Karl Hasselstr=F6m wrote:
> On 2008-08-28 11:09:29 -0300, Henrique de Moraes Holschuh wrote:
> > Whatever people told you guys, the sad truth is that for the
> > overwhelming majority of packages, the mere presence of a debian/
> > dir upstream is taken as a warning sign by any seasoned Debian
> > developer (i.e. it is so often a problem, we take it as a bad sign)=
=2E
> > It almost never helps. I have no idea where stgit is in that regard=
,
> > though. And I have NOT checked the "upstream version of the Debian
> > packaging", so please don't take this personally.
> >
> > But I can tell you that most DDs would prefer that upstream dumped
> > the debian/ dir, unless it is kept *really* current. And really, at
> > that point, you are losing a lot of the benefits of a downstream
> > maintainer anyway (i.e. you are not delegating the whole issue to
> > him, so that you can ignore the packaging and just pay attention to
> > stgit itself).
> >
> > Of course, this changes a lot when upstream is also a Debian
> > developer and spends a few hours per week keeping up-to-date with
> > Debian policy and toolset changes, etc.
>=20
> So the optimal solution if we want to carry a debian/ directory (to
> allow users to easily build their own .debs, or whatnot) would maybe
> be to simply politely ask our Debian maintainer to send us patches or
> pull requests to keep it up-to-date?

Yes, but that assumes you release often.  Otherwise users get an old
version of the packaging all the time.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
