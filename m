From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Sun, 30 Apr 2006 18:51:54 +0200
Organization: At home
Message-ID: <e32pto$p3a$1@sea.gmane.org>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE> <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Apr 30 18:51:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaF9G-000682-Pq
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 18:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWD3Qve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 30 Apr 2006 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWD3Qvd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 12:51:33 -0400
Received: from main.gmane.org ([80.91.229.2]:12957 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751177AbWD3Qv1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 12:51:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaF8h-000645-U6
	for git@vger.kernel.org; Sun, 30 Apr 2006 18:51:19 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 18:51:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 18:51:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19346>

sean wrote:

> On Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>=20
>=20
>> > the terminology and help make things clear.  We're not storing "Pu=
ll:"
>> > information, we're storing config/remote.$NICK.fetch data.  It's r=
eally
>> > used just by fetch, pull just happens to call fetch.
>>
>> I have no strong feelings either way.
>=20
> Yeah, once you "get" it, it's not a problem; but it's not easy when y=
ou're
> just learning git to separate fetch and pull.  It's made harder if gi=
t
> can't even keep them straight internally. :o/

Well, it could also contain default head we merge to (instead of using =
what
fetch set as FETCH_HEAD, usually current head while fetching), as

=A0=A0=A0=A0=A0=A0=A0=A0pull =3D master:origin:merger

> [...]
>=20
> > The latter should be done, because "git fetch" really is about fetc=
hing,=20
> > not playing games with the config.
>=20
> Then we should also remove the --store option from pull and fetch.=A0=
=A0It
> can be set with git-repo-config.

The --store option is similar to using 'git checkout -b newbranch' as a
shortcut for 'git branch newbranch' followed by 'git checkout newbranch=
'.

--=20
Jakub Narebski
Warsaw, Poland
