From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 23:04:40 +0200
Message-ID: <1312405480.3261.957.camel@Naugrim.eriador.com>
References: <4E0A08AE.8090407@web.de>
	 <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoiZQ-0005N2-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1HCVBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 17:01:36 -0400
Received: from mailgw1.surf-town.net ([212.97.132.64]:44686 "EHLO
	mailgw14.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab1HCVBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:01:34 -0400
Received: by mailgw14.surf-town.net (Postfix, from userid 65534)
	id 3857C3DF8D; Wed,  3 Aug 2011 23:01:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw14.surf-town.net (Postfix) with ESMTP id 0F3DD3E1B8;
	Wed,  3 Aug 2011 23:01:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw14.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw14.surf-town.net ([127.0.0.1])
	by localhost (mailgw14.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fx4TVY0gvdPr; Wed,  3 Aug 2011 23:01:26 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw14.surf-town.net (Postfix) with ESMTPSA id 1EB5B3DF8D;
	Wed,  3 Aug 2011 23:01:21 +0200 (CEST)
In-Reply-To: <7v8vractdw.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178619>

Le mercredi 03 ao=C3=BBt 2011 =C3=A0 10:11 -0700, Junio C Hamano a =C3=A9=
crit :
> henri GEIST <henri.geist@flying-robots.com> writes:
>=20
> > I plan to use a config file containing lines like
> >
> > "path_to_poited_repo   SHA1_of_intended_commit   URL_of_origin"
> >
> > the URL part will not be required.
> >
> > this file will be a list of pointer to other project.
>=20
> I wasn't paying attention to this thread, but I have to ask "why" her=
e.
>=20
> The first two are what gitlink was designed to do in the superproject=
 that
> ties multiple submodules together, and the last one is also supplied =
by
> the .gitmodules in that superproject.

Yes my only problem is that it is forbidden to put a submodule outside
of the repository.
That is way I had done a patch witch enable me to do so and I use it
flawlessly every day. with total satisfaction.

> This seems to be adding the same information in a redundant way by sa=
ying
> "this version A0 of submodule A wants version B0 of submodule B and
> version C0 of submodule C" when the supermodule can say "the consiste=
nt
> view I record is to have version A0, B0 and C0 of submodules A, B and=
 C,
> respectively".
>=20

Exact but my goal is to get ride of the superproject.
This is how I will remove the redondency.
Cause creating a projet just to said to other project what they need is
a wast. Each project has to now by itself what it need.

And each user will have his own list of project to work on.
Then they we will create one different superproject for each user.

One user can work on a superproject containing :
gimp, gqview, libpng

One other will work on a superproject containing :
gimp, gphoto, libpng, libusb

The next one will work on a superproject containing :
xsane, libusb

They can absolutely not share there superproject only the normal
projects.
And if the dependency are defined in superproject, and not in the
projects themselves. Users can not share their dependency constructs.

I have no intend to have "sub"modules but to have generic modules with
no hierarchies only dependence relations. Which could even be crossed.
(Module A require module B and module B require module A.)
Even if in this particular case I do not see the point to make two
distinct modules.


> I also suspect that allowing each submodule to know and demand specif=
ic
> versions of other submodules will lead to inconsistencies. Which vers=
ion
> of submodule C would you demand to have when submodule A wants versio=
n C0
> and submodule B wants version C1 of it?
>=20

That is already the case with normal submodules.
And of corse if you have a project which recursively depend of to
version of the same library, you need to update it, and it has nothing
to do with git. Git will just make it obvious.


The reason we decide to make a parallel file ".gitdependencies",
containing something really similar to the content of ".gitmodules"
is that in .gitdependencies we will put references outside of repositor=
y
and in ".gitmodules" the references inside git repository as actual.

This separation will be done because Jens Lehmann show us
that .gitmodules are lot more that what I expected from those reference
and do not think that the others abilities of submodules should apply t=
o
external modules.

	Henri
