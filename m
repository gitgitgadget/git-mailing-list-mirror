From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 12:19:00 -0700
Message-ID: <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
References: <20101022183027.GA12124@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9N9J-0006hY-QW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759306Ab0JVTTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 15:19:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65272 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759068Ab0JVTTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 15:19:22 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so1268021iwn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 12:19:22 -0700 (PDT)
Received: by 10.231.11.72 with SMTP id s8mr933533ibs.172.1287775162420; Fri,
 22 Oct 2010 12:19:22 -0700 (PDT)
Received: by 10.231.140.97 with HTTP; Fri, 22 Oct 2010 12:19:00 -0700 (PDT)
In-Reply-To: <20101022183027.GA12124@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159736>

On Fri, Oct 22, 2010 at 11:30 AM, Jeff King <peff@peff.net> wrote:
> There is one slight caveat, which is that JGit was not accepted, due =
to
> the complexity of their ties with the Eclipse Foundation.

Yup.  Anytime you say "Eclipse Foundation", make sure you put
"complexity" into the same sentence.  Its required to make the
sentence accurate.  :-)

> In practice, I
> don't think this will matter much at all. The only way that Git opera=
tes
> in any legal capacity as a group is when we do Summer of Code. This
> could impact us, e.g., if were to have a JGit-specific SoC project.

We had a GSoC project, but through the Eclipse Foundation
participation in GSoC, not Git.  So the Eclipse Foundation received
our mentor stipend for us, and will spend it in some way that is
unknown to me.  Yay?

The decision to do JGit GSoC through Eclipse and not through Git this
year wasn't really mine.  I just didn't disagree loud enough to change
things.

> Probably the money that goes to the organization for such a project
> should _not_ go through the SFC, and would have to be handled
> separately. Which is no worse than JGit has it today; they just can't
> receive the SFC services as regular git can.

This is fine with the JGit folks, for now anyway.  We may revisit this
and have JGit join SFC at some point in the future.  We might not.

> Basically what we need to decide on before signing is:
>
> =A01. Who should sign? These people are basically speaking for git as=
 a
> =A0 =A0 community. Related to (2) below.

The people listed in 2 as the leadership structure of git.

> =A02. What is the leadership structure of git as a legal entity? In o=
ther
> =A0 =A0 words, if we get some money that goes to the SFC (from SoC or=
 from
> =A0 =A0 donations), who should have authority to tell the SFC to do
> =A0 =A0 something with it?
>
> =A0 =A0 The obvious choices (to me) are:
>
> =A0 =A0 =A0 a. Junio as benevolent dictator^W maintainer.
>
> =A0 =A0 =A0 b. Somebody else as benevolent SFC liaison.
>
> =A0 =A0 =A0 c. Some committee of core people (I'd say no more than 3-=
5) who
> =A0 =A0 =A0 =A0 =A0would all need to agree (or perhaps some majority)=
=2E
=2E..
> =A0 =A0 Personally, I favor a small group which can approve new peopl=
e to
> =A0 =A0 join, and which can leave at will. Having more than one perso=
n
> =A0 =A0 avoids hit-by-bus problems (or even just dropped-off-net prob=
lems).
> =A0 =A0 There is little enough power in such a position that I'm not =
too
> =A0 =A0 worried about some crazed egomaniac becoming the Git-SFC liai=
son.

I agree.

I think a committee of at least 3 people and at most 5, any of whom
can be a benevolent SFC liasion, is fine.  As far as selection goes,
the committee can elect or remove a member through a majority vote,
and should base its decisions based on surviving contributions to the
code base, but shouldn't be tied to that (just in case someone
contributes a lot of good code and then becomes a jerk).

But as you point out, there isn't much power involved here, so there
isn't a lot of concern of it being abused.  The important thing (the
copyright on the code) is still held by individual contributors, so
there is very little value involved (just the handful of GSoC dollars
each year).

> =A03. How much money should we give to the SFC?
>
> =A0 =A0 A big chunk of their budget comes from taking a percentage of
> =A0 =A0 member project money. As a project, we set the percentage we =
give
> =A0 =A0 them. So we can give them nothing if we want. But they do pro=
vide
> =A0 =A0 useful services, and even without direct benefit to git, the =
SFC is
> =A0 =A0 promoting free software. So probably it makes sense to choose=
 some
> =A0 =A0 non-zero number.

I agree, a non-zero number.  2-5%?  Any idea what is typical?

--=20
Shawn.
