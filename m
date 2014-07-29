From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 06:45:24 +0000 (UTC)
Message-ID: <loom.20140729T084120-450@post.gmane.org>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com> <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com> <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 08:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC1AM-0005qr-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 08:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbaG2Gpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 02:45:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:38149 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbaG2Gpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 02:45:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XC1AF-0005ol-LY
	for git@vger.kernel.org; Tue, 29 Jul 2014 08:45:35 +0200
Received: from 46.19.18.182 ([46.19.18.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 08:45:35 +0200
Received: from oystwa by 46.19.18.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 08:45:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.19.18.182 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254396>

brian m. carlson <sandals <at> crustytoothpaste.net> writes:

>=20
> On Mon, Jul 28, 2014 at 05:56:28PM -0700, Michael Migdol wrote:
> > Sorry for error -- I meant: git stash list -p, not git stash -p.
> >=20
> > On Mon, Jul 28, 2014 at 5:38 PM, Michael Migdol <michael-spam <at>
migdol.net> wrote:
> > > I recently upgraded from Ubuntu 13.10 to Ubuntu 14.04.  After doi=
ng so,
> > > "git stash -p" stopped working.  (It apparently is ignoring the -=
p
> > > parameter).  I'm not sure what version I was using previously, bu=
t after
> > > some experimentation, I see that:
> > >
> > > version 1.7.12.2 : stash -p DOES work
> > > version 1.9.3 : doesn't work
> > > version 2.0.3 : doesn't work
>=20
> Under the hood, we do:
>=20
>   git log --format=3D"%gd: %gs" -g "$ <at> " refs/stash --
>=20
> But it looks like git log ignores -p if -g is provided.
>=20

Unfortunately I don't have much to add...

I have a weird issue where `git stash list -p` does not show a diff, bu=
t
`~/usr/bin/git stash list -p` does, for the exact same version of Git.
However, the underlying command does not show a diff in either case,
even though I can tell that is the one being executed (with set -x
inserted into .../libexec/git-stash).

This is so weird that I think it's my system's fault. I have to do some
more digging.

=C3=98sse
