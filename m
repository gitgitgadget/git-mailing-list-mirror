From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 21:55:24 +0200
Message-ID: <20080828195524.GI4985@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net> <20080828154128.GB13169@diana.vm.bytemark.co.uk> <20080828191625.GA17955@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnbb-0006ef-Kl
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYH1TzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYH1TzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:55:25 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:60582 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYH1TzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:55:25 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 208A31724F;
	Thu, 28 Aug 2008 21:55:23 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 24B62196F5;
	Thu, 28 Aug 2008 21:55:22 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1AF3CA003; Thu, 28 Aug 2008 21:55:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828191625.GA17955@khazad-dum.debian.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94126>

On Thu, Aug 28, 2008 at 04:16:25PM -0300, Henrique de Moraes Holschuh w=
rote:
> On Thu, 28 Aug 2008, Karl Hasselstr=F6m wrote:
> > On 2008-08-28 11:09:29 -0300, Henrique de Moraes Holschuh wrote:
> > > Whatever people told you guys, the sad truth is that for the
> > > overwhelming majority of packages, the mere presence of a debian/
> > > dir upstream is taken as a warning sign by any seasoned Debian
> > > developer (i.e. it is so often a problem, we take it as a bad sig=
n).
> > > It almost never helps. I have no idea where stgit is in that rega=
rd,
> > > though. And I have NOT checked the "upstream version of the Debia=
n
> > > packaging", so please don't take this personally.
> > >
> > > But I can tell you that most DDs would prefer that upstream dumpe=
d
> > > the debian/ dir, unless it is kept *really* current. And really, =
at
> > > that point, you are losing a lot of the benefits of a downstream
> > > maintainer anyway (i.e. you are not delegating the whole issue to
> > > him, so that you can ignore the packaging and just pay attention =
to
> > > stgit itself).
> > >
> > > Of course, this changes a lot when upstream is also a Debian
> > > developer and spends a few hours per week keeping up-to-date with
> > > Debian policy and toolset changes, etc.
> >=20
> > So the optimal solution if we want to carry a debian/ directory (to
> > allow users to easily build their own .debs, or whatnot) would mayb=
e
> > be to simply politely ask our Debian maintainer to send us patches =
or
> > pull requests to keep it up-to-date?
>=20
> Yes, but that assumes you release often.  Otherwise users get an old
> version of the packaging all the time.

Well, stgit does not require so much packaging change for each
release.  The current debian/ dir in the git repo, while not 100%
uptodate, still allows anyone to build snapshots.

Best regards,
--=20
Yann
