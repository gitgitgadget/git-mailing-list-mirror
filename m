From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Fri, 26 Feb 2016 23:34:07 +0100
Message-ID: <56D0D2DF.1040807@web.de>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
 <56D078F3.9070905@web.de> <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:34:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQyB-0008Nn-5V
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbcBZWej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 17:34:39 -0500
Received: from mout.web.de ([212.227.15.4]:55423 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748AbcBZWeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:34:37 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MbMg8-1aIs0v1eVg-00In1e; Fri, 26 Feb 2016 23:34:13
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:x7fXPRV8jEKX+qAVIjE6+2GrtZTVYlT9zapIE6Qnt+38OL9wZoW
 DyalWBWYAsOAUkPjvdUwAaMPDk5NjoukCLQsT7i0tTanl0vn0e/eGwrtUD7MCuxRe6zyzSh
 tLED7IiBaqpjGKQaoWg/cZHmAXolSfLcqfOXxGqcsIBMV6GmK9YOVrj1peWW/ux1lcjV0BK
 +NoHNr1eFx1nuIExx7QrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:flvPVsN+nDQ=:wFiBNJ+f7F6d8jwhd0S710
 6JfqGizrjr+w2wLOBCT73+TTyJ/F4hqFXfzIyJxqxCpzFBOVXOvZGMevSAR4Ie6NNF9R90Oef
 Fzm0xOgykxHLQfCBtJShQRMA1131W6mzrnzwNuHxAUopAGrLAEmvLAmoNP+NeLIvBL2lUVCzD
 yXPXyL5DKz1qibaoiQtXuiL/GlTsKZ39wAbtHg+//OE26ac0oV3dpU8R7hJAjFCUOiS6PCIa/
 LeuU72FCrb8xWjSEQZefTndmygKeQamTlYgN/7wmDiVZit6XXQNUbkwBbU5+EVmL6qXXvNhfP
 76zBqE9SLWkXtydH6CZJqQFXnpOHYMFs3hVbGf2O/KCvyqECJ8UKak2DxZfm1coLNo2E9ydHO
 aM4/12iDdyGzCL9jWVeqXLid4cLTnLE5vzm4ZCyTegfIfDJj1YZ33R8Jfms1hjOpuUKqccLj3
 4vCFmVlXzJ40e3uAGgHOyFWDpVGQ1iZGnnUtoBCGr9WQDZgukyjaFrrY/cASD4YTvqhE5/6pZ
 sGH9oFXNP7a5ixmcsGEv/4qZM94Qb6Z7WbU5pyOAZwBtjfYUOXGTyJ63WRiHpdLAAxevDgyvh
 +uXGZqMqTmRCgwz9mqGdIU6kIh4EoBV1PYPY22pJ8NACm/O/4EuBhqTF8k/5adoCJbwIMbPrp
 vhwyA1O7+sDaIMV1gM+H6fYstT/H+yBLDPGPm1vecW4vPsPRslUJtjIpJoUa0GaO95NMl+GRk
 YBYurgHxqgsuI3qTv2RIPYpER0MHr6Cd3Vgfkf3gl869X60pVSkpHfjx+y1OvopRo4/SzMls 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287629>

On 2016-02-26 19.29, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> CC combine-diff.o
>> combine-diff.c: In function =E2=80=98diff_tree_combined=E2=80=99:
>> combine-diff.c:1391: internal compiler error: Segmentation fault
>> Please submit a full bug report,
>> with preprocessed source if appropriate.
>> See <URL:http://developer.apple.com/bugreporter> for instructions.
>> make: *** [combine-diff.o] Error 1
>>
>> Revert "use st_add and st_mult for allocation size computation" didn=
't fix it.
>> I haven't digged deeper yet.
>=20
> Hmph, I am not quite sure what you meant by "I haven't digged
> deeper"; I do not think you should be debugging Apple's compiler
> (unless you have the source to it and that is your job to do so,
> that is).
>=20
> In any case, merging the topic to 'master', and reverting that
> commit will leave this only this change between 'master' and the
> result.  I do not immediately spot anything trickier in the
> postimage compared to the preimage that may trickle a compiler bug,
> but what would I know without the source ;-)
>=20
Digging means:
run git bisect and report the commit.
And this makes the compiler happy:
  Revert "tree-diff: catch integer overflow in combine_diff_path alloca=
tion"

    This reverts commit 5b442c4f2723211ce0d862571e88ee206bfd51bf.

Test suite passes,
( except t9115, the 2 new test cases "svn.pathnameencoding=3Dcp932".
  More info about that later)
