From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 12:08:27 +0200
Message-ID: <556C2F1B.1060508@atlas-elektronik.com>
References: <556C0BAD.80106@atlas-elektronik.com> <20150601081450.GA32634@peff.net> <556C1A95.9010704@atlas-elektronik.com> <20150601085226.GA20537@peff.net> <556C2273.4030405@atlas-elektronik.com> <20150601095850.GD31389@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMeC-0000WV-H4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbFAKIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 06:08:40 -0400
Received: from mail96.atlas.de ([194.156.172.86]:27510 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbbFAKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:08:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id CC4E41015D;
	Mon,  1 Jun 2015 12:08:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TJN-Brmroeo; Mon,  1 Jun 2015 12:08:28 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon,  1 Jun 2015 12:08:28 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id DA63F2716C;
	Mon,  1 Jun 2015 12:08:27 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Mon, 1 Jun 2015
 12:08:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150601095850.GD31389@peff.net>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270392>

Am 01.06.2015 um 11:58 schrieb Jeff King:
> On Mon, Jun 01, 2015 at 11:14:27AM +0200, Stefan N=C3=A4we wrote:
>=20
>> Maybe this one:
>>
>>    d3038d (prune: keep objects reachable from recent objects)
>=20
> Yes, exactly.
>=20
>> It would be really helpful if you sent the patch as an attachment.
>> I know that's not the normal wokflow but our mail server garbles eve=
ry
>> message so that I can't (or don't know how to...) use 'git am' to te=
st
>> the patch, which I'm willing to do!
>=20
> It ended up as a patch series. However, you can fetch it from:
>=20
>   git://github.com/peff/git.git jk/silence-unreachable-broken-links
>=20
> which is perhaps even easier.

Not really in my situation...(but that's another story)

I managed to create patch files by simply copy-and-pasting the message
text (and the From:, Date:, and Subject: fields from 'View message sour=
ce' in Thunderbird...)
which I could then 'git am' ;-)

The patches applied (and compiled) cleanly on v2.4.2 and 'git gc'
stopped giving me the error message.

So (FWIW):

Tested-by: Stefan Naewe <stefan.naewe@gmail.com>

Anything else I could test ?

Thanks,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: Windows N'T: as in Wouldn't, Couldn't, and Didn't.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 2=
7AF
