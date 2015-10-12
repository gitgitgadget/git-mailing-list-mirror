From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Mon, 12 Oct 2015 12:45:27 +0200
Organization: gmx
Message-ID: <c9dd5858532f402e24c05b630a517ce9@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <4a99ca8724b3604cbbec48d559e134fd@dscho.org>
 <d89d595a223508896db9303c901e7c30@dscho.org> <56193760.5010307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 12 12:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlabr-0005jj-4C
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 12:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbbJLKpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2015 06:45:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:61777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbbJLKpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 06:45:33 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lo2EO-1aE3jk3VkG-00fwl9; Mon, 12 Oct 2015 12:45:28
 +0200
In-Reply-To: <56193760.5010307@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:p5pqw0ITr+NJevYxmsMxw+gCsbJ5vI7vfYlcxaaZRyTDTPyr4xW
 wjesTP2+Q1aljAMQFYZRHaKcJyGak2bWVbLxUN5RygU5jhpY64KkaAMCjASS9P7edHqmzEg
 6iYHg+H1J5Wf33ZMo/crERFNLJAKxQh6PQ7DPKjGXHppuwdSy2cdtvSWfHjS37yYxhUku+W
 bZJyjqMLDWSYrpi4Uuupg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:af4EBn0jDvI=:gSj0bYy3b/rgp+85tZo5hc
 dhUY5JvaQdiqLf9pMzz/Z4o4iBDqHroEcOJ8RCyHcK1idjvHDgP+gBFHRhxqiDd6dqWAGPBp5
 YnzKAiTP3BCZNKmJIOW5j06t/uVOHfkqYGQUuE98xTANMC8SLugx1BB82wTp6QTy7pPJcLpiN
 hQtMqHIMenNxvqMpCFgu87PIk0BsNCQL3AGDgv1xcGPtZAW+qfOafbCWEcrmlLdWGWFhM+k1l
 DS3gN89ERnw4y234afaH9R5DquGCBfaLo91+o6gqUDqnq6nyl35JlnjF32iVVQ3xKp+AdNKHj
 ijqnypEyFY/3Cn4goPqIDo6wVn7bNX/kRWnpbDwU3BVZ0vpvMIGKaVZlF1qJMjZ1EPULE55wJ
 aJWWK4TSYV5Lxdb+posVaAsGGs3ceUXG5/gFGv5U10CGzDVDvKJCeg+RAhQd5dj7bLN5d2Rsq
 sKTqkwir8qDfMM099qKBbE+VX6FvJ+l9nOTg5pXL66Sgc5rSvgnvvfGwFC1fiBmkUGZ31iCfu
 ewOdksMlxvHMxzElynJEPiafPzT5jgaZ8HAx9doJtE6KEO2oRxKNnJV0hcY334466FC/oGAFq
 dKRS5OunA+kWTbFjMWWgcPoltoNjEOdHChiO4Dld+INabpcds1/2XgzlFTRAxkGccSLcqgSPJ
 fLP29Pc3KRnIouiB+lvB9TXbO6rr5BOnO1o/tRs8owhofsJk6FEIqQcLKss3q9PCzRV5Hu2fI
 J2cT56jdRXbgUQTAc7F9bQH/NXyD348B3RfymCniNAw42dgzDH/n390BDFs0OMqWl7JNC4fi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279371>

Hi Torsten,

On 2015-10-10 18:05, Torsten B=C3=B6gershausen wrote:
> On 09.10.15 12:11, Johannes Schindelin wrote:
>> Me again,
>>
>> On 2015-10-09 11:50, Johannes Schindelin wrote:
>>>
>>> On 2015-10-09 03:40, Paul Tan wrote:
>>>> On Fri, Oct 9, 2015 at 8:52 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>>>
>>>>>> Brendan Forster noticed that we no longer see the helpful messag=
e after
>>>>>> a failed `git pull --rebase`. It turns out that the builtin `am`=
 calls
>>>>>> the recursive merge function directly, not via a separate proces=
s.
>>
>> [... cut lots of unnecessary text ...]
>>
>> +test_expect_success 'failed --rebase shows advice' '
>> +	git checkout -b diverging &&
>> +	test_commit attributes .gitattributes "* text=3Dauto" attrs &&
>> +	sha1=3D"$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
>> +	git update-index --cacheinfo 0644 $sha1 file &&
>> +	git commit -m v1-with-cr &&
>> +	git checkout -f -b fails-to-rebase HEAD^ &&
>> +	test_commit v2-without-cr file "2" file2-lf &&
>> +	test_must_fail git pull --rebase . diverging 2>err >out &&
>> +	grep "When you have resolved this problem" out
>> +'
>> +
>=20
> One other question:
> Is it good to mix 2 different things in one test case ?
> "shows the helpful advice when failing" is one thing,
> and the problematic CRLF handling another.

I do not necessarily test things that work, and have been working for a=
 long time, so no, I do not want to split that into two.

I could trigger the regression only via CR/LF, that is the only reason =
why CR/LF are used here. I do *not* want to test for anything CR/LF spe=
cific.

Ciao,
Dscho
