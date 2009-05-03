From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 3 May 2009 03:48:26 +0200
Message-ID: <20090503014826.GE6135@atjola.homenet>
References: <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <20090424231632.GB10155@atjola.homenet> <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com> <20090502155348.GB6135@atjola.homenet> <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com> <20090502211110.GC6135@atjola.homenet> <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com> <20090502233232.GD6135@atjola.homenet> <b4087cc50905021810y28ab2019ob99857670383ba46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 03:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0QpG-0005RE-32
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 03:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZECBsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 21:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZECBsb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 21:48:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:41044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751323AbZECBsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 21:48:30 -0400
Received: (qmail invoked by alias); 03 May 2009 01:48:28 -0000
Received: from i59F5A4EE.versanet.de (EHLO atjola.local) [89.245.164.238]
  by mail.gmx.net (mp051) with SMTP; 03 May 2009 03:48:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18sZ3QMu8Esy/Oh703Edi64dMgCeSLylU76AeQKMw
	/fKmfv5WvF1QUP
Content-Disposition: inline
In-Reply-To: <b4087cc50905021810y28ab2019ob99857670383ba46@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118161>

On 2009.05.02 20:10:14 -0500, Michael Witten wrote:
> 2009/5/2 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> >> > Hm, like chapter 7 "Git concepts"?
> >>
> >> That's exactly the problem. It should be in chapter 0.
> >
> > I'm not opposed to re-ordering stuff. Though I often think that hav=
ing
> > commands and concepts "together" is better. =A0Maybe we just need t=
hat
> > twice? Once the plain data model, and once a "hands on" version whe=
re
> > the effects of the commands are described in terms of the data mode=
l.
> >
> > The former "sucks" for those that want to just "dive in" (but might
> > still be happy to get told what their actions do), the latter sucks=
 when
> > you just want to look something up.
>=20
> Indeed. I think the key is to split up the documentation for these 2 =
paths.
>=20
>     http://marc.info/?l=3Dgit&m=3D124058631814726&w=3D2
>=20
> The mixing of the 2 is what makes everyone unhappy.

I'm not sure which part of that email you're referring to (and I'm
getting tired, 3:20am...). I'm just seeing the paragraph where Jeff has
said that we have a split, between the tutorial and the manual. And wha=
t
I tried to said, is that we might need the tutorial to be less of a
"recipe collection", but more of a hands-on introduction that actively
explains the data model and how data is manipulated by using the
commands. And the user manual might become less example oriented,
focussing more on concepts, giving examples in addition. So that we hav=
e
both approaches, hands-on and theoretical, but both keeping the data
model in mind, at least to some extend.

=46or example the "hands on" version might rather create a "toy"
repository than importing an existing project right away, to get a
smaller scope of things to describe at once, and to be able to show e.g=
=2E
full "graphs" of the early repo as it evolves. Users that simply don't
want to care can still skip over the explanations and suffer^Wjust pick
up the commands. You could e.g. say "To create a lightweight tag you us=
e
=2E.., which adds a new reference, while ... adds an annotated tags, wh=
ich
is a real tag object, with a message and a tagger and which can possibl=
y
be signed using your GPG key." And maybe explain the tag object a bit
further.

While the manual might, for example, have a section "Tags" instead of
the current "Creating tags"(*), where the different types of tags are
described, how they fit into the data model, what the different types o=
f
tags mean, and only then give examples how to create them.

Lots of possible work...

Bj=F6rn

(*) Why's that in the "Exploring git history chapter"? Let's see if I
can sort out my local asciidoc problems and find some time to provide
some basic patches for that. Though I still haven't managed to get the
one for the git-push man page done... *sigh*
