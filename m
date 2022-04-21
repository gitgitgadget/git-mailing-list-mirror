Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391001AbiDUR7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiDUR7p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:59:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2145AEE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650563742;
        bh=LKevE/HGGjNrkB+nmC00KMj6lzoi9TSppGmmm/mQAVE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OnHq6V/3a63yZ0aQa13MiVRaw7dyVuhEyqg9HRe2fUzeZtx6yF89g5NHyiL0FEmI/
         ywlvf6o3VTOUAtAx6ynS4kvhpZiqaKgYdiiGEkaAABHnnW+ZJXum2cLz1jHmtbwDVl
         1/zGh/QZyj9PzzvJyxs1Y1HiOF6OVFXfA6UwZwYg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJjZ-1nf8Br0BT7-00FaVk; Thu, 21
 Apr 2022 19:55:42 +0200
Message-ID: <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
Date:   Thu, 21 Apr 2022 19:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: Corrupt name-rev output
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Thomas Hurst <tom@hur.st>
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
 <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UgapyOdF0AX6XhasuVjGbJjZ2wj1AXLoT7eJa/Y2ksuF4ZekSoo
 TXOBLOfeOiV6dE5/aZiGPYpx6TzcA+sI0TNO8fFZsRdro1Sjq6JrGe0/Oe92pphG4qKWlJx
 /007jVgdYIXEDKmqHuHsT9xEA8EDK1ew9Ty38FtL/B1KzdNbniU14M6unSovLkfqtTBT2ES
 vf4nDYxtYL9TX61fks0+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yvrQP6vbJCo=:8Ld5HPU9DOMKTEJ62786qE
 KJm5GSfGs18ggC0/it7PdQmZF+MheoFkf1rcNOPZZEmYmX3Te/ilaEa8qPy0C2F3x+W7EQOx9
 au9O4sxz6vwgCpIead6fjTuG3EylkEa8bhNH+Nl+reY9KKMdO4teZ71GLuvucJMj4UdmiR9NH
 //T4UJo8+bUlNhqtcCBoiAdkEwkF7OAa7dqavg3m7fjr34YMQa097v3uVrjGA19xa8hey3uk/
 afFO8fj89zJjPunRW0P08Sdbfwv5b1j9iz9Ua4P3Gmf/KWCQM13OkijUUKyVeda3yEvEredMi
 zWHRB0EUjLH1v52Ue2580E84Tjpia6dqpxnNcGPLiqo9D5N4Q2vGBrcdk2CcaQTH0moREdyY1
 05ipqJP/IPN4QAW1erPxKWYHxu+rvzfqYmoqd/ujsUQQ0bU1hD6tenzmM0RpUDC58iLVzUdru
 /9sHhNUOhdjg/9J4Z6XrvVxdiGhI8kQERIpeUOV7DVtD4VYzaGImam0YaT4I69qYKgs04oRrI
 iNtNCVjMi48Nz23oDoE5FFjbMO8s6CLdLQm/b8JYOu/WRPzyDOawXURcz7Cnmk68pwQZIE4Md
 NdsKJSQzZugMLuVnGTMKKiX8vWAo4Dhur2XBipoHvtc8GgpJXBgkPISNSrW6BNTQtf4ap3Kgf
 F6eq89+r+xznz6Z7F5cIX2f23eAsF17zVXjRM0gGD/wQtixwth3ykMAN0MbOyGfu7nU4FeeJE
 oBXEt3NS1TWVH52EpNB/u/AqtPC30ifBMAdF/X1yxebTd9AaVCaZD0/6JR7CBwqm13aLYZLV4
 XPn9N9tJa+Ubsve3yRiG0+VpJZeKJW3Re9wZLRY/FHoAlxDhE3F/yiop8B2bCvE5rP4xeiy1G
 WvCAMRaL8V5v5aRDpfJMbxsj9S30vfNeyZ0nVNPsSJqWlwgDt0PEh/xbCQu8mVeAwFeK4gyz8
 BGs78ocSZYKyI/FwAOFZAz2UOEbNCg0oj5HWJLpqpcadJpO4/Wyw66eq2MZlDsx13q5Qz+Cud
 FnWa1DCznu9WQNWGAo2VFZeRhlDRsxKbZ/w1TSWiIfLt2WcVb7+Vpv4Yw46/XYgdJQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.04.22 um 04:11 schrieb Elijah Newren:
> On Tue, Apr 19, 2022 at 8:13 PM Junio C Hamano <gitster@pobox.com> wrote=
:
>>
>> Thomas Hurst <tom@hur.st> writes:
>>
>>> I've noticed a series of about 20 commits in the HardenedBSD repositor=
y
>>> fairly reliably produce garbage names from git name-rev - usually
>>> fragments of another commit, sometimes unprintable nonsense.  Sometime=
s
>>> it works just fine...
>>>
>>> Here's a quick demo showing how to reproduce the problem:
>>>
>>> % uname -mrs
>>> FreeBSD 13.0-RELEASE-p11 amd64
>>> % git --version
>>> git version 2.35.2
>>> % git clone --bare --mirror https://github.com/HardenedBSD/hardenedBSD=
.git
>>> % cd hardenedBSD.git
>>> % git rev-list --branches=3D\* |
>>>   git name-rev --stdin --refs=3Dheads/\* |
>>>   egrep -v '^[0-9a-f]{40}( \([a-zA-Z0-9_/.^~-]+\))?$'
>>> 3eb67b534cab6a78b44b13e4323fd60353003089 (y:    marcel
>>> MFC after:      3 days
>>> Relnotes:       yes
>>> Sponsored by:   ScaleEngine Inc.
>>> Differential Revision:  https://reviews.freebsd.org/D3065
>>> ~3)
>>> 3ac660fc0c6eb0f876972e7e415c89f1ebed1939 (y:    marcel
>>> ...
>>> Passing these commits into name-rev as arguments finds them under
>>> hardened/current/relro~199^2
>>>
>>> git fsck --full does not reveal or fix anything, and the problem also
>>> persists with a build from source from the next branch.
>>>
>>> I was unable to reproduce on an Ubuntu machine with 2.32.0, so I used
>>> that as a starting point for bisection and landed here:
>>>
>>>   3656f842789d25d75da41c6c029470052a573b54
>>>   name-rev: prefer shorter names over following merges
>>
>> commit 3656f842789d25d75da41c6c029470052a573b54
>> Author: Elijah Newren <newren@gmail.com>
>>
>> Hmph, Elijah, does this ring a bell?
>
> After digging around last night and tonight, this appears to be a poor
> interaction with commit 2d53975488 ("name-rev: release unused name
> strings", 2020-02-04), which frees shared strings and relies on all
> other users of that shared string to update their name, which
> apparently seemed to rely on some intricacies of how the algorithm
> worked that are no longer valid with my change, resulting in some
> use-after-frees (though for some reason valgrind isn't spotting them
> for me, which made it harder to track these down).

So we need better test coverage.

The strings are freed for generation 0 because their new name was always
better for higher generations as well and thus would be replaced and not
looked at again.  I think that assumption doesn't hold anymore because
3656f84278 (name-rev: prefer shorter names over following merges,
2021-12-04) raised the bar for names to be accepted for generation > 0.

> Reverting 2d53975488 fixes the problem.

That's a good band-aid.  Reverting 3656f84278 would help as well, but
change the output.

> Maybe this means we need to have tip_name be a string + a refcount, so
> that we can know when we can safely free it?

Sure, at the cost of storing and maintaining the refcounts.

IIRC I also explored avoiding to append suffixes to candidate name
strings in get_parent_name() and instead storing a reference to the
parent.  Many tag names are shorter than the eight bytes of a pointer
and certainly shorter than an object ID, so while that would reduce the
number of strings to deal with (and thus the need to free them), it
probably would increases the overall memory usage.

>  Adding Rene to the cc
> for comments.  Rene: If it helps, there's a slightly simpler
> reproduction: clone the repo Thomas mentions, and then instead of his
> "rev-list | name-rev | grep" sequence just run:
>
>     git name-rev --refs=3Dheads/\* 3eb67b534cab6a78b44b13e4323fd60353003=
089
