From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 08:28:16 +0200
Message-ID: <20090930062816.GA27901@atjola.homenet>
References: <h9nlhj$heq$1@ger.gmane.org>
 <m33a66br69.fsf@localhost.localdomain>
 <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
 <200909292058.53045.jnareb@gmail.com>
 <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 08:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mssft-0005or-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 08:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZI3G2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 02:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZI3G2T
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 02:28:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:42623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbZI3G2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 02:28:18 -0400
Received: (qmail invoked by alias); 30 Sep 2009 06:28:20 -0000
Received: from i59F574C1.versanet.de (EHLO atjola.homenet) [89.245.116.193]
  by mail.gmx.net (mp053) with SMTP; 30 Sep 2009 08:28:20 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19MQRA3MzdMBc8aec+n6ectV9gWTUCbf9VarsNTFI
	a/U/cyE149MXdJ
Content-Disposition: inline
In-Reply-To: <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129331>

On 2009.09.29 20:49:52 -0400, Leo Razoumov wrote:
> On 2009-09-29, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Tue, 29 Sep 2009, Leo Razoumov wrote:
> >  > On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:
> >  > > [..snip..]
> >  > >  Besides with nonlinear history with
> >  > >  revision numbers such as 12678 and 12687 you know that 12678 =
is older
> >  > >  than 12687 if and only if 12678 and 12687 are on the same lin=
e of
> >  > >  development.
> >  >
> >  > The statement above is incorrect!! In a Mercurial repo local rev=
ision
> >  > numbers are strictly ordered in commit time. 12678 < 12687 means=
 that
> >  > 12678 was committed prior to 12687. But these two commits could =
belong
> >  > to two completely unrelated lines of development.
> >
> > This is impossible with distributed development.  If the second bra=
nch
> >  comes from other repository, with commits _created_ (in that repos=
itory)
> >  earlier than commits in current repository, but commits in first
> >  branch (from current repository) were created earlier than _fetchi=
ng_
> >  those commits in second branch:
> >
> >   .---.---.---.---x---1---2---3---M---.
> >                    \             /
> >                     \-A---B---C-/             <-- from repository B
> >
> >
> >  Either you would have to change commits numbers, and therefore the=
y would
> >  be not stable, or you would have to change commit time to mean 'ti=
me this
> >  commit got into current repository', which would kill performance =
for sure.
> >
>=20
> Jakub,
> in Mercurial sequential commit numbers are local to a repo and are no=
t
> unique between the clones. Unique ID is SHA1 as in git. So mercurial
> commit 127:aaf123453dfgdfgddd...
> means commit number 127 in this repo with SHA1 "aaf123453dfgdfgddd...=
"
> In another clone commit 127 might mean completely different thing.
> Sequential commit numbers are strictly for "local convenience".

To quote his first mail:
	First, you have to remember that this 'number of commit' thingy
	is *local* to your repository, so you cannot use commit numbers
	to communicate with other developers.

With the above example, he has just shown that even with those local
commit numbers, you can't tell that commit X is older than commit Y jus=
t
because X < Y.

Bj=F6rn
