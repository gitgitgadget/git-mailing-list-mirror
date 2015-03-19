From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [GSoC Project Help] Unifying git branch -l, git tag -l and git
 for-each-ref
Date: Thu, 19 Mar 2015 13:58:17 +0100
Message-ID: <550AC7E9.6060702@drmicha.warpmail.net>
References: <loom.20150319T121328-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sundararajan R <dyoucme@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 13:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYa1r-0006GM-LS
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 13:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbbCSM6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2015 08:58:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45416 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394AbbCSM6W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 08:58:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F1D120A70
	for <git@vger.kernel.org>; Thu, 19 Mar 2015 08:58:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 19 Mar 2015 08:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	 s=mesmtp; bh=hpBOB8xwjHSqz0O6hN6jtlhUzQQ=; b=A58VDh0EhB08sG0f57
	//f5SvPizCMTpv/kRR8VQOR4oP5Q1xa6edZCnQFU3VRI9jJVW2kAL03Z1BkW8fvp
	Q5bhg4TfYWsjyuhganwfH4wM5IpvmzD+3xOZv9Ly41OVbL8FjQ+gw/l1ll61Wi0Z
	XELchOzTaAiOsOonz47e0AD+k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hpBOB8xwjHSqz0O6hN6jtl
	hUzQQ=; b=NUebCIJea9H3Dhwkc9QTQoQZyq61MeYNF6lb7umxU4NwFZjLyQRUAW
	r8mjJ3Ocl2I3k5ZPFWdEdDqmBRqokCpFZJA+bePaXEEMPcTpizyP/bTyvMzec8ou
	pRYGKE+3HGe8ISYMSWCEN7ta3yoUSTX372yrqEVX1TFSzGz9HeDKY=
X-Sasl-enc: RUk1dIyCxhsS4I8SqALiHisXgxdQkHIYKok8u971n+oO 1426769899
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CCB8C6801B7;
	Thu, 19 Mar 2015 08:58:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <loom.20150319T121328-232@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265800>

Sundararajan R venit, vidit, dixit 19.03.2015 12:22:
> Hi all,
>=20
> I am a Computer Science sophomore at IIT Kanpur. I am interested in=20
> contributing to git in GSoC 2015. I have been using git for the past =
one year=20
> and am pretty comfortable with its commands which is what made me thi=
nk about=20
> contributing to git. I have attempted the microproject =E2=80=9Caddin=
g =E2=80=98-=E2=80=99 as a=20
> shorthand to @{-1} in the reset command=E2=80=9D [1] [2] from which I=
 learnt about=20
> how code is reviewed in the community and how a seemingly small chang=
e can=20
> end up being much more difficult. But the thing I liked the most is t=
he warm=20
> and welcoming attitude of everyone in the community towards a newcome=
r like=20
> me. I wish to take up the project idea =E2=80=9CUnifying git branch -=
l, git tag -l=20
> and git for-each-ref=E2=80=9D. I am in the process of reading and und=
erstanding the=20
> codes of these three commands and figuring out similarities and diffe=
rences=20
> in them. I have gone through some of the discussions regarding this o=
n the=20
> archive and have also read Junio=E2=80=99s reply to Amate Yolande [3]=
, but I haven=E2=80=99t=20
> been able to find patches which attempt to unify the selection proces=
s as=20
> mentioned in the description of the idea. It would be great if someon=
e could=20
> point me towards these patches which would help me when I start desig=
ning the=20
> details of the unified implementation. Thanks a lot for your time.
>=20
> Regards,
> R Sundararajan.=20
>=20
> [1] : http://marc.info/?l=3Dgit&m=3D142666740415816&w=3D2
> [2] : http://marc.info/?l=3Dgit&m=3D142666773315899&w=3D2
> [3] : http://article.gmane.org/gmane.comp.version-control.git/264966

I don't think there have been actual attempts at unifying the "display"
part of the list modes. A first step would be:

Check what "tag -l" and "branch -l" output you can reproduce using
for-each-ref format strings.

Then see whether for-each-ref needs to expose more information about th=
e
refs.

I wouldn't mind unifying the actual output format, but some will disagr=
ee.

As for the issue of ref selection (contains and such), the following
thread may be helpful:

http://thread.gmane.org/gmane.comp.version-control.git/252472

Cheers
Michael
