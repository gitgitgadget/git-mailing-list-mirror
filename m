From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Terminology question: "tracking" branches
Date: Mon, 27 Oct 2008 17:17:36 +0100
Message-ID: <20081027161736.GJ3612@atjola.homenet>
References: <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet> <490030AB.8090207@drmicha.warpmail.net> <4905E1B0.8040601@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 17:19:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuUoD-0000SB-CZ
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 17:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbYJ0QRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbYJ0QRm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 12:17:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:56898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751782AbYJ0QRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 12:17:41 -0400
Received: (qmail invoked by alias); 27 Oct 2008 16:17:38 -0000
Received: from i577B879F.versanet.de (EHLO atjola.local) [87.123.135.159]
  by mail.gmx.net (mp008) with SMTP; 27 Oct 2008 17:17:38 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/fYwkgaU/fszDcZy2uLbR52sbUH0QaJJ6xo7aCaA
	TUqhjsB0lgwCRg
Content-Disposition: inline
In-Reply-To: <4905E1B0.8040601@xiplink.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99241>

On 2008.10.27 11:43:44 -0400, Marc Branchaud wrote:
> Michael J Gruber wrote:
>>
>> remote tracking branch: Synonymous with tracking branch. [remote is =
a
>> noun, an object for track here]
>
> Er, "remote" is an adjective there...  :)

Hm? It's a "branch that tracks (a branch of) a remote". Looks like a
noun to me.

>> [adjective to be found] branch: A local branch which is set up to pu=
ll
>> or rebase automatically from a tracking branch. Used for local
>> modifications to remote branches. [I'm tempted to use local tracking
>> branch here, but that would just add to the confusion.]
>
> I say there's no need for an adjective here, as this is just a plain =
old =20
> branch that git-branch creates by default (right?).

By default, no. It depends on the branch.automergesetup configuration
and whether you create the branch from a remote tracking branch, a loca=
l
branch or some other committish.

autosetupmerge =3D false
----
git branch foo origin/foo   --> --no-track
git branch foo master       --> --no-track
git branch foo origin/foo^0 --> --no-track

autosetupmerge =3D true
----
git branch foo origin/foo   --> --track
git branch foo master       --> --no-track
git branch foo origin/foo^0 --> --no-track

autosetupmerge =3D always
----
git branch foo origin/foo   --> --track
git branch foo master       --> --track
git branch foo origin/foo^0 --> --no-track

> What's needed is an adjective for when git-branch is given the =20
> --no-track option (or when branch.automergesetup is false). =20
> "Non-tracking branch" perhaps?

Isn't that easily confused with "[remote] tracking branch"? Especially
since the "remote" is optional...

Bj=F6rn
