From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: tables in documentation
Date: Sun, 02 May 2010 21:23:56 +0200
Message-ID: <4BDDD14C.7040503@drmicha.warpmail.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net> <20100502050622.GF14776@coredump.intra.peff.net> <4BDD7E96.2050603@drmicha.warpmail.net> <1272811394.24767.7.camel@dreddbeard> <1272811916.24767.16.camel@dreddbeard> <4BDD956F.5070800@drmicha.warpmail.net> <4BDD99F3.9000305@drmicha.warpmail.net> <20100502175353.GA15521@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: wmpalmer@gmail.com, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 21:24:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8elp-0008Fu-Id
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 21:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab0EBTX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 15:23:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35866 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758105Ab0EBTX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 15:23:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A1887F282B;
	Sun,  2 May 2010 15:23:57 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 02 May 2010 15:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lr+W/A6QU3QypG5vt0aHFnh+cGU=; b=oLyYRdfeV7LtWiSxu6J/1P+HAt3NvJByaB+SfyfOOAGL9OTtA0cR/8MTixDXokRVMs9ebpcuz0oAaEAVxLMq74AeLonQR0hhw+Hx7Rmwp3p9sy/cnW3NgLK7skheN1koESEPLbCM2CD/ftx47je/NgRrcIruAKISXgunMZ4u+1Q=
X-Sasl-enc: TMqwhPHOaMwjJcu30rg7+RNMkkJ4mhIXQFKTbdPPM7+c 1272828237
Received: from localhost.localdomain (p5DCC09A3.dip0.t-ipconnect.de [93.204.9.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 87F754D2F19;
	Sun,  2 May 2010 15:23:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100502175353.GA15521@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146195>

Jonathan Nieder venit, vidit, dixit 02.05.2010 19:53:
> Hi Michael,
>=20
> Michael J Gruber wrote:
>> Michael J Gruber venit, vidit, dixit 02.05.2010 17:08:
>=20
>>> Further experimentation (editing the xml) indicates that with my
>>> toolchain, I can either shut off all borders (between cells as well=
 as
>>> outer) or none.
> [...]
>> For completeness, it results in this:
>>
>>      I                H         M               Result
>>
>>  0   nothing          nothing   nothing         (does not happen)
>>
>>  1   nothing          nothing   exists          use M
>>
>>  2   nothing          exists    nothing         remove path from ind=
ex
>>
>>  3   nothing          exists    exists, H =3D=3DM   use M if "initia=
l
>>                                                 checkout", keep inde=
x
>>      exists, H !=3D M             fail            otherwise
>>
>> [Same unealt rowspan issue, of course.]
>=20
> For what it=E2=80=99s worth, except for the broken last row, I like t=
his and
> find it readable.  It is too bad there is no way to make it more
> compact so more rows can fit on a screen or page.
>=20
> The ideal, to delimit the header without appearing busy, would be to
> just have a thin horizontal rule separating the header from the
> remaining rows[1].  Vertical rules are almost never a good idea.
> Maybe frame=3D"topbot",grid=3D"none",options=3D"header" would be a go=
od
> approximation.

That looks nice in HTML (and produces the correct xml), but
unfortunately my docbook renders this as if I had frame=3D"all",grid=3D=
"all" :(

>=20
> Jonathan
>=20
> [1] Just my opinion.  I probably learned the aesthetic from Simon Fea=
r.
> http://www.tex.ac.uk/cgi-bin/texfaq2html?label=3Ddestable
