From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git merge --abort deletes unstaged files
Date: Mon, 15 Sep 2014 23:54:30 +0200
Message-ID: <87iokolfc9.fsf@igel.home>
References: <04af01cfd0fb$d077e200$7167a600$@webkr.de>
	<87k354x0qt.fsf@igel.home>
	<xmqq61go65zu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QW5kcsOpIEjDpG5zZWw=?= <andre@webkr.de>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeEJ-0002Yh-SG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 23:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbaIOVyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 17:54:35 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48494 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbaIOVye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 17:54:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hxhDm3Ctqz3hhwv;
	Mon, 15 Sep 2014 23:54:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hxhDl3WLTzvh2p;
	Mon, 15 Sep 2014 23:54:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id pSBMl8ljekTC; Mon, 15 Sep 2014 23:54:30 +0200 (CEST)
X-Auth-Info: +b3nAKocBOSZGAgtHHWJZ/D0a0BxrA6aG228jOFhlZ+h4BFQLNh8YYieQU4mt4Il
Received: from igel.home (host-188-174-223-9.customer.m-online.net [188.174.223.9])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 15 Sep 2014 23:54:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 41A952C34AC; Mon, 15 Sep 2014 23:54:30 +0200 (CEST)
X-Yow: Why is everything made of Lycra Spandex?
In-Reply-To: <xmqq61go65zu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Sep 2014 12:25:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257085>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Andr=C3=A9 H=C3=A4nsel <andre@webkr.de> writes:
>>
>>> I ran git merge to merge a branch. There were some conflicted files=
=2E
>>> Although they were automatically resolved by git rerere, I still ha=
d to add
>>> them.
>>
>> If you want them to be added automatically, set rerere.autoupdate=3D=
true.
>
> I would have to caution against doing so without thinking, though.
> In other words, it is OK if you are Andreas who knows what he is
> doing, but it is not a very good advice to give to random newbies.

If you are used to doing "git add ." afterwards it can't be much worse.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
