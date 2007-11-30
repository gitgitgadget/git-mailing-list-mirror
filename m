From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding push configuration to .git/config
Date: Fri, 30 Nov 2007 01:37:59 +0100
Organization: At home
Message-ID: <finm18$9rk$2@ger.gmane.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de> <7vd4u28z90.fsf@gitster.siamese.dyndns.org> <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de> <Pine.LNX.4.64.0711221120300.27959@racer.site> <20071128221559.GC22395@denkbrett.schottelius.org> <7v1wa8vfee.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 01:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxtuX-0003UK-Dv
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761279AbXK3Ai6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2007 19:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbXK3Ai6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:38:58 -0500
Received: from main.gmane.org ([80.91.229.2]:47901 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760951AbXK3Ai5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:38:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ixtth-0007Pj-Lr
	for git@vger.kernel.org; Fri, 30 Nov 2007 00:38:25 +0000
Received: from abvh222.neoplus.adsl.tpnet.pl ([83.8.205.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:38:25 +0000
Received: from jnareb by abvh222.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:38:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvh222.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66577>

Junio C Hamano wrote:

> IIRC, there was a suggestion to enhance remote.$name configuration in
> this way instead, so that you can use different URL for fetching and
> pushing:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0[branch "foo"]
> =A0 =A0 =A0 =A0 remote =3D "there"
> =A0 =A0 =A0 =A0 merge =3D refs/heads/master
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0[remote "there"]
> =A0 =A0 =A0 =A0 url =3D git://git.there.xz/repo.git
> =A0 =A0 =A0 =A0 push_url =3D git.there.xz:repo.git
> =A0 =A0 =A0 =A0 push_url =3D git.there.xz:backup.git
> =A0=A0=A0=A0=A0=A0=A0=A0fetch =3D refs/heads/*:refs/remotes/there/*
>=20
> I further vaguely recall that the comments on the alternative were
> positive (it might have been you who responded, or somebody else, I d=
o
> not remember).

If I remember correctly one of the suggestions was to allow for multipl=
e
URLs, and for fetch use _first_ one that responds, for push use _all_
that are _possible_ to push to. Or at least support multiple url for
push; this way you would have to configure separate remote for fetch an=
d
for push, but you would have to push only once to push to all repos.

But push_url, or pushURL seems like better idea, IMHO.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
