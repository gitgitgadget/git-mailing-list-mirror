From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Terminology question: "tracking" branches
Date: Mon, 27 Oct 2008 17:28:40 +0100
Message-ID: <20081027162840.GK3612@atjola.homenet>
References: <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet> <490030AB.8090207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 17:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuUyZ-0004VH-6d
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 17:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbYJ0Q2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 12:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbYJ0Q2p
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 12:28:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:39057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753184AbYJ0Q2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 12:28:44 -0400
Received: (qmail invoked by alias); 27 Oct 2008 16:28:42 -0000
Received: from i577B879F.versanet.de (EHLO atjola.local) [87.123.135.159]
  by mail.gmx.net (mp025) with SMTP; 27 Oct 2008 17:28:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18AYrBF4cQA+iryFJXqy7eqDiDHf1bs/ScVZX/S3N
	uDuJMSD76XjQOd
Content-Disposition: inline
In-Reply-To: <490030AB.8090207@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99242>

On 2008.10.23 10:07:07 +0200, Michael J Gruber wrote:
> That leaves open:
>=20
> - What does "remote branch" mean, if it means anything at all? It cou=
ld
> be used for a branch in a remote repository, i.e. the other side of
> fetch/push refspec (remote branch:tracking branch).

I prefer to say "the branch on the remote" there, but that's just to
avoid confusion with "remote tracking branch".

> - How to name a local branch created with --track off of a (remote)
> tracking branch? Local tracking branch? Downstream/work/modification =
branch?

You can also have a local branch that "--track"s another local branch,
so those names look a bit suboptimal to me, but I don't have any better
ideas either :-/ For a second I thought about "pulling branch" but that
doesn't really describe it either, I guess...

> I think that linguistically, the confusion comes from using the noun =
as
> well as the adjective "remote". As an adjective: "remote something"
> cleary is something residing remotely. As a noun it's the config adde=
d
> by "git remote add".
>=20
> Note that the glossary doesn't define remote at all. I'd volunteer
> changing that once the discussion reaches a consensus.
>=20
> My suggestion would be:
>=20
> remote (noun): A configuration as created by "git remote add" which
> points to a remote repository (using a URL) and sets up refspecs for
> fetching and/or pulling. Note that the URL may point to a local
> filesystem or even ".". See also remote (adjective).
>=20
> remote (adjective): Anything residing in another repository. See also
> remote (noun).
>=20
> local: Sometimes used to emphasize things residing "locally", i.e. in
> the repository at hand, as opposed to "remotely".
>=20
> tracking branch: A branch tracking a (remote) branch on a remote
> repository, i.e. a local branch stored under refs/remotes/ which is a
> "copy" of a branch on a remote repository; typically created by "git
> clone" or "git remote add/update".
>=20
> remote tracking branch: Synonymous with tracking branch. [remote is a
> noun, an object for track here]

Those look good, to me at least.

> [adjective to be found] branch: A local branch which is set up to pul=
l
> or rebase automatically from a tracking branch.

"merge or rebase", and instead of "tracking" it should be "another" I
think. Again, because you can also --track a local branch.

> Used for local modifications to remote branches. [I'm tempted to use
> local tracking branch here, but that would just add to the confusion.=
]

Same here, it doesn't apply to "remote branches" only.

> Come to think of it: "Off-track" branch would be the ideal name for a
> local branch created off of a (remote) tracking branch, using --track=
 to
> specify the track where things go off. But I'm not sure everyone woul=
d
> like the implied pun...

Haha :-)

thanks,
Bj=F6rn
