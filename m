From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/5] Submodule Groups
Date: Wed, 25 Nov 2015 20:18:02 +0100
Message-ID: <5656096A.7010408@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
 <5655F166.9090601@web.de>
 <CAGZ79kbd2g9QSuGmyf6Ybp6dCqMfSBqj8WZgfTejXU8OdszaBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1faK-0002a0-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbbKYTSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 14:18:31 -0500
Received: from mout.web.de ([212.227.17.11]:61038 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbKYTSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 14:18:30 -0500
Received: from [192.168.178.41] ([79.211.124.82]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M4qWn-1aGShr2OZJ-00z24S; Wed, 25 Nov 2015 20:18:10
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbd2g9QSuGmyf6Ybp6dCqMfSBqj8WZgfTejXU8OdszaBw@mail.gmail.com>
X-Provags-ID: V03:K0:zaE6FQ8QGiTT0xr1JVNKAk8RToCGHv8sRbOf7rm+YJhu07e8gWR
 k/fh2Cr9eaewIAQ0XyNyxkP9AN+02d0IGu4SsRpWHLaTWhYXD9kN5PFUir8hKpBOun3ZbY5
 V+32Rb4Xvdj7OcV1+lPWjK5F2rMZZ9l18HKIb1F8WjM302ILDEynwyGWL3dO2A3uK0zGQWW
 +afXGqsOhOU2XqXFRxjhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lCYo2hc7Suc=:aPQ/ny8qaaQjQi7yUlWilK
 LH7LZfguczFV5NvS2skyU4y8UYPBsHOjxgzrTRYWWZciUuggnuUbsYm06DOpu6xXnHxoGyYEK
 tKFC/DGiaLNeUGtXy+JFyyY6EhXUT/cxzTftClVJaUr/KE3/rJo4hvsdIBe4szJsBNUJQnJAd
 CKLtCY3utERdZ3y+o2acSCsVp2Tml4BOcVB138EXBLoAttYI4wksPHOjMCu9lwF+W8StOdgtX
 AyLgdD/aSXMXBO9TWyzKCGc+oPxEsVS0Es2nrg1/MwnueWlRxbFDGfFtQbOHPZhlCHECjWakd
 SBloXxH1zpvJeYLtBpVDZdPR/Z/rDETo4BFs/1VMAzzfmt4/heAw3u6iK13UKroMBQZN4zDUc
 ejvNLC4uNwb51Ezd0nfAG/2dFEConVoJrIlZibiuJmpEuDkRFpueCcyARu/GrTRel2MDcHWfK
 avzjF92d8cuS87+1eR0Yi8kNPGUbOQGFFrzYHUcSVsQgyZRIY/zZIdYbCg/iTx5b4Cj3qpAB3
 pM9ZtTJDbrzX2g/1lEjrRgagXfLR5Az5RtzivcVLn2tGI4Aax67Rnpc42SSdodt2UUhv3mg1y
 lfLBhIv6S80PPdScmk7RSgj/zMCWtsxlzMgMI4tjpcnQJzjEmWdDVsD/6AeiwYNqKIEOStjNC
 r6dNk8wJtPDy7uk/1IWahqPUQ2vMaVHmDXOzD/OKiCgVtusJWET+SYsDhdqL9pzJn63bNjpdz
 /Ux/LvzY+QEobPnyNrl8YGK2jqJb5k5Uy7eagGqy1T5UfFeisE/2jnkAZwv2S4HLyrrxs6y0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281730>

(Sorry for the resend of my last mail, but I received bounce messages
from my email provider)

Am 25.11.2015 um 19:00 schrieb Stefan Beller:
> --cc Johannes Sixt
>
> On Wed, Nov 25, 2015 at 9:35 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> [submodule "gcc"]
>>>           path = gcc
>>>           url = git://...
>>>           groups = default,devel
>>> [submodule "linux"]
>>>           path = linux
>>>           url = git://...
>>>           groups = default
>>> [submodule "nethack"]
>>>           path = nethack
>>>           url = git://...
>>>           groups = optional,games
>>
>>
>> Yup. Do you want the user to select only a single group or do you
>> plan to support selecting multiple groups at the same time too?
>
> Yes you should be able to select multiple groups, such as
> default+devel or alternatively default+games.
>
> The logical OR is supported in this patch series (all submodules which are
> in at least one of the specified groups,i.e. A OR B OR C ...)

Good, this is more flexible than restricting that to just a
single group.

>>> and by this series you can work on an arbitrary subgroup of these
>>> submodules such
>>> using these commands:
>>>
>>>       git clone --group default --group devel git://...
>>>       # will clone the superproject and recursively
>>>       # checkout any submodule being in at least one of the groups.
>>
>>
>> Does this automatically configure the given group in .git/config, so
>> that all future submodule related commands know about this choice?
>> Me thinks that would make sense ...
>
> It does. Internally it does
>
>      git config submodule.groups A,B
>      git submodule update --init --groups
>
> whereas submodule update checks if the submodule.groups
> value is set and if so operates on the groups only.

Makes sense (except for the "--groups" argument, see below ;-).

>>
>>>       # as support for clone we want to have:
>>>       git config submodule.groups default
>>>       git submodule init --groups
>>
>>
>> Hmm, I doubt it makes much sense to add the --group option to "git
>> submodule init". I'd rather init all submodules and do the group
>> handling only in the "git submodule update" command. That way
>> upstream can change grouping later without having the user to
>> fiddle with her configuration to make that work.
>
> Well if upstream changes grouping later, you could just run
>
>      git submodule update --init --groups
>
> and get what you want?

And make life harder than necessary for our users without having
a reason for that? Except for the URL copying submodule settings
on init is wrong, as it sets in stone what happened to be in the
.gitmodules file when you ran init and doesn't allow upstream to
easily change defaults later. We still do that with the update
setting for historical reasons, but I avoided making the same
mistake with all the options I added later. You can override
these settings if you want or need to, but that shouldn't be
necessary by default to make life easier for our users.

>>>       # will init all submodules from the default group
>>>
>>>       # as support for clone we want to have:
>>>       git config submodule.groups default
>>>       git submodule update --groups
>>>
>>>       # will update all submodules from the default group
>>>
>>> Any feedback welcome, specially on the design level!
>>> (Do we want to have it stored in the .gitmodules file? Do we want to have
>>> the groups configured in .git/config as "submodule.groups", any other way
>>> to make it future proof and extend the groups syntax?)
>>
>>
>> Not sure what exactly you mean by "it" here ;-)
>>
>> Talking about what groups a submodule belongs to, an entry in the
>> .gitmodules file makes the most sense to me. That way upstream can
>> change submodule grouping or add new submodules with group assignments
>> from commit to commit, and "git submodule update" will do the right
>> thing for the superproject commit checked out.
>>
>> And I believe that the choice which group(s?) the user is interested
>> should be recorded in .git/config, as that is his personal setting
>> that shouldn't be influenced by upstream changes.
>
> Right. I once discussed with Jonathan Nieder, who dreamed of a more
> logical approach to the groups/sets of submodules. So more like set theory,
> i.e. have a more complicated grammar: Get all submodules which are
> in either A or B or (D AND E), but which are never in F.
> So I'd imagine the groups are more like bit tags, and you can describe
> a patterns you want.

Ok, we can start with union and add intersection later when needed.

> I guess we want some more powerful eventually, so I asked this open ended
> question there.

And I don't think we need to implement everything right now, but we
should have thought things through as far as we can currently see,
to avoid running into problems later on ;-)
