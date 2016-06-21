Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4D11FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcFUUah (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:30:37 -0400
Received: from mout.web.de ([212.227.17.12]:57802 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbcFUUad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:30:33 -0400
Received: from [192.168.2.149] ([79.223.114.6]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LwYs7-1bRkjh1moh-018IdR; Tue, 21 Jun 2016 22:30:25
 +0200
Subject: Re: [PATCH] t7800 readlink not found
To:	Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
 <vpqk2ijs8p2.fsf@anie.imag.fr> <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
 <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
 <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
 <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
 <20160527041944.GA17438@gmail.com> <574CDA24.1020906@googlemail.com>
 <574D1BEA.5020409@web.de> <xmqqzir67p1y.fsf@gitster.mtv.corp.google.com>
 <CALR6jEgAtvuecJ4OPOAcDGh3o02oM_WP5_CM8Y52eW2hjuLDNg@mail.gmail.com>
 <xmqqy45ypesl.fsf@gitster.mtv.corp.google.com>
Cc:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <5769A3D4.5060506@web.de>
Date:	Tue, 21 Jun 2016 22:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy45ypesl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ocvs0PmywVjc8HjN2/Fke9eHifbwCbKUhkKACJnfUKAshOJfR+T
 ZJMWZWfQ8VqeZJynjS2SO9YkJT5veQeXxmi1yYOhdMY3FQoErolxCmYS/P4q/UGZDbr4ybY
 +65fc6XkJ9QuxWBSiSoturW2FBW6Np7DpTItxL3eOc3IHp+CHaILR6df1dstDf7r/5Q0fbd
 U3z1ZYvJBAMk33ueAz/PA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9MPzf91CDig=:lLL85ER2n43UgKXm6Dm/pe
 rXX5cWOZhMI3+McqxLNtyPc5qbXxTRlzU3bGsyz7VDQ132k9q6Jd5fU2Z41fgIULBFmhTD6MO
 AJvqSzXmw2Rnu4btO3iAba9rOuXrg+VHeeXDP0GcjAXPHVTqUFkd7y9n+IdtLTaYekCZKB9uo
 AT1iA5rwA2nT8soSfqRQD8PHGvw3bdzaUt/6FYSpnvhgotNsAdYwIp9v0mt5JzLNj6uydcko2
 C/pA/r1ghX7MoRQ7EIXGXYJC/FvXcAz0Q2hZP45laTpE2BU1q7l5RPM38xo0VTQukpD9pSG9R
 WHIN/XdHvL/4Or7rfDAeOR2T6OaaU991TmRtHf3OFmS6fG8UOQdi16xPJIPz+jjmb0kUNa975
 GHDwXSGBq8awypzTj7GwS3oJX+4bCb2/+J3cDBbCOUzacOuVXucAKZZ9Uw1O+ome2gtAzXNGf
 xrKkaHPIMya6VzSiuyFuCPKxUv4pcsDPjBmIx3XrpXHYe/dO4aAf9A4JHeNdnSjzCsRoFC/j6
 gaY01WP+7/lnn4h+PCCZaO13O5OTBJaOkT1G7Iv11GobsRy0MfTRgEjNDoI+BuWAYD3lNqiBL
 l+0UbXl0zBCMw0w0jON3GIBlqfKsfLxxOziOXxIy7uqSVOHWK5d/hLzbDltJLGIgS6kh90Dkj
 zfAbIQzexsLUTCl6pn6XRe2UUG0R5NYSretuCKctF+iGU/w7MktqSat22DWHNxi+1J5svjbVc
 v9WNCsA+PAhLXRJNTDKaXgsC/tWHG+KvEoUxMvWwPnIZwyxBQfeI0bESqIg57WS1rEmX9VeV/
 +zCkivd
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/21/2016 08:39 PM, Junio C Hamano wrote:
> Armin Kunaschik <megabreit@googlemail.com> writes:
>
>> On Tue, May 31, 2016 at 7:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Torsten Bögershausen <tboegi@web.de> writes:
>>>
>>>>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>>>>> index 7ce4cd7..905035c 100755
>>>>> --- a/t/t7800-difftool.sh
>>>>> +++ b/t/t7800-difftool.sh
>>>>> @@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
>>>>>    for f in file file2 sub/sub
>>>>>    do
>>>>>       echo "$f"
>>>>> -    readlink "$2/$f"
>>>>> +    ls -ld "$2/$f" | sed -e 's/.* -> //'
>>>>>    done >actual
>>>>>    EOF
>>>>>
>>>> I don't know how portable #ls -ld" really is.
>>> The parts with mode bits, nlinks, uid, gid, size, and date part do
>>> have some variations.  For example, we have been burned on ACL
>>> enabled systems having some funny suffix after the usual mode bits
>>> stuff.
>>>
>>> However, as far as this test is concerned, I do not think "how
>>> portable is the output from ls -ld" is an especially relevant
>>> question.  None of the things we expect early in the output (the
>>> fields I enumerated in the previous paragraph) would contain " -> ".
>>> And we know that we do not use a filename that has " -> " (or "->")
>>> as a substring in our tests.
>>>
>>> We don't have to use readlink, even on platforms where we do have
>>> readlink.  Building the conditional to be checked at runtime and
>>> providing a shell function read_link that uses "ls -ld | sed" or
>>> "readlink" depending on the runtime check is wasteful.
>> Just a short, curious question: Is this patch to be accepted/included some time?
>> I didn't see it in 2.8.4 nor 2.9.0. Maybe it just fell off the table...
> Yes, I think this fell off the table as I was waiting for some kind
> of agreement or counter-proposal, neither of which came and the
> thread was forgotten.
>
> Unless Torsten still has strong objections (or better yet, a better
> implementation), I am inclined to queue it as-is.
>
I just double-checked the man pages for Mac OS and opengroup:
No better implementation from my side -> No objections

