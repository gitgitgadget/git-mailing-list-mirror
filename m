From: =?ISO-8859-1?Q?=22=C1kos=2C_Tajti=22?= <akos.tajti@intland.com>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 15:20:30 +0200
Message-ID: <51A6009E.8020503@intland.com>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr> <CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com> <51A5FC17.8000608@intland.com> <vpqbo7udjcy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 29 15:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgIw-0006a7-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965982Ab3E2NUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:20:33 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51003 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965875Ab3E2NUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:20:33 -0400
Received: from [127.0.0.1] (188-143-39-115.pool.digikabel.hu [188.143.39.115])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MYpHi-1UuSAH37QY-00VSwd; Wed, 29 May 2013 15:20:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <vpqbo7udjcy.fsf@anie.imag.fr>
X-Antivirus: avast! (VPS 130529-0, 2013.05.29), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V02:K0:Shrg8gRQFYxR/QavCPFxaZd9gZUaHWSNqMJt3+memFa
 KVVzyEH1Das9GSHwZaV9iZO74ixrDIiNOao9cNZCgeLKkL/heU
 7A6RRuHK6RZlrVprn3hBdvot4SdJQg8+AarlUKVmgjTYA8L3uo
 hozLaHWqSCy8zdumnaV/8xgNszskhzoDdwZGOlSzRpa1G7fvWX
 aWBKJzT8SjL0ph+zNWxFp2X+8myy/vkhj37a2cN2ImWcZt/nnS
 +QnEupB9yZ+Udkt4L1zAv9nIVCA1G0sEUaBgmzYvrQAOlD/7ii
 2x/EoicbiSgGjjrIeHYBOKq5PRK+Q9zKF6lc5lDQsRJR5YNsNK
 v7lwMepecQuT0n76pkoI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225811>

Thanks! I ill try using fetch.

=C1kos

2013.05.29. 15:08 keltez=E9ssel, Matthieu Moy =EDrta:
> "=C1kos, Tajti" <akos.tajti@intland.com> writes:
>
>> The command was:
>>
>> git pull ../dump.dmp refs/heads/*:refs/heads/*
> "git pull" does internally a "git fetch" followed by a "git merge".
>
> If you try to pull several branches at the same time, it means you wa=
nt
> to merge all of them together (octopus merge), which probably isn't w=
hat
> you're trying to do. You probably want just a "git fetch", or specify
> only one branch to pull.
>
