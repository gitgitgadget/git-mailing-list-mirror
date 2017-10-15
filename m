Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B67320372
	for <e@80x24.org>; Sun, 15 Oct 2017 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdJON0M (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 09:26:12 -0400
Received: from mout.web.de ([217.72.192.78]:52233 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdJON0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 09:26:11 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4fx-1dkfw23LTx-00YSK7; Sun, 15
 Oct 2017 15:26:07 +0200
Subject: Re: Bug: git ls-remote -h / --head results differ in output
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
Date:   Sun, 15 Oct 2017 15:26:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:B1Gd00uUMNVXZkD5BZWvbtWK7iv6ikdGBTVvrjfkc8ZrRd53rmY
 JkAHo5i/+THn4iFl2id+J7TGM83M9+LYmonMqJIAtFE9tgJbF4j9n23thyOImlaCepD+QNM
 JzyNseYIG8UZQG2wtRdKr9G2yQ3YXInbRfkGIpkVzLIJkVWEE9mx+Z2BiPGW/vGNBTuN0mY
 KygpC/A9Od6z3v+N36tOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+vLTsgL4TRw=:cLJr4/UjeAIEFxhNW1w8W7
 EmC1Y9KzHRYWrP4mZCCAmeLIOjOTqJV0F2lnCeX6ZTn7qO915tFW7qXfB8KtuG/Orv3d/e3pX
 YvhRMG+WPm+TB/KzTcvfe20Pq3/KaCUCwXLDGMI6RWoSaVK6nlgI8TMjg754FM4bIeAv/iB7Y
 UOFh7Ae1LiUk9t+8O4ImiIEQ2Xlhrq2VYLYyE26MxYAlVZ/qYrz/2bc13BMSANH1KvcP4dAJ9
 1ihDyfCwlJQPW+6rKwaEmUG60r573E/h0KyrZxwI4J1/OTOZsUI8Ld4wM/JjuPTqwIXYqSuBV
 yvzsxg7r2Kj21Mkmqq6u6vfYA5/N1xS+8kabhUdEm43U/1GgLAbQqBvPU+vhf6XJukCvusmYB
 UO4Bq86MElB/XA9+cz5hJpakv76ROi6f/NJv9YoJPMf7Sq45qXuUjmTZdniROOgPhuEPp4H7Y
 OlCjq7kDXyy/EowG3A03BdvYxmv9GtDhbXfUZMIcPa5aC72jbAJB8cXj5gIO5GMhR1CweQ6fh
 89LW0UptNqhXaDkDpLg/WvlEcOfMrdbL8rssx33kf/1vBeQh9t4JRsVba1L+VmMDIoNXZXxmd
 K6ru8+/RkTeG/o+K/Dd5IW4UyLbLuIUrMinu6HDNqb77kKo9BkDzeNnn5LCLWqPViUe56QA0F
 0IeQ3Lmz2eH2OG78PtMXglzmiMC86pN31GFp/yxphUtTzQD/HUq9XqorqRoY+BS5C25X2xc3H
 hXG9JE7oQVPzccHWMv5gqMF+RjJwhdIBpcOUMLwV8RY1Kk5UhFisBSYdWfSLQKMTKuFQEIXYq
 IikfEHBQ0DSinLOJKZdoq36L5Bd5fPPw9l4Y25iHFmCE8FFiaw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.2017 um 13:08 schrieb Martin Ågren:
> On 15 October 2017 at 12:02, Thomas Rikl <trikl@online.de> wrote:
>> Example:
>>
>> tom1 ~/emacs/spacemacs/.emacs.d $ export LANG=en_US.utf8
>>
>> tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote -h
>> usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>>                       [-q | --quiet] [--exit-code] [--get-url]
>>                       [--symref] [<repository> [<refs>...]]
>>
>>      -q, --quiet           do not print remote URL
>>      --upload-pack <exec>  path of git-upload-pack on the remote host
>>      -t, --tags            limit to tags
>>      -h, --heads           limit to heads
>>      --refs                do not show peeled tags
>>      --get-url             take url.<base>.insteadOf into account
>>      --exit-code           exit with exit code 2 if no matching refs are
>> found
>>      --symref              show underlying ref in addition to the object
>> pointed by it
>>
>> tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote --head
>>  From https://github.com/syl20bnr/spacemacs
>> 07014deead544c51fa6a826e91fe2ef05bf04323 refs/heads/develop
>> 8e1af145480d53e8d32cdff2c83291889903164b refs/heads/master
>> 2450b7e276634ece07b6b7ec6ca6c287af86caf3 refs/heads/release-0.101
>> 8dadfc1494544bb152e80c2a436e43bc3713b389 refs/heads/release-0.102
>> d993a021847cde2c42865bab6afa8adbb2edda0b refs/heads/release-0.103
>> 44d4525543b1f2a385142721d0cb16cd3b0be580 refs/heads/release-0.104
>> 9f9faa404e3dec3e08cc73cf7b5a0439fc309800 refs/heads/release-0.105
>> 8e1af145480d53e8d32cdff2c83291889903164b refs/heads/release-0.200
>> tom1 ~/emacs/spacemacs/.emacs.d $ git --version
>> git version 2.14.2
>>
>> on archlinux: Linux achse 4.13.5-1-ARCH #1 SMP PREEMPT Fri Oct 6 09:58:47
>> CEST 2017 x86_64 GNU/Linux
> 
> The behavior you observed matches with the documentation in gitcli(7)
> and is arguably correct. A lone "-h" prints the help/usage. But I would
> agree that this can be confusing, especially when considering
> git-ls-remote(1) on its own, without any extra knowledge about what a
> lone -h should do.
> 
> So -h and --heads can only be used interchangeably if you have other
> arguments. To see this, you could, e.g., try "git ls-remote -h -h".
> 
> Some more details. This looks like ba5f28bf7 (ls-remote: use
> parse-options api, 2016-01-19). Before that, "-h" was handled internally
> in builtin/ls-files.c. After that it is handled in the general
> options-parsing machinery. See for example 5ad0d3d52 (parse-options:
> allow -h as a short option, 2015-11-17), which explicitly wants to print
> the usage-string if "-h" is given as the lone argument.
> 
> I'm not sure which is the best way forward here, or how many other
> commands could have similar pitfalls. For example, the "-h"-flag of git
> grep shouldn't be able to cause this problem.

The flag PARSE_OPT_NO_INTERNAL_HELP should be used to let git ls-remote
fully handle -h.

The same goes for git show-ref, but perhaps it's better to remove its
hidden option -h by now.

But stepping back a bit I wonder if the demure internal -h handler (that
only speaks up when nothing else is said) is a bit too subtle.
Reverting 5ad0d3d52 would make the need for PARSE_OPT_NO_INTERNAL_HELP
more obvious.

René
