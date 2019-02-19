Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBA71F453
	for <e@80x24.org>; Tue, 19 Feb 2019 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfBSUQE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 15:16:04 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:60851 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSUQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 15:16:04 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id wBo8gA1uVN402wBo8goVQQ; Tue, 19 Feb 2019 20:16:01 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=afAfYigt c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=8pif782wAAAA:8
 a=vnREMb7VAAAA:8 a=7_-uMi6V09WDFL-rboAA:9 a=v80MS8MP7OqDrXrL:21
 a=_tSlEJVeEWNB3W9y:21 a=QEXdDO2ut3YA:10
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, jpyeron@pdinc.us
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
 <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
 <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
 <20190219100136.GO1622@szeder.dev>
 <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <57234e45-69f3-8ff8-b232-eff4985efda5@iee.org>
Date:   Tue, 19 Feb 2019 20:16:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGW/iA0GkfR+n1wzLHv/GY2Q/fEznGRywXt/UQ4FZvyRko5JtY6FpTB8/TvDujO+hDLjMI1f+xwQDZTjKwgBKGiK/awoYxDRFTT1+In0Q2+g+MAM2S+5
 EZoY1s2ENRP6yv5oGMahWZqdSIn23GaiQZ0tZzty5+M8KVgbIDWLztDZD/E4oFE05EucPqObVGJFA7gVCcr5jqEdt8w0IlSD4A86ul8CQKVvoD0x5Wf4GDul
 eWjeRTAG6t2LHgIZ65iZaIGlrvXsqCIkc5fZjc6bqsnKA0YIwo7BoMlt2K3hfpXT35fTfWIwms/xJitwXmQvKlGOEc070hADPyXlqJgEuuQ3yI803wUyS3J3
 7s0GbJgW4PF9dFzkcT8LBCVPA+kb0FTH9KUorBeXcrtVk5Sg+fk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On 19/02/2019 14:58, Johannes Schindelin wrote:
> Hi Gábor,
>
> On Tue, 19 Feb 2019, SZEDER Gábor wrote:
>
>> On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:
>>> 1. Dictator
>>> Concern: "Bad" connotation.
>> "Benevolent dictator" is a well-established term in open source
>> projects, and it has an inherently good connotation.
> It is a well-established term, alright. Does it have an inherently good
> connotation? No, absolutely not. Every time anybody calls me the BDFL of
> Git for Windows, it annoys me, to say the least.
>
> And yes, when I pull out my generous self, I can give you that the
> *intention* was funny. But to some, it is not funny at all.
>
> Besides, in our field we had pretty established terminology for a long
> time. It was the *architect* who had the final say over what goes in and
> what stays out. And the respective team leaders were responsible for
> respective areas of the code, trusted by the architect.
>
>>> Further, "googling" dictator does not give Linus as a result in (at
>>> least my) search (bubble).
>> https://en.wikipedia.org/wiki/Benevolent_dictator_for_life
>>
>>> Suggestion for substitution: Principal or principal integrator.
>> These are poor substitutions.
> I agree that those are poor substitutions, but shooting down without
> giving better alternatives is a poor way to reply ;-)
>
> Ciao,
> Dscho

I tend to agree that the 'Dictator' perspective is probably a pretty 
poor choice in modern times, while the other (Lieutenant, Blessed, etc.) 
word choices are now considered (in much of the millennial society) to 
be old fashioned, or worse.

However I do caution that we can't be fair all the time. There are a 
range of impossibility theorems [1,2] regarding making things fair.

Ultimately some one (The Maintainer) must make the discriminatory 
decision as to what to accept, what to choose, or  to reject, or select 
their own preference.

A probably bigger problem is actually the limited number of actual 
workflows styles that are recorded (and hence shortage of words for 
them). For example: patches vs PRs; review process style; even a term 
for the users 'backup' repo (on GitHub, GitLab, etc) and how it should 
operate. The mental models here can be hard.


Philip


[1] https://www.youtube.com/watch?v=jIXIuYdnyyk Tutorial: 21 fairness 
definitions and their politics, Published on Mar 1, 2018

[2] Arvind Narayanan: Associate professor of computer science at 
Princeton <https://www.youtube.com/user/33BitsOfEntropy>

