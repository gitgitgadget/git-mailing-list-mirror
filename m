From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Mon, 30 May 2011 14:19:45 +0200
Message-ID: <4DE38B61.6030400@viscovery.net>
References: <7v62osob67.fsf@alter.siamese.dyndns.org> <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 14:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR1Rs-0003pF-Nk
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 14:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab1E3MTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 08:19:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21042 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752987Ab1E3MTv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 08:19:51 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QR1Ri-00019f-B0; Mon, 30 May 2011 14:19:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 128E41660F;
	Mon, 30 May 2011 14:19:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174742>

Am 5/30/2011 14:08, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Mon, May 30, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>=20
>> * ab/i18n-scripts (2011-05-21) 48 commits
>>  (merged to 'next' on 2011-05-23 at 69164a3)
>> [...]
>> Rerolled.
>> Will cook a bit longer.
>=20
> This being ready for master is waiting on Johannes Sixt's patches to
> supply a fallback getenv() on Win32.
>=20
> Johannes, what's the status of that, and is there anything I can do t=
o
> help with that?

I've started with something I thought would be trivial, but I early
tripped over a pitfall where getenv is asked to look for "PATH", and it=
 is
expected to find "Path" when we only have the latter in the environment=
=2E
Sigh. I think that's solvable.

Another worry is that the home-grown getenv is not thread-safe. I think=
 it
does not matter today, but who knows...

Anyway, I've at most an hour of quality git time during the week, so it
will take some time...

-- Hannes
