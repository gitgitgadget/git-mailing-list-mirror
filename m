From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 13:10:33 +0200
Message-ID: <889FACB5-7C62-4469-9F03-0AF92622BFFD@lrde.epita.fr>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-62-501752467"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id28G-0005cK-KG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbXJCLLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbXJCLLD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:11:03 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:36077 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbXJCLLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:11:01 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Id283-0003tp-8z; Wed, 03 Oct 2007 13:10:59 +0200
In-Reply-To: <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59823>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-62-501752467
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Oct 3, 2007, at 12:25 PM, Wincent Colaiuta wrote:

> El 3/10/2007, a las 10:57, Miles Bader escribi=F3:
>
>> To the extent that a command _is_ "dangerous", there's always a =20
>> tradeoff
>> between convenience and "danger".  Some systems (e.g. those aimed at
>> newbies) might have as a goal to do the absolute minimum with every
>> command and always, always, err on the side of safety.  I don't =20
>> think git
>> is that system.
>
> While much of this debate can be shortcircuited simply by making =20
> the behaviour configurable, I would like to take you up on the =20
> point that you raise here.
>
> If we're going to talk about what kind of system Git is then =20
> consider this:
>
> - it's inherently distributed and this design actively encourages =20
> users to treat their local repositories as sandboxes where things =20
> are tried out, perfected, and then pushed out into the public via =20
> one means or another
>
> - it's built from the ground up to be good at branching and =20
> merging; this, combined with my previous point, means that users =20
> are likely to have multiple heads and often some of them will be =20
> "works in progress" that aren't yet ready for publication
>
> So it's in that light I see accidentally pushing more than you =20
> thought you would as "dangerous"; when you make this mistake you're =20=

> basically making stuff available that's not yet ready for =20
> consumption, and by its nature this mistake is basically =20
> irreversible: you can't really "unpush" what you pushed, you can =20
> only push out additional amendments which correct it.
>
> So, in this light, when you say:
>
>> What's "dangerous" for newbies, often ends up being what doesn't
>> correspond with their mental model.
>
> I don't know how much it has to do with mental models. I think in =20
> this case it's a bit simpler than that where you make the mistake =20
> once or twice and very quickly learn that "git push" means "push =20
> what's in my repo", not "push only what's on my current branch". =20
> It's a *very* easy lesson to learn if you get burnt and hardly =20
> requires any adjustments to ones "mental model".
>
> I personally would be in favour of changing the default because I =20
> tend to work on a particular branch at a time and then want to push =20=

> *that* out -- generally I'm thinking about one general area or one =20
> task at a time, and that means one branch at a time; I almost never =20=

> think along the lines of getting all my branches into shape at once =20=

> and then pushing them out in a batch. I think this is more likely =20
> to be a common pattern, although obviously that remains speculation =20=

> at this point.
>
> Changing the default would be great for people like me; by not =20
> having to pass additional parameters to git-push I save some =20
> keystrokes. If I ever want to push everything an "--all" switch =20
> would do the job. But if people prefer to keep the old default then =20=

> there'll be .gitconfig for people like me. In any case I think more =20=

> people need to speak up on the topic so that we can find out what =20
> most people really think about changing the default.
>

I completely second all that.  I've been using Git for roughly 3 =20
months and have been burnt the same way.

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-62-501752467
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHA3ipwwE67wC8PUkRAvx5AJkBRv4eDM8/l+ENtiP3ch+cvRiqhACgkHjP
l6dA2hmv7AVrjM6tRnoBs/s=
=Gejl
-----END PGP SIGNATURE-----

--Apple-Mail-62-501752467--
