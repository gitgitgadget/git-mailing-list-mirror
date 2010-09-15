From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Wed, 15 Sep 2010 13:10:26 +0200
Message-ID: <4C90A9A2.5050705@drmicha.warpmail.net>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, avarab@gmail.com,
	git <git@vger.kernel.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Sep 15 13:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovpsn-00035O-2b
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 13:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab0IOLK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 07:10:27 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58258 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727Ab0IOLK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 07:10:27 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 60F57442;
	Wed, 15 Sep 2010 07:10:23 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 15 Sep 2010 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Mw8tQAdHjlQ6OzuVjw6qyM78XEk=; b=qWN5U+CDhkbAvQk92GcPl88gHJV23n2moMo0LFwOIilO5WOVbknpKJW05/N56YgzflzqulGdNdYJFIaKw3QAg+9EdfJV6Vy4TCp+OMf9Pxc0eTi3d78mkffNi0R8/5j6Q49LPt2YTYTyT1tJ9hPurx5si8J1BiwBfdoD4gTWNyc=
X-Sasl-enc: OovqyYX+feOTRx9h5jYZkZH8Xsx6x/xrMKATUsyFCDoz 1284549022
Received: from localhost.localdomain (p54858CAD.dip0.t-ipconnect.de [84.133.140.173])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E040D5E5443;
	Wed, 15 Sep 2010 07:10:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156229>

Christian Stimming venit, vidit, dixit 15.09.2010 09:33:
> Dear Thomas, Jan, et al.,
>=20
> thanks for the discussion of an initial git translation to German. I =
=20
> appreciate the efforts to translate not only the gui tools of git, bu=
t =20
> also the command line commands as well. I completely agree with =20
> Thomas' proposal to discuss and agree on a glossary of terms *first*,=
 =20
> and *secondly* preparing the actual translation - otherwise it will b=
e =20
> impossible to create a consistent translation.

I've been holding back a post titled "Halt the l10n madness" in my
mental drafts folder for a while, and I'm happy the issue has been
raised now. I guess I'm not the only one passing (out) on seeing "PATCH
0/159"...

I totally agree on the glossary first approach. I'm just seeing that th=
e
actual translations do not undergo much discussion, and I hope that it
would be different for a glossary.


>>  branch                Branch (m.)
>=20
> I'd go for "Zweig". It's even on the wikipedia page and it perfectly =
=20
> represents the concept.

+1

Zweig, of course, what else? :)

The main abstract concept underlying not only Git's revision control is
that of a direct acylcic graph (DAG). There are established translation=
s
for that concept in combinatorics, which we should follow.

>=20
>>  index                 Index
>=20
> I'd strongly vote for not using "Index". The "Index" is where the =20
> "Bundespr=FCfstelle f=FCr jugendgef=E4hrdende Schriften" puts the =20
> Ballerspiele on. Don't let the identical word fool you into thinking =
=20
> this is a worthwhile translation. Also, the English term is a bad =20
> naming anyway IMHO. I'd use git-gui's replacement (staging area) and =
=20
> use "Bereitstellung" here as well. Feel free to propose something =20
> different, but please not "Index". Git isn't FSK18.

This reasoning - while certainly entertaining - reflects a very limited
view on German vocabulary. I don't think the Bundespr=FCfstelle has bee=
n
around in the 19th century when (or earlier) this word made it into the
German language.

In fact, "Index" is a "Verzeichnis" (in the sense of registry), and its
latin root "indicare" which resonates in the original meaning of the
German "Index" (announce, make known, indicate) makes it the perfect
translation of the word "index" as we use it in Git.

"Register" would also make sense, but whenever there is a German word
with the same root (index/Index) which is not a "false friend" we shoul=
d
go for that.

Note that we should not overemphasise the issue of connotations, or Git
should really be FSK16, i.e. PG or stricter - I mean, Git's idea of the
result of "committing is

1 files changed, 1 insertions(+), 0 deletions(-)

Makes you think differently about "commit early, commit often." ;)


>=20
>>  commit (noun, verb)                Commit/committen
>=20
> That's a hard one. It sounds terrible to use "committen" in German. I=
 =20
> would strongly vote for not using this word directly, but I admit I =20
> also don't have a completely convincing alternative.

"Eintrag", "eintragen"

Here, Git itself leaves the picture of trees and DAGs (or else a commit
would be a vertex or node).

>=20
>>  revision              Revision
>=20
> Die "Revision" kommt ins Haus, um die B=FCcher zu pr=FCfen. Honestly,=
 =20
> please don't use that word in German. Why not "Version"?

+1
Again, that reflects a limited view of the use of "Revision", but I hav=
e
no objection against "Version". Even our existing glossary says that a
"revision" is what other scms call a "version".

>=20
>>  tag                   Tag
>=20
> Der heutige Tag oder der morgige Tag? What's the problem with =20
> "Markierung"? This is exactky the git concept which is meant.

"Markierung" is OK, but I'd go for the shorter "Marke" as in "Marke
setzen" etc. Even the connotation with "Briefmarke" is beneficial, as
you tag something by putting a label on it, just like a stamp.

>=20
>>  tree                  Tree
>=20
> I would not understand what the "Tree" in German should be. Any Germa=
n =20
> word instead?

"Baum"! It's the combinatorics term for an undirected acyclic graph,
it's the literal translation, and it's established also in the context
where we mostly use it in Git: "Verzeichnisbaum" (directory tree)

>=20
> Many other of the proposals are just fine and very good. Keep up the =
=20
> good work!

I guess I'll have to revisit that, it was probably among some 159
patches or so I marked read in one thread...

Cheers/Tsch=FC=DF,
Michael
