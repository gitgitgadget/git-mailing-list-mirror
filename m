From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Sat, 27 Feb 2016 08:12:22 +0100
Message-ID: <56D14C56.6070306@web.de>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
 <56D078F3.9070905@web.de> <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
 <56D0D2DF.1040807@web.de> <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
 <20160227032907.GB10313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 08:12:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZZ3c-0002mo-I1
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 08:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbcB0HMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 02:12:48 -0500
Received: from mout.web.de ([212.227.17.11]:57502 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbcB0HMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 02:12:47 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MPpE6-1aVjYq0Ma2-004x1d; Sat, 27 Feb 2016 08:12:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <20160227032907.GB10313@sigill.intra.peff.net>
X-Provags-ID: V03:K0:wdRUH8FktTg9DXOJrbfDK05xb/CCOYYQDtiXSUwES7SqlAoXpY3
 OM/2sFwNpKKTOofah3GxlOC73itzZBNgqesOlV8urLTppN1qKBBqBImyL3qQly5j06VsFs5
 Nx0Eg8CiG+CWydvLwseaQn8OO6L6yWyoMGdwLQV766u3EpmeWsBY73RK3ME05Ordr2t9K1p
 37JIrml3aYi3IKUcj1ANQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UCrSOWr2HHY=:2cM0JMTzQriohiLd5kDmn9
 VXFwtsHFBsXLkGiO7QJWRynaIXA9HMBw3poeyRyyT7AiUBM1CXcrxtQyRIpMKrrUCG5E4CCZI
 pHaZSlhEtUBovx+GGAPjzJyJGjbTuA88gJWyEjpXarLNg04Dzu8Q46Suqxjp4IJOMrgGKxBYL
 NcungKWWjl+XCZfrio7YkamuUsOhxZyL3ZghkRcZsNRveMORUO6337tF0fyT2fn6h8hT3FpLs
 o6iZwKGDD3TbLktatiV3XfTJ9+DZ80/CacU4xtFQpyTTv8dsE3IJYirb0bYc7mPcel7+BUzIf
 5XAuDGbe0oBPyNYNJ1K4CMo2Ux33mvR34nkqFodGS3iYzBokxtWNLKKMY+VSP7bVxANtorlPU
 mHOtNkGzvGm/7U9Atkcr/pS/vEUxpfoUnKb/1gV8Gi5lPx3GxFUHF3u6iohkqSjP5zMMQ6PWM
 R8+WwiepSYpkNHtFGJfitIWrvsBmIOgjDqk68fpWj+TGieVCILUHTVTuOkxuZB1vN2es1dzA2
 Knbz8uUWRYacSbr66/iay5zpfi3njG0LR0sii5rY+9tgbuv8nnb+bms+dH+fn2MOE5Uw6C/VX
 0fACyt9ETz1GEhBwpsPv165UFlok1HkQQLr0/ED1XWFoORyTY5ReC2xA+Snr6P3BjRWgw2dJL
 JSjdY2uMZVYymD2YsqokZgAmMIdFOv57+3lfJP0l/KTjBZ3MBcEc9BaWqK34oB3nVuT1iqm2p
 ozz0lhPq9aV5wpd6oVKXHpJb+NfZxXKJIk/iYb60yplCEXpogCyiFGqWPclraXJxMImDwup+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287684>



On 27.02.16 04:29, Jeff King wrote:
> On Fri, Feb 26, 2016 at 03:35:10PM -0800, Junio C Hamano wrote:
>
>>> Digging means:
>>> run git bisect and report the commit.
>>> And this makes the compiler happy:
>>>   Revert "tree-diff: catch integer overflow in combine_diff_path allocation"
>> So?
>>
>> Identifying two versions of the same C file, for one of which the
>> Apple compiler does not give you "internal compiler error" and for
>> the other it does, may help Apple engineers to debug their compiler.
>>
>> But we cannot and will not revert any of our code only because some
>> vendor compiler is broken.  It would be a different story if we were
>> throwing an invalid C at compilers and relying on a bug in GCC that
>> accepts an invalid code, but I do not think that is the case here.
> I think knowing the commit that causes the problem is interesting for
> us, because it lets us see whether we are throwing invalid C at the
> compiler or not (the compiler should never segfault, obviously, but I
> can believe that it is more likely to if you throw garbage at it).
>
> But that commit is one of the tamest, I think; it just seems like a
> boring compiler bug.  I'd be curious to reduce it to a minimal change
> that causes the bug, just to be sure.
>
> Torsten, what is the compiler version (I don't have Apple compilers, but
> it seems plausible that older clang might have the same problem).
>
> -Peff
That's machine is running Mac OS X 10.6, which is no longer supported
with updates.

 gcc --version
i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. build 5666) (dot 3)
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

There seems to be a clang as well:
clang --version
Apple clang version 1.7 (tags/Apple/clang-77) (based on LLVM 2.9svn)
Target: x86_64-apple-darwin10
Thread model: posix



If that information is helpful:
On later versions of Mac OS X (and/or Xcode) gcc is a wrapper to clang,
and this is what I see under Mac OS 10.9:
gcc --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 6.0 (clang-600.0.57) (based on LLVM 3.5svn)
Target: x86_64-apple-darwin13.4.0
Thread model: posix
