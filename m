From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git merge --abort deletes unstaged files
Date: Tue, 16 Sep 2014 00:28:33 +0200
Message-ID: <87egvcldri.fsf@igel.home>
References: <04af01cfd0fb$d077e200$7167a600$@webkr.de>
	<87k354x0qt.fsf@igel.home>
	<xmqq61go65zu.fsf@gitster.dls.corp.google.com>
	<87iokolfc9.fsf@igel.home>
	<CAPc5daW5XejS7JFmQagOwgqSxS=subdJyCbM3JL2fa=4RmYsEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QW5kcsOpIEjDpG5zZWw=?= <andre@webkr.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:28:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTelF-0007oS-A9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481AbaIOW2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 18:28:38 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59207 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbaIOW2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:28:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hxj026ZTvz3hhtV;
	Tue, 16 Sep 2014 00:28:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hxj022rqnzvh2q;
	Tue, 16 Sep 2014 00:28:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id wEjaghZrns17; Tue, 16 Sep 2014 00:28:33 +0200 (CEST)
X-Auth-Info: bDDFAOR2gJhqKJ2BohBcPdQLDff5HNevS3szExMBguSF4QjhrTZ/Z7SvVIQJBSZ5
Received: from igel.home (host-188-174-223-9.customer.m-online.net [188.174.223.9])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 16 Sep 2014 00:28:33 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3FE462C1D58; Tue, 16 Sep 2014 00:28:33 +0200 (CEST)
X-Yow: I'm also against BODY-SURFING!!
In-Reply-To: <CAPc5daW5XejS7JFmQagOwgqSxS=subdJyCbM3JL2fa=4RmYsEg@mail.gmail.com>
	(Junio C. Hamano's message of "Mon, 15 Sep 2014 15:02:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257111>

Junio C Hamano <gitster@pobox.com> writes:

> On Mon, Sep 15, 2014 at 2:54 PM, Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>
>>>> Andr=C3=A9 H=C3=A4nsel <andre@webkr.de> writes:
>>>>
>>>>> I ran git merge to merge a branch. There were some conflicted fil=
es.
>>>>> Although they were automatically resolved by git rerere, I still =
had to add
>>>>> them.
>>>>
>>>> If you want them to be added automatically, set rerere.autoupdate=3D=
true.
>>>
>>> I would have to caution against doing so without thinking, though.
>>> In other words, it is OK if you are Andreas who knows what he is
>>> doing, but it is not a very good advice to give to random newbies.
>>
>> If you are used to doing "git add ." afterwards it can't be much wor=
se.
>
> The right response to such a user would be to teach "add -u",

That's actually what I meant above.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
