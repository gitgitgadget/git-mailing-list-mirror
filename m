From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: --max-count useless with git-rev-list's --reverse
Date: Tue, 08 Mar 2011 09:34:52 +0100
Message-ID: <4D75EA2C.9010200@drmicha.warpmail.net>
References: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com> <AANLkTikTQfxK8B3fN6y5UZ=tRaM_iWXcfq=ukK4vPq2R@mail.gmail.com> <AANLkTin19c8jP9D2iQbP8XVLo4O_4+Wf+exwB-inCBQV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBC?= =?UTF-8?B?amFybWFzb24=?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsQz-0003Ry-2B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab1CHIiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 03:38:20 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60650 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109Ab1CHIiT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:38:19 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0810C208EE;
	Tue,  8 Mar 2011 03:38:19 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 08 Mar 2011 03:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=20nUw7/ILyEDkSN03Est06TjTlA=; b=gwv6Q5j3YgyuCQsYzYK4U7KeUb3n101Sctg/IgpUt18tgXYyG4nWDtrBRx7HCvh4GdS5nq9N8S7Gjs5vbvewJbO4B/TRQIJMUNEiR5LQ0lh2jkr6ER3RPt3sHsurfPQunjXmHrtjijQ81zlzZETELT5DFgJV7MXkXXdG1ef4WSY=
X-Sasl-enc: iFTP4Uc2X7cBlybPV1w+0jcBWEUqduXNr3oK0ekuWPmC 1299573498
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BB61408D40;
	Tue,  8 Mar 2011 03:38:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTin19c8jP9D2iQbP8XVLo4O_4+Wf+exwB-inCBQV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168646>

Jay Soffian venit, vidit, dixit 08.03.2011 08:35:
> On Mon, Mar 7, 2011 at 2:40 PM, Shawn Pearce <spearce@spearce.org> wr=
ote:
>> On Mon, Mar 7, 2011 at 11:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>> From the manpage:
>>
>> No. Its applied after, otherwise things like "git log -n 5 --reverse=
"
>=20
> I think I was surprised the first time I tried to combine those
> options as well, but in retrospect the reason is obvious. Nonetheless=
,
> I think this has come up on the list a few time, so... =C3=86var, wou=
ld you
> mind submitting a documentation patch?

Due to gmane lag, I replied to AAB's post only, but I bet you'll find
the patches.

Cheers,
Michael
