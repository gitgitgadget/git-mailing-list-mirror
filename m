Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC0A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 05:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeKSPnm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 10:43:42 -0500
Received: from mout.web.de ([217.72.192.78]:56685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeKSPnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 10:43:41 -0500
Received: from macce.fritz.box ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJC3-1g06BF0ar5-00TTBv; Mon, 19
 Nov 2018 06:20:58 +0100
Subject: Re: Cygwin Git with Windows paths
To:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Steven Penny' <svnpenn@gmail.com>, git@vger.kernel.org
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan> <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
 <005801d47fad$345d5a70$9d180f50$@nexbridge.com>
 <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <bddb9e06-2688-c459-9467-a3f0978866f9@web.de>
Date:   Mon, 19 Nov 2018 06:20:51 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UYYOaLKEnVatYuvDPT2fkc0b9xIx6JOmfAiVYm180zCAxGLhxVE
 t6bWom+ewHoAT5wdU7Bfj8JuTxAv4V9bkc3YMrckOLuAR7xerXi4ISL+s9CRlQe3sn7rdSL
 YIohwMUlDCG7KPlh0yaMCOhWuoDSmlG4aSbv8H8T77CwW12YjT4wPpt+iCLsekNGsuRyJul
 lw/ROx+2pVnyaG7O+Np5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Defkqa+eDYk=:9DcfKW+YLip2ff+GbDIIOT
 UQSOK/5kjQ/JdgJ+47QrYsB1uRCiNwAAzbbUm3FglLU16cibTCEw7AOabWrY5T9uJ0VuLsuJ+
 1xJ7b4QvubHwZXtHZiYCAjWccQmhjXB4pXt0xoGeNyWaYpGFOj+9Xa21+mczvGR5X7XpgsJY3
 7pg4zfXWE/d11bupt8LjYNWbNMUj2oSzROn7zp65yIqUmXlulgn8K5+SbX++z0GthoKtnoA0p
 SRh+lYS5nsW0hMDAPSLb8+ALarbLi15GPvGyFTCwT7j+1a+VFiXtaEKw/fOeg+HpPDUNdN861
 NT4hnX2bqZirIohJg5qldxItd7Cuh5oieX4jACbcFYm0fyNlKz3QQWpZB18ejs5ktmIj1jhdY
 BCOVpAPdc5/3oS0xL97DffdANln216YsHsxyDzBvvYOnPcheSn8pdbMP/nHc+rrA0nFI/1VhR
 c1IcrUTMw+FXT+RIDMtp6EO4y38mYb93EX/frHRfJ72JbjmFKzp7CiAw3BE0Gvh5sWG7JR/W8
 VU2bwRqRHZat0RK0ZdfwylunG7gJr4RyRw9eQ4Ckfw+fCeyrRLI/MAOxn5Atlu1UkBuAZhJZt
 yyJ+2nP471lAVpayWia7RxKXc4iAQWtc7geWJFrtkzrEJryh3bdhA6nDCNpfjCEOYRn2/ot7x
 FMSVNLu74h8bN05bQdw3XjWOEPs1NBI1bIZWS0ZubWcMN3uGpDgcgEFZdX+c+/v+KkJKwfVCW
 yWdUJj0oGbhxndzYX3iX19PZMEsk3+lj9f1jv0d31/55ttpzqt7G0Ocu2Y6mh/ELVF9DRgsx8
 +GOuKF7EnZ/6hqVlzbCUmv3VUSa9bXPidBzEFzmJq8SupGbuTJnrEj9Nu4p3StQYpfu3vDXMt
 dcLPA/8+OtSQ2tPv+OOQXyythyprpAeO+YVPtm9WLdDQ9Jd33ZuSLq6BHRbNjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-19 04:33, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
>>> Torsten Bögershausen <tboegi@web.de> writes:
>>>
>>>> And it may even be that we need a special handling for the "\" to be
>>>> treated as "/".
>>>
>>> I do not do Windows, but is_dir_sep() needs to be tweaked if you want to do
>>> that.
>>
>> Heavy Cygwin user here. It is used in my environment for
>> cross-compilation. Everything should be done using / separators in
>> Cygwin, not \. So /cygdrive/c, /cygdrive/d always prefaces the
>> path rather than C:\ or D:\, which won't parse. It is,
>> essentially, a bash environment, including that git completions
>> work properly. Backslash ends up doing what it would in bash.
> 
> In short, in your opinion, the original message in this thread
> expresses an invalid wish, as C:\path\to\dir\ is not a valid way to
> spell the path to the directory, and it should be written as
> /cygdrive/c/path/to/dir instead?
> 
> How well does this argument work in the real world, when another
> claim in the original message
> 
>     This causes problems for any non-Cygwin tools that might call Git:
> 
>     http://github.com/golang/go/issues/23155
> 
> is taken into account, I wonder, though?
> 


Back to the original email, where the path embedded in ''
and the bash does not interpret the "\", I think.

>   $ git clone git://github.com/benhoyt/goawk 'C:\cygwin64\tmp\goawk'
>   Cloning into 'C:\cygwin64\tmp\goawk'...
>   fatal: Invalid path '/home/Steven/C:\cygwin64\tmp\goawk': No such file or
>   directory

>It seems the problem is that Git thinks the Windows form path is relative
>because it does not start with "/".

>A Git Bisect reveals this:
>05b458c104708141d2fad211d79703b3b99cc5a8 is the first bad commit
>commit 05b458c104708141d2fad211d79703b3b99cc5a8
>Author: Brandon Williams <bmwill@google.com>
>Date:   Mon Dec 12 10:16:52 2016 -0800


The first question is, does this work under Git for Windows ?

Looking into 05b458c104708141d2fad, it seems as if the following functions
need to be "overridden" for cygwin, similar as we do it for mingw:
 is_dir_sep()
 offset_1st_component()
 find_last_dir_sep()


If nothing works,
it may help to add some fprintf(stderr,...) in the functions used
by 05b458c104708141d2f:

strip_last_component(),
get_next_component()
real_path_internal()
