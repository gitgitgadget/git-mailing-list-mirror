From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 15:06:00 +0200
Message-ID: <49D0C3B8.2050801@drmicha.warpmail.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>	 <1238407903-28020-5-git-send-email-santi@agolina.net>	 <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 15:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoHDJ-0007bq-3m
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 15:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZC3NGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 09:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZC3NGH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 09:06:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39477 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbZC3NGG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 09:06:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7D05B307B49;
	Mon, 30 Mar 2009 09:06:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 30 Mar 2009 09:06:03 -0400
X-Sasl-enc: PxyNYvecQ1mtHhMtru2yzdAdxF2m6Uuo+zo27AEjcH6T 1238418363
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B811C2D0EF;
	Mon, 30 Mar 2009 09:06:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090328 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115148>

Santi B=E9jar venit, vidit, dixit 30.03.2009 14:37:
> 2009/3/30 Michael J Gruber <git@drmicha.warpmail.net>:
>> Santi B=E9jar venit, vidit, dixit 30.03.2009 12:11:
>>> push.default was too generic, and also didn't specify if it was abo=
ut
>>> remote, refspec, branches, behaviour...
>>
>> I guess we go for US spelling here, so it's "behavior" ;)
>=20
> Ok.
>=20
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 38ab785..80bb3a6 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -480,7 +480,7 @@ branch.<name>.remote::
>>>  branch.<name>.merge::
>>>       It defines, together with branch.<name>.remote, the upstream =
branch
>>>       for the given branch. It tells 'git-fetch'/'git-pull' which
>>> -     branch to merge and can also afect 'git-push' (see push.defau=
lt).
>>> +     branch to merge and can also afect 'git-push' (see push.mode)=
=2E
>>
>> s/afect/affect/
>>
>=20
> OK
>=20
>>
>> Your patches contain quoted-printable characters all over the place.
>=20
> I don't see the quoted-printable characters, I see them in utf-8 and =
8bit.
>=20
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>=20
> Maybe some server in between is recoding it.
>=20
>> Are
>> they not sent with git send-email?
>=20
> They are send with git send-email and msmtp.
>=20
> Santi

That's weird. I read through gmane/nntp, but others' posts are fine.
Yours have

Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

But as long as Junio gets them unmangled I don't mind.

OK, I checked the raw mail at marc. It's fine. So I guess it's a gmane
thing (or tb)... Sorry I bothered you.

Michael
