From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 15:59:24 +0200
Organization: At home
Message-ID: <f24gv6$otc$1@sea.gmane.org>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 15:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hms46-0002Uh-Sv
	for gcvg-git@gmane.org; Sat, 12 May 2007 15:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXELNzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbXELNzL
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 09:55:11 -0400
Received: from main.gmane.org ([80.91.229.2]:40849 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285AbXELNzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 09:55:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hms3s-0003Sr-40
	for git@vger.kernel.org; Sat, 12 May 2007 15:55:04 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 May 2007 15:55:04 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 May 2007 15:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47045>

Yann Dirson wrote:

> On Thu, May 10, 2007 at 12:48:05PM -0700, Carl Worth wrote:
>> On Thu, 10 May 2007 21:21:06 +0200, Petr Baudis wrote:
>> > I think you are underestimating stg here.
>>=20
>> Yes, maybe I didn't learn to use it well enough.
>>=20
>> > You can stg init just once per branch (ever), I think.
>>=20
>> I don't have details now, but I know I ran into some difficulty when
>> leaving the extra stg state around.
>=20
> I really think we should have a "stg uninit" command. =A0Note that
> currently "stg branch --delete" on master will just do that instead o=
f
> really deleting the branch, but that is a known bug (#8732 on gna).

It would be also nice to have command to remove applied patches.
Sometimes I'd muck up StGIT stack by rebasing in git. Applied patches
are in repository, but I'm interested in preserving unapplied ones.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
