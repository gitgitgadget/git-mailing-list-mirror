From: David Soria Parra <sn_@gmx.net>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 12:42:42 +0100
Message-ID: <4905A932.2030506@gmx.net>
References: <ge0rla$mce$1@ger.gmane.org> <200810261955.10536.jnareb@gmail.com>	<200810270147.52490.arne_bab@web.de>	<200810270252.23392.jnareb@gmail.com> <1225100597.31813.11.camel@abelardo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mercurial@selenic.com, git@vger.kernel.org
To: Emanuele Aina <emanuele.aina@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 12:44:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuQWH-0004qP-3o
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 12:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYJ0Lmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 07:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYJ0Lmy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 07:42:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:39717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752500AbYJ0Lmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 07:42:53 -0400
Received: (qmail invoked by alias); 27 Oct 2008 11:42:51 -0000
Received: from krlh-5d857d31.pool.einsundeins.de (EHLO [192.168.1.217]) [93.133.125.49]
  by mail.gmx.net (mp020) with SMTP; 27 Oct 2008 12:42:51 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX18bRrF5liIbknEeb6VWkw/FUCyBKSzbvixh8hdsvC
	HlVcXtT4oLyFkk
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <1225100597.31813.11.camel@abelardo.lan>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99227>

Emanuele Aina schrieb:
> Jakub Narebski precis=C3=B2:
>=20
>>> What do you mean by "cleaner design"?=20
>> Clean _underlying_ design. Git has very nice underlying model of gra=
ph
>> (DAG) of commits (revisions), and branches and tags as pointers to t=
his
>> graph.
>=20
> Just for reference, the abstract history model of Mercurial and GIT i=
s
> the same, a DAG of changesets identified by their cryptographic hash =
as
> designed for Monotone, which can be considered the parent of both.
>=20
> GIT and Mercurial then differs in how this abstract model is written =
to
> disk, with different tradeoffs in terms of performances and how easil=
y a
> specific feature can be implemented, but there is no reason something
> can be done in GIT but not in Mercurial or viceversa.

Yes, it's the same: a DAG  with hashes. But there are limitations due t=
o=20
the implementation (and not the design). Just as a bad and completely=20
useless example (don't start to argue, I know it's nothing someone woul=
d=20
like to have): you cannot force mercurial to merge two revisions and=20
create a merge commit if one is the others ancestor,which is possible i=
n=20
git with git --no-ff. In addition they differ in some other ways:=20
Mercurial doesn't have an index to stage commits, which is something=20
that git has and allows very powerful features (such as git add -i, etc=
).
