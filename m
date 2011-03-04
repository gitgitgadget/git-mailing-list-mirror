From: Eric Raible <raible@nextest.com>
Subject: Re: Re: [PATCH] Documentation: fix a typo in git-apply.txt
Date: Fri, 4 Mar 2011 00:31:01 -0800
Message-ID: <4D70A345.1010706@nextest.com>
References: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com> <7vlj0v942a.fsf@alter.siamese.dyndns.org> <20110304085622.6faa0c93@mkiedrowicz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 09:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvQPt-0002VS-5O
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab1CDIbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 03:31:12 -0500
Received: from pops.nextest.com ([12.96.234.114]:30744 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759245Ab1CDIbD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 03:31:03 -0500
Received: from [131.101.151.69] (131.101.151.69) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Fri, 4 Mar 2011 00:32:37 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110304085622.6faa0c93@mkiedrowicz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168433>

On 11:59 AM, Michal Kiedrowicz wrote:
> On 03.03.2011 15:28:45 -0800 Junio C Hamano <gitster@pobox.com> wrote=
:
>=20
>> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>>
>>> git-apply accepts the --cached option, not --cache.
>>>
>>> Signed-off-by: Micha=3DC5=3D82 Kiedrowicz <michal.kiedrowicz@gmail.=
com>
>>> ---
>>>  Documentation/git-apply.txt |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git Documentation/git-apply.txt Documentation/git-apply.txt
>>> index 881652f..2dcfc09 100644
>>> --- Documentation/git-apply.txt
>>> +++ Documentation/git-apply.txt
>>
>> What kind of crap is this?
>>
>> We really should make it much harder for people to use funky src/dst
>> prefix when generating patches.
>=20
> It's called diff.noprefix=3Dtrue :). I use it @work to easily copy/pa=
ste
> paths from git-diff output. I guess I should somehow make git.git
> config ignore global settings.

The local config will override the global settings automatically.

	git config diff.noprefix false

Should do it.
