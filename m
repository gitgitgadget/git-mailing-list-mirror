From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 23:41:57 +0200
Organization: At home
Message-ID: <ehgoii$1ap$1@sea.gmane.org>
References: <200610221548.42048.andyparkins@gmail.com> <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org> <200610222117.45766.andyparkins@gmail.com> <Pine.LNX.4.64.0610221331571.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 22 23:42:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbl4v-0004Vw-MI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJVVlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 17:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWJVVlx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 17:41:53 -0400
Received: from main.gmane.org ([80.91.229.2]:64465 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750698AbWJVVlw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 17:41:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gbl4o-0004V8-7N
	for git@vger.kernel.org; Sun, 22 Oct 2006 23:41:50 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 23:41:50 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 23:41:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29796>

Linus Torvalds wrote:

> Now, "git show" obviously does exactly what you probably wanted, but =
for=20
> future reference, the "git log" family of commands also take a "numbe=
r of=20
> commits" limiter.
>=20
> So you can also do things like
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git log --cc -1 X
>=20
> and it will actually do something very similar to "git show". It's no=
t=20
> _quite_ identical, but it's close - at least for the special case of =
a=20
> single commit.

And of course this shortcut is not documented. git-log(1) and
git-rev-list(1) talks only about "--max-count=3D<n>", and "-n <n>",
and doesn't talk about possible shortcuts "-n<n>" and "-<n>".
Perhaps because those shortcuts are discouraged?

Additionally you can find "-n <n>" shortcut only further on
the git-rev-list(1).


Patch will follow.

BTW. what does "recursive diff" mean (in git)?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
