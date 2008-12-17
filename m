From: Gili Pearl <gili.pearl@yahoo.com>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 00:44:34 -0800 (PST)
Message-ID: <892158.12966.qm@web112209.mail.gq1.yahoo.com>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com> <4948AB14.8030004@viscovery.net> <753177.33978.qm@web112212.mail.gq1.yahoo.com> <200812170933.04080.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 09:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCs2V-0002Pr-BM
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbYLQIog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 03:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYLQIog
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:44:36 -0500
Received: from web112209.mail.gq1.yahoo.com ([67.195.14.72]:41498 "HELO
	web112209.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751751AbYLQIof convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:44:35 -0500
Received: (qmail 14366 invoked by uid 60001); 17 Dec 2008 08:44:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=5fzaRiPKiIA8snbAUJx3OASOMvXFiiub/ls8MMQQvLdFaU6BT+GwGZ/x3G+k3Qxl7fZJu4xXQ0VPXKtnVGOJ6J9AGAjo5UNb7g9fGsPRnF7KKFdQpTeAyS4PlgPnhRA/TzmhQuw3OqgbR1FNGPCesEc6URQN2aYBRG2vEuLHirE=;
X-YMail-OSG: PxLK4WUVM1mzjOw0N1MVBLmx0HDQOoqpa.x.1IpnTADto5IMbIqImTIPgI7KwNU8eCct_DEqsw0QCdklyFWdnCT0_.4T9FMXiUDTqcT5J2K7i74x.Fa5On7LRzoEs8LOWqC3R0C8IZ8xBmfNS5k68cXv1KdJXX6jrK3ykhBUwyRGivxy31xLKZ8GmjIooFW8Dmc48ei7SxyDqXAn8wEHil6wMm3Oo8Ev.JvW55E2CmhTffD1QQN_QndLNlhY3lEuQc6sIAvK4t2OBXkdBI5h
Received: from [80.179.89.178] by web112209.mail.gq1.yahoo.com via HTTP; Wed, 17 Dec 2008 00:44:34 PST
X-Mailer: YahooMailRC/1155.45 YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103320>

Johan, Johanes, Thanks! You made yourself prefectly clear.
git is wonderfult :)


----- Original Message ----
> From: Johan Herland <johan@herland.net>
>=20
> On Wednesday 17 December 2008, Gili Pearl wrote:
> > ----- Original Message ----
> >
> > > From: Johannes Sixt=20
> > > Gili Pearl schrieb:
> > > > Here is one problem I saw when trying to work in the three-leve=
l
> > > > model. At some point, I had the following setup:
> > > >
> > > > top-level : A----B----C----D
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > > mid-level1:=A0 =A0 =A0 =A0 K----L----M
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > > low-level1:=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 X----Y
> > > >
> > > > The maintainer of mid-level1 has decided that commits K L M are=
 ready
> > > > to be merged into the top-level repo. So he rebased on top-leve=
l
> > > > before asking=A0'please pull', but after that the low-level was=
 not
> > > > able to rebase on the mid-level any more.
> > >
> > > In this model, the mid-level1 maintainer should *not* rebase agai=
nst
> > > top-level. Rather, he should ask the top-level maintainer to *mer=
ge*
> > > K-L-M.
> >
> > But what if K-L-M conflict with C-D? The one who should take care a=
bout
> > it is=A0 the mid-level1 maintainer (or possibly one of the low-leve=
l1
> > maintainers).
>=20
> If there is a merge conflict, mid-level1 maintainer will typically me=
rge D=20
> and M into a new merge commit N:
>=20
> top-level : A----B----C----D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> mid-level1:=A0 =A0 K----L----M----N
>=20
> ...and then ask top-level maintainer to merge N (which should have no=
=20
> conflicts by now). The merge can also be done by low-level1 developer=
=2E
>=20
> > > > So what is the right working flow for us?
> > >
> > > The only ones who should be allowed to rebase are developers at t=
he
> > > lowest level. Everyone else should only pull or merge.
> >
> > I still don't see clearly what happens next in the example above=A0=
when the
> > low level developr wants to push X-Y upstream? On which branch shou=
ld=A0he
> > rebase? Need he rebase on mid-level (where K-L-M were already
> > merged=A0upstream),=A0or maybe direclty on the top-level??
>=20
> If you're a leaf developer (i.e. allowed to rebase), you should rebas=
e=20
> against your immediate upstream's branch. In this example, that is=20
> mid-level1's branch.
>=20
>=20
> Have fun!
>=20
> ...Johan
>=20
> --=20
> Johan Herland,=20
> www.herland.net



     =20
