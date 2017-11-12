Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A542D201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdKLUJg (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:09:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:61821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdKLUJg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:09:36 -0500
Received: from [192.168.178.43] ([92.76.226.11]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1eFM8G30XV-001Rqi; Sun, 12
 Nov 2017 21:08:37 +0100
Subject: Re: should "git bisect" support "git bisect next?"
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
 <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
 <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <cc11ab35-a219-8cab-313e-f716723409e4@gmx.net>
Date:   Sun, 12 Nov 2017 21:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pOmsDBMAyZ8pNsT2fIwVQqXu/7M5R32uEgJZA3vbyIxej5N4q0w
 Kh26stAsFWRV73SzoaupoGV0NxjrgwfJwCzEvgipjOL9GAPyR1BbkSUpI8opld7303AvM6t
 wb7cACLlNwtgA4A9LhSWnw+W3KJ6AdZiRT+JkBtsT68dIPs170yMtJNsDgv3NAs2rcOq29j
 KUcvkwbtVOMQiOtFOJ/NA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tBh4TDel++w=:L0Sw3+C2OqFYKX56LHr7Ur
 mYDqEXuQhOVz2Pn35Lj8k2V7tyXEv0KhKBdl7X8jk/Nb2ntb81n7NdiB4xpXgRXYua8hQGrnI
 Lnuyl8mKvztP0F7MISzlJN5xwslEHq9WLps/SZGpe/tuTt8Y8kscqHhC7PJUwPZtyHa3K3dvH
 qzdUci/ZyareQ8NqwdTGb+cEWudc3icruEPPxbxs5cQIPn+wUkcKFgWKR+J91F8/9jkGrBa/x
 H+2huvNFRuD2vzc7SyyHwnpEA6uPj5RAfcK8gYBGMUdkvRolkM8nP/2y87Kwi78MIHjOJgnfe
 8LEQKC4msZDAcvYFjoYsPb1RZtlWop7IKM+UM5fc3pkzsGYTM4G7osnUl1iWzZDiZrIjMub+U
 jusJpUBJ+yrmzqynxm0Gg2MMWiy08ouvz5WPGuPRmxwNkvSvOtQOivf46F9irtDgebNhegEhZ
 XGe4vmMyL2MnEcC+1rmubXMnMAJ1lc5TYiH608dS/YNG0DTeSVWuyYRP8OaY2RJ7P5ls9otmq
 gCSmwTMRi1QbvV7njGDvKLz4TyW6zlYBsE1g+1oILHlQov3jmGnTIV51Z335NLIeomvmDsxJP
 9O8fSXmE9L78bvlSRM5DR22ZjMn3bfzGQMTPlcncZ8twSh4ivj/kGihX/+bkyYO3+O6di9YjH
 J+xU+OoYA+vYLsZHNc05K7YH745sAhGNxuvrntJK7oQnnJn1n/OTUWGSlmZ5n4WHy5AlTubvb
 Q96VvBQQTj7+MOgBW8WHgDZ5pLA9ToiFB7hYTGuKaNJpzg13d/EhRR7VvDC4SiyqucJ+YOOXs
 7BmuHdJXDuvfC/af8DtPipoyS99Q+iBSMv/rva4bTJ0XVsjoX4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 11/11/2017 03:38 PM, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> On Sat, Nov 11, 2017 at 12:42 PM, Robert P. J. Day
>> <rpjday@crashcourse.ca> wrote:
>>>
>>>   the man page for "git bisect" makes no mention of "git bisect next",
>>> but the script git-bisect.sh does:
>>
>> Yeah the following patch was related:
>>
>> https://public-inbox.org/git/1460294354-7031-2-git-send-email-s-beyer@gmx.net/
>>
>> You might want to discuss with Stephan (cc'ed).
> 
> Thanks for saving me time to explain why 'next' is still a very
> important command but the end users do not actually need to be
> strongly aware of it, because most commands automatically invokes it
> as their final step due to the importance of what it does ;-)

I will nonetheless re-roll the patch (that Christian linked to)
after Pranit's bisect part II series is in good shape. I think the
documentation change in the patch shows why the user should be aware of
it (although not strongly).

Best
Stephan

