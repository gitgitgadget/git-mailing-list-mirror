From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 00:35:41 +0200
Message-ID: <4BD220BD.8090808@gmx.de>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>	<20100422155806.GC4801@progeny.tock>	<87wrvzs590.fsf@frosties.localdomain>	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>	<87sk6n4426.fsf@frosties.localdomain>	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>	<87vdbitu9v.fsf@frosties.localdomain>	<25441792-181D-456D-8182-F33B49209EFF@wincent.com> <87aastx6sa.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCB8E26E46BB92331420015E3"
Cc: Wincent Colaiuta <win@wincent.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 00:35:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5RTT-0004Ov-8u
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 00:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0DWWfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 18:35:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:46405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750914Ab0DWWfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 18:35:44 -0400
Received: (qmail invoked by alias); 23 Apr 2010 22:35:43 -0000
Received: from g230100064.adsl.alicedsl.de (EHLO apollo.emma.line.org) [92.230.100.64]
  by mail.gmx.net (mp010) with SMTP; 24 Apr 2010 00:35:43 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/kc84S6pLkD/DJ2X3oMBiwejcve+znLmtg6xcpYA
	Qo0pgDS1rVJ4eH
Received: from localhost ([127.0.0.1] helo=apollo.emma.line.org)
	by apollo.emma.line.org with esmtp (Exim 4.71 (FreeBSD))
	(envelope-from <matthias.andree@gmx.de>)
	id 1O5RTJ-000Hao-4h; Sat, 24 Apr 2010 00:35:41 +0200
User-Agent: Mozilla/5.0 (X11; U; FreeBSD amd64; de-DE; rv:1.9.1.9) Gecko/20100406 Thunderbird/3.0.4
In-Reply-To: <87aastx6sa.fsf@frosties.localdomain>
X-Enigmail-Version: 1.0.1
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145647>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB8E26E46BB92331420015E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 23.04.2010 22:17, schrieb Goswin von Brederlow:
> Wincent Colaiuta <win@wincent.com> writes:
>=20
>> El 23/04/2010, a las 11:03, Goswin von Brederlow escribi=F3:
>>>
>>> You all say the index is such a great thing. So I might use it
>>> eventually. Other people might use it 1 out of 10 times. Yet other
>>> people use it 9 out of 10 times. Can you at least accept that the use=
 of
>>> the index feature is different for each person?
>>>
>>> My suggested change, with the --a-if-empty option, would not impose
>>> anything on existing usage. But it would benefit those that rarely us=
e
>>> an index and would like git to be smart enough to know when to use th=
e
>>> index and when not. Yes, it would mean the use of the index ideology =
is
>>> not force upon people anymore. But isn't that a good thing? Free
>>> software is about freedom. That should include the freedom not to use=

>>> the index method.
>>
>> Not really. Git is free in the sense that: (1) it costs nothing; and (=
2) you can modify the code to do anything you want.
>>
>> But you've also got to recognize that along with your freedom to make =
modifications, the maintainers are free to either accept or reject them t=
oo.=20
>>
>> And in the event that the changes you want aren't accepted, you're fre=
e to either fork the tool or pick another one which does conform better t=
o your expectations.
>=20
> But you are already rejecting it in the design phase before there even
> is a patch.
>=20
>> In the present case experience has shown that the index and the way it=
 can be exploited are an incredibly useful thing. Not only that, it's a d=
ifferentiating feature of Git and it sets it apart from other SCMs, in a =
good way. We could mindlessly homogenize to be more like other systems, o=
r less "surprising" for users coming from other systems, but we'd be thro=
wing away something valuable in the process.
>=20
> If I would ask to disable the indexing feature then you would have a
> point. But I am not. I'm asking to add something that allows to use git=

> in a less "surprising" mode that, with the --a-if-empty option, does no=
t
> alter anything else. Git would still have all its great, big, shiny,
> differentiating features to set it apart from other SCMs without forcin=
g
> them down the users throat.
>=20
>> I personally don't see the point in having a bunch of SCMs that are al=
l exactly alike. I _like_ that Git's different, and over the years have b=
ecome so used to the benefits that working with the index "the Git way" b=
ring, that it's hard to imagine how I ever lived without it.
>>
>> Cheers,
>> Wincent
>=20
> I personaly have to work with different SCMs every day and every time I=

> have to switch minds to work with each specific one. Making git commit
> work less surprising would be one less thing to keep in mind.

You are trying to make Git more difficult to understand for the user.
This is easily perceived as non-determinism.

Before introducing a code branch (=E0 la "if $(git diff-index --quiet
HEAD)", think twice. It doubles testing efforts, it makes explanations
long-winded. What's so difficult about typing
[Arrow-Up] [Space] [-] [a] [Enter] if git commit comes up empty.

With your option, I need to remember that Git is overzealous and will
commit the whole index if nothing is staged, possibly git reset HEAD^
and clean up the mess. This is inconsistent and inefficient.

Try git gui or git citool if you can't be bothered to remember how to
add changes to your commit.  Git isn't alone.  Think BitKeeper, DARCS.
For other systems, there are extensions to help with committing, and to
emulate what DARCS has pioneered, for instance "hg record", an extension
for Mercurial.

> You like that Git is different so don't use the --a-if-empty option. Yo=
u

No. I for one like the ability to stage changes and commit logically
cohesive changes without having to save files to temporary files.

> will have lost nothing by allowing that option in. So far I have read
> arguments from people saying they don't want to USE the option. But no
> arguments why there could not be such an option. And I'm not the only
> one that would welcome such an option. Is there no room for a compromis=
e?

"Bloat". If I were the maintainer, I'd point you to aliases. If Git
itself can't do it, tossing a dozen shell lines into git's libexec would
do the job.  git diff-index --quiet is your friend.


--------------enigCB8E26E46BB92331420015E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (FreeBSD)

iEYEARECAAYFAkvSIL0ACgkQvmGDOQUufZV3qACg9DN1MEFZLeUTkJ6vphSKeknJ
fYkAoMkI48c848co4auSpJ/aO3ln1I8Y
=uY6F
-----END PGP SIGNATURE-----

--------------enigCB8E26E46BB92331420015E3--
