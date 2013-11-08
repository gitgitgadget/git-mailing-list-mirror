From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Fri, 08 Nov 2013 18:23:07 +0000
Message-ID: <527D2C0B.6040604@ramsay1.demon.co.uk>
References: <527C0CEA.4020705@ramsay1.demon.co.uk> <20131107221944.GA19238@sigill.intra.peff.net> <527D1B06.3090807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 08 19:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeqiC-0003dr-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 19:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab3KHSXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 13:23:12 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:50024 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757542Ab3KHSXL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 13:23:11 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 891D4AC407B;
	Fri,  8 Nov 2013 18:23:09 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 4E194AC407A;
	Fri,  8 Nov 2013 18:23:09 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Fri,  8 Nov 2013 18:23:08 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527D1B06.3090807@web.de>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237461>

On 08/11/13 17:10, Torsten B=C3=B6gershausen wrote:
> On 2013-11-07 23.19, Jeff King wrote:
>> On Thu, Nov 07, 2013 at 09:58:02PM +0000, Ramsay Jones wrote:
>>
>>> These patches fix various errors/warnings on the cygwin, MinGW and
>>> msvc builds, provoked by the jk/pack-bitmap branch.
>>
>> Thanks. Your timing is impeccable, as I was just sitting down to
>> finalize the next re-roll. I'll add these in.
>>
>> -Peff
>=20
> Side question:
> Do we have enough test coverage for htonll()/ntohll(),
> or do we want do the "module test" which I send a couple of days befo=
re ?

Yes, sorry for not bringing that up; I didn't get to try (or even look =
at)
your test patch, because I couldn't 'git am' it. :(

I've been meaning to look into why that is, but just haven't had time y=
et.
(I think it may have something to do with your name - I've noticed in t=
he
past that any mail with utf8 characters causes problems.)

However, I should have alerted Jeff to your patch; sorry about that!

ATB,
Ramsay Jones
