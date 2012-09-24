From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Message from 'git-rebase'; German translation
Date: Mon, 24 Sep 2012 09:33:39 +0200
Message-ID: <50600CD3.4020604@drmicha.warpmail.net>
References: <1527028.GPe6zkelBV@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG3At-0000cw-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 09:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab2IXHdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 03:33:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46821 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066Ab2IXHdl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 03:33:41 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 040432085D;
	Mon, 24 Sep 2012 03:33:40 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 24 Sep 2012 03:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qRwv7mJ1QrIC5ZHTbn0pMe
	AjMQw=; b=VG/S4lSZt27Z08jCrzNGF243Wc8CkzXInxgW81X8kjM/AyISq7vbHK
	l37w7Zli8Yfpto5rEiGSs9BN8LW1+712VxduK+3zIsIHBuaD2TK6ep08YhBDa2qV
	yRFlTWNdpUsRzl5HaB9y51Fru76DtShwr6CDQToG9G5lWlfNfp6uw=
X-Sasl-enc: K0fjbgKTilGSZKf1HwdfI2qcmcs9rhdGQ2QP3nDylBA2 1348472020
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7210B48258C;
	Mon, 24 Sep 2012 03:33:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1527028.GPe6zkelBV@blacky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206256>

Sascha Cunz venit, vidit, dixit 22.09.2012 23:57:
> As I know how hard translations can be, esp. with that much technical=
 terms=20
> inside, I'm usually expecting _not_ to yield the same result when tra=
nslating=20
> a software's translation back to English.
>=20
> However, git-rebase just threw these two sentences at me (And though =
i know=20
> their meaning, i couldn't get the meaning from the message, it gave).=
 Both are=20
> in context of starting a rebase while one is already in progress.
>=20
> first is:
>=20
> Original:
> ... and I wonder if you are in the middle of another rebase.
>=20
> German git translation:
> ... und es w=E4re verwunderlich, wenn ein Neuaufbau bereits im Gange =
ist.
>=20
> And a re-translation back to English from my understanding as native =
German=20
> speaker:
> ... and it would be astonishing (=3Di'd be surprised), if a rebase wa=
s already=20
> in progress.
>=20
> And second:
>=20
> Original:
> I am stopping in case you still have something valuable there.
>=20
> German git translation:
> Es wird angehalten, falls bereits etwas N=FCtzliches vorhanden ist.
>=20
> I wanted to point out that "etwas N=FCtzliches" is more "something us=
eful" that=20
> "something valuable". But the more I thought about it, the more it st=
arted to=20
> confuse me (even the original text) - and now I feel like I don't und=
erstand=20
> the meaning of the last sentence at all; neither in English nor in th=
e German=20
> translation:
> After removing the directory with all rebase-information inside it, W=
HERE=20
> should something valuable still be left over? Is it referring to my w=
orking=20
> tree?
>=20
> So, for completeness, the full English message:
>=20
> 	It seems that there is already a rebase-merge directory, and
> 	I wonder if you are in the middle of another rebase.  If that is the
> 	case, please try
>      	   git rebase (--continue | --abort | --skip)
> 	If that is not the case, please
> 	        rm -fr "/work/lg2/src/.git/rebase-merge"
> 	and run me again.  I am stopping in case you still have something
> 	valuable there.
>=20
> Sascha
>=20

Both translations are completely wrong on two accounts: They are a wron=
g
translation of the English original into German (making typical mistake=
s
like "false friends" [wonder !=3D wundern] etc.), and they convey a
completely wrong idea about what git is doing and about to do (by
translating a message without knowing when and why it is given).
Unfortunately, neither comes to me as a surprise.

I'm sorry I'm too frustrated by the German l10n community to try to hel=
p
again (and the ensuing thread just reinforces that feeling), but to end
on a positive note let me just point out:

'in case ...' =3D 'f=FCr den Fall dass ...' (attributiv)

'in the case  ...' =3D 'im Fall dass ...' (konditional)

Michael
