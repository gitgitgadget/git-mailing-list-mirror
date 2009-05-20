From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 20 May 2009 18:40:14 +0200
Message-ID: <20090520164014.GU15420@raven.wolf.lan>
References: <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> <20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com> <20090514214120.GR15420@raven.wolf.lan> <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com> <20090515175203.GS15420@raven.wolf.lan> <32541b130905151205h6ca89d85q97e72ce23bf233ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 18:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6oqt-0005pk-Mc
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbZETQlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbZETQlF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 12:41:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:52167 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbZETQlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 12:41:04 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M6oql-0008M6-UJ; Wed, 20 May 2009 18:41:04 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 3909E2CD14; Wed, 20 May 2009 18:40:14 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905151205h6ca89d85q97e72ce23bf233ee@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119619>

On Fri, May 15, 2009 at 03:05:14PM -0400, Avery Pennarun wrote:
> On Fri, May 15, 2009 at 1:52 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > On Thu, May 14, 2009 at 05:57:00PM -0400, Avery Pennarun wrote:
> >> I'd say that basically none of your problems have anything to do w=
ith
> >> svn's lack of merge support, and everything to do with the fact th=
at
> >> you aren't doing all your changes first on a 'public' branch and t=
hen
> >> merging from there into the private branches. =A0(That's really no=
t so
> >> hard to do in svn either, and would save a ton of confusion.)
> >
> > The problem here is that it does not match the work flow. =A0IMHO, =
my work
> > flow is very similar to the work flow of the kernel, so I fail to s=
ee why
> > it can not work. =A0See the analogies:
> >
> > kernel: Submodule maintainers are committing into private repositor=
ies
> > me: =A0 =A0 People are committing into private repositories
> >
> > kernel: Those commits are forwarded to Linus's repository
> > me: =A0 =A0 Those commits are forwarded to the public repository
> >
> > kernel: Maintainers receive commits for other submodules from linus
> > me: =A0 =A0 Commits are distributed from public to private reposito=
ries
>=20
> There is one critical difference here: if someone merges from Linus
> and then Linus merges back from them, then the two resulting
> repositories will be *identical* (at least, the trees will be; if the
> second merge uses --no-ff, the histories will be very slightly
> different, but not importantly so).

Hmm, maybe submodules could be of some help here?  If I put the generic
content into a submodule, and the localized content into (multiple)
superprojects, the kernel work flow should be easy to adopt, or am I
missing something?
