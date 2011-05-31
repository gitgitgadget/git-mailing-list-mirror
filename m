From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Tue, 31 May 2011 08:06:50 +0200
Message-ID: <4DE4857A.70605@viscovery.net>
References: <7v62osob67.fsf@alter.siamese.dyndns.org> <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com> <7vsjrwm4sj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 08:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRI6X-0004y1-Mb
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 08:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab1EaGG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2011 02:06:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26177 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751150Ab1EaGGz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 02:06:55 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QRI6M-0006F9-Vr; Tue, 31 May 2011 08:06:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B47C91660F;
	Tue, 31 May 2011 08:06:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vsjrwm4sj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174793>

Am 5/30/2011 20:17, schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
>> On Mon, May 30, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> * ab/i18n-scripts (2011-05-21) 48 commits
>>>  (merged to 'next' on 2011-05-23 at 69164a3)
>>> [...]
>>> Rerolled.
>>> Will cook a bit longer.
>>
>> This being ready for master is waiting on Johannes Sixt's patches to
>> supply a fallback getenv() on Win32.
>=20
> That getenv thing by itself is actually a non blocker for git.git its=
elf,
> as mingw folks fork from my "next" anyway, I think.

Things are not that simple. I think there are (a few) Windows people,
including myself, who follow master[*] and do not depend on an msysgit
release. But as far as I am concerned, I do not mind backing out change=
s
that break on Windows until a solution is found.

[*] I do include cooking topics where I think that there is a chance th=
at
they break on Windows.

-- Hannes
