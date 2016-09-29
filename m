Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A9E207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbcI2SSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:18:42 -0400
Received: from mout.web.de ([212.227.15.3]:52365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbcI2SSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:18:33 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lud4y-1aqBHu35KC-00znx2; Thu, 29 Sep 2016 20:18:10
 +0200
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7f8ab626-ecdb-70a8-aa19-615c3c84148e@web.de>
Date:   Thu, 29 Sep 2016 20:18:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:345Y9bp76FHD7XLQxglD3ypPS+Wkak3hw2BLa7XmWvqpcrRc1hH
 4UtHIfilmzLNXu910l6S7zFrXspJiTIoqtyfYy4f7OLtYANhxG1xFt8q65dOOhRZd1Rdw5s
 FExHDFcxEYoF2ZnySdTeViULUjRbrLkxQdqCCnB+cStx0EkummTLJPxFaphHsNwvEw0UzrP
 jxfocPr3Xc5gVrVL1jYWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6LnEFfjGkCA=:DWBdX5dXXLTceR6s8898Vo
 eQxQzH+T4wZbEoQnuA3irahoDHO+87WcYQcv0YB1olj3HuRdJ4INyAEIr4spPAzCWozOBiHA7
 YMjGIMoWLV0rxON9zjrW0d3+k3a1/ns9bqyo6CI7ZD/0UGvoBaF1o4F4m3GIyWgDyQS0+xpl6
 /AeNuvu/KCYK/Cuj4wu1J8AT7ktMZrZn8cNy2maIbrsDPW8NfSj6oD+KG9Y4z7zNs5C6FvBZH
 ipmX2S1cyhbkbS8DSuJQW6J63yC5K34bJAzj55FueFsjm6upknNBehH3hPtclGsI7q4D4jtSf
 tACqiXUJQSpJRv5OUITyx5kUOr8CSMpeJO+a+mdcrY/r5Fc+fxU8vRjfXutPfZSfoX+r0g60S
 SEeLPTLbtto5xFghHufs6GsIH+gt/1vKxr89f0Fm4u5Xax8oOoRiM1KRLDRR75epifbBMW6go
 sajU0lOGjzObq/AUjxQRgUdK+aTLWioRBdBnPpaMz/xoP7QzcP83koA2Gf0YMSrORuXb3gNPH
 9ogI5dMft14N592xsLz8NIE/2eIjE5uG4c4qkDavBF0KI753BCfWYxLchjV9DctGOetbNtuh5
 k0jPSUV1t5uqmDp1K8/PUP+4lT4v46T9DSGvX0UbNfJjwBbDYdOLLDgbkmyLjbXlBsvI7YSQr
 CYbofFVTVhayOyNn2vwQyqbjLZh4v+QSmRI515Tktresa2weLd3gNEArNE6kc7wULnoEyR4Ad
 b7/pqq+76+4nbeOmw47gtQZ3Es6c/aMDCgEaWWZLYIBVNLwrdPJL38g2iiVGPA2qs2WRS0wlO
 yDi1vJW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/09/16 19:57, Lars Schneider wrote:
>> On 29 Sep 2016, at 18:57, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Torsten Bögershausen <tboegi@web.de> writes:
>>
>>>> 1) Git exits
>>>> 2) The filter process receives EOF and prints "STOP" to the log
>>>> 3) t0021 checks the content of the log
>>>>
>>>> Sometimes 3 happened before 2 which makes the test fail.
>>>> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>>>>
>>>> I added a this to wait until the filter process terminates:
>>>>
>>>> +wait_for_filter_termination () {
>>>> +	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" >/dev/null 2>&1
>>>> +	do
>>>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>>>> +		sleep 1
>>>> +	done
>>>> +}
>>>>
>>>> Does this look OK to you?
>>> Do we need the ps at all ?
>>> How about this:
>>>
>>> +wait_for_filter_termination () {
>>> +	while ! grep "STOP"  LOGFILENAME >/dev/null
>>> +	do
>>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>>> +		sleep 1
>>> +	done
>>> +}
>> Running "ps" and grepping for a command is not suitable for script
>> to reliably tell things, so it is out of question.  Compared to
>> that, your version looks slightly better, but what if the machinery
>> that being tested, i.e. the part that drives the filter process, is
>> buggy or becomes buggy and causes the filter process that writes
>> "STOP" to die before it actually writes that string?
>>
>> I have a feeling that the machinery being tested needs to be fixed
>> so that the sequence is always be:
>>
>>     0) Git spawns the filter process, as it needs some contents to
>>        be filtered.
>>
>>     1) Git did everything it needed to do and decides that is time
>>        to go.
>>
>>     2) Filter process receives EOF and prints "STOP" to the log.
>>
>>     3) Git waits until the filter process finishes.
>>
>>     4) t0021, after Git finishes, checks the log.
>>
>> Repeated sleep combined with grep is probably just sweeping the real
>> problem under the rug.  Do we have enough information to do the
>> above?
>>
>> An inspiration may be in the way we centrally clean all tempfiles
>> and lockfiles before exiting.  We have a central registry of these
>> files that need cleaning up and have a single atexit(3) handler to
>> clean them up.  Perhaps we need a registry that filter processes
>> spawned by the mechanism Lars introduces in this series, and have an
>> atexit(3) handler that closes the pipe to them (which signals the
>> filters that it is time for them to go) and wait(2) on them, or
>> something?  I do not think we want any kill(2) to be involved in
>> this clean-up procedure, but I do think we should wait(2) on what we
>> spawn, as long as these processes are meant to be shut down when the
>> main process of Git exits (this is different from things like
>> credential-cache daemon where they are expected to persist and meant
>> to serve multiple Git processes).
> We discussed that issue in v4 and v6:
> http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net/
> http://public-inbox.org/git/xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com/
>
> My impression was that you don't want Git to wait for the filter process.
> If Git waits for the filter process - how long should Git wait?
>
> Thanks,
> Lars

Hm,
I would agree that  Git should not wait for the filter.
But does the test suite need to wait for the filter ?
May be, in this case we test the filter and Git, which is good.
Adding a 1 second delay, if, and only if, there is a racy condition,
is not that bad (or do we have better ways to check for a process to
be terminated ?)


