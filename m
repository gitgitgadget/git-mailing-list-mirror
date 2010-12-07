From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 07 Dec 2010 22:08:25 +0100
Message-ID: <4CFEA249.907@web.de>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com> <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Scott Kyle <scott@appden.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:08:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4m1-0007U5-Il
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0LGVI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 16:08:29 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34923 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab0LGVI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:08:28 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5FF0A180E5BCB;
	Tue,  7 Dec 2010 22:08:26 +0100 (CET)
Received: from [93.240.100.207] (helo=[192.168.178.51])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQ4lu-0004B8-00; Tue, 07 Dec 2010 22:08:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18sIfv4GHVaIeaUvXwXwp8oQZwLcgh32xsflsm4
	hO742JfEuzU8EM9Wv16noahWWGdGKSK64HBpJ3OVVEHO6QAGiz
	Kir3RXS3abvIemJVppKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163134>

Am 07.12.2010 21:31, schrieb Kevin Ballard:
> On Dec 7, 2010, at 4:15 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
>> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>>> For those who often work on repositories with submodules, the dirty
>>> indicator for unstaged changes will almost always show because deve=
lopment
>>> is simultaneously happening on those submodules. The config option
>>> diff.ignoreSubmodules is not appropriate for this use because it ha=
s larger
>>> implications.
>>
>> Wouldn't it be a lot better to instead add support for showing
>> submodule dirtyness as distinct from the main tree's dirtyness? Then
>> you could easily spot if you had either your tree / submodule tree
>> changes, without just ignoring them.
>=20
> That sounds like a good idea, but it doesn't necessarily have to come=
 with
> this patch. Scott's use case here is he has a submodule that is _alwa=
ys_ dirty,
> and he simply doesn't want to see that stuff in the PS1. Having an op=
tion to
> show it separately would be very useful for me, but should perhaps be=
 written
> as a separate patch.

I'm not sure if I understand your case correctly, but if there is only =
one
submodule that is always dirty and everybody knows that but nobody care=
s,
won't it make sense to change the "submodule.<name>.ignore" config opti=
on
for that peculiar submodule via .git/config or .gitmodules?
