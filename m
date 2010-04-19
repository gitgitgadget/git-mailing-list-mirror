From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 13:57:27 +0200
Message-ID: <20100419115727.GB10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com>
 <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com>
 <20100418021223.GP10939@machine.or.cz>
 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
 <20100418223120.GB3563@machine.or.cz>
 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 13:57:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3pbb-00068Q-8d
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 13:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836Ab0DSL5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 07:57:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32948 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab0DSL53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 07:57:29 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4B43486208E; Mon, 19 Apr 2010 13:57:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145291>

On Mon, Apr 19, 2010 at 12:16:31PM +0530, Pavan Kumar Sunkara wrote:
> On Mon, Apr 19, 2010 at 4:01 AM, Petr Baudis <pasky@suse.cz> wrote:
> > Frankly, I'm not very excited from this. First, I recommend that yo=
u
> > completely separate splitting of gitweb to smaller pieces (without =
any
> > major conceptual changes) both in the proposal and in actual
> > submissions.
> >
> > Second, you should justify the introduction of session management a=
nd
> > templating. What is the point and why is it neccessary for your pro=
ject
> > goals?
> >
>=20
> Session management reduces the length of URL and templating reduces
> the amount of HTML in the actual code.

=2E..which is bad?

I don't see the value in session management; making the URL contain les=
s
information is not _good_, it is _very_ _bad_, since you can't use the
Uniform Resource Locator to locate resources anymore.

Introduction of templating would mean huge changes (not only addition o=
f
the templater) for seemingly no warranted reason. I mean, if we were to
start writing gitweb from scratch, perhaps a templater engine *might*
warrant some consideration, but I don't see any itch we want to scratch
by introducing templating now. And no connectoin with the project at
hand.

> >> b) Write modules of the client:
> >> =A015. Search for a part of code [git grep]
> >
> > This is already supported by gitweb. And it's not a "write" operati=
on.
> > ;-)
>=20
> I wrote it here because I would like to integrate it with content
> history browser functionality later.

I don't understand, can you elaborate?

> >> c) Read modules of the client: (most of this need not be written, =
just
> >> need to be organised)
> >>
> >> =A0 1. See the status of repository [git status]
> >
> > How will you integrate this with the existing 'tree' action?
>=20
> No, there will be a seperate page for it which executes git status co=
mmand.

And just passes through its plaintext output? Well, I suppose that coul=
d
do for starters.

> > --
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr=
 "Pasky" Baudis
> > http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
> >
>=20
> Please ask me if you have any other doubts regarding this proposal.

Could you clarify your attitude to the support for mode without checked
out working copy, using just the index, that we are discussing with
Jakub and I already mentioned to you in the past?

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
