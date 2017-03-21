Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162D92095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758136AbdCUTL5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:11:57 -0400
Received: from mout.web.de ([212.227.15.14]:63831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758022AbdCUTL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:11:56 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhQi-1cIRqu3saC-00aVpO; Tue, 21
 Mar 2017 20:05:13 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
 <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
 <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
 <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
 <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
 <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de> <bcrjmkhdzucyoncxqruj@gkuh>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3e8b756c-81bd-0a29-e032-d5733a8b3ed0@web.de>
Date:   Tue, 21 Mar 2017 20:04:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <bcrjmkhdzucyoncxqruj@gkuh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5f96xm/1plnQbWWCjxWcTn8oosug9XPNzUaRkGxF3ibmo+V69kH
 w8CfiPQvzpfi9NF4slPdqWmXAVh0AJaDiGz5VZw5+NrSmgDT2KqTI01WfiG7ckgdaBsj4W8
 agN+4laNwTezV1TY3HfjOHxbz5yl8MIG6cp9Q8m3XWi7pt0CTOryswl4pyahkpqYnX1vchC
 O0HCxdl7D91TSgKOexUJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ewHwy2loZy8=:2+ZYNhEYqh+exvjPvaksQI
 iBq5Wf6AoyKeXG2HqwLJCn5J6pynSFL8RnOyTuzpGerbgG8a8Sj02t3wg1J9UW/QQQGw4IFn7
 SIkd2WfgfibvUV1CJAP8O/iPNRqXV3Pt2ifM3S0rR3jJgW5ZtBClrZ5E/yiDk/8KDnJseWe8Z
 Ta6dbL/lf2Kyk7N2zxHy9cq1M6XsWKDJX8pjgcIlLgIDJl5vMhd1CaJypRhkOMKwGg7r7ahir
 LUEWiudxgANNUjLEsrnXwnWTRz43sipUsH4Iyq4LydoIA2oV5fx2Y5Kq4EkfnNcjbjyph50yM
 0elH1BVYwqmuX6hdesoEZcklqRNaulDx0yDeqbkt3qe8GQGCjAi+ikc17tvJ20JlMkD0Bl0SK
 au0DrwldH/rQQYNwCbwtj8I1eWAHFR3C8o+PqfRMMEnnb+Xn+r18ZNz0CEQrnRgAEUK0YXGya
 QRg+9IQ1EvlXBtLAQ9NshU3UE4RGYMrgB2fQCQEu5b0+kV4O6Jm2B1QpQ/xyWqjgvMshj0ytw
 MQOA6RcJvxgZWzDU1IA8CMqsE60Gpuofw4IcDd3f1X4Ne7fU2s6FR/dLcNtPIg1jImTv1mt0s
 oxs5McJrd6J5Ox0OZcmWybe4XtjO6croMWn82sHz5Yk0G1HC+SQgvJsOgOyAiDD2fY04CJe+k
 LNnbZroiJBjlbXMFrzOE8fgC8RGDPeXu31PXylkUMxQduvq1kVbvf2zKU8yFWxHMIzbSyktF7
 UESkjpiV97XRNOHYaT7uigHCWXmhjRj4359DpSNrpo/1kRyU7UpdVvOKWvTYDlh/aCXbK8duw
 B8hRToS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.03.2017 um 14:29 schrieb Zenobiusz Kunegunda:
> I think I found a way to reproduce this error.
> I installed FreeBSD 10.3 under qemu with zfs partitioning.
> Test program did not report any access errors.
> Then I did chmod 711 /usr/home
> Now program started reporting permission denied errors just like this:
>    $ ./a.out
>    len = 0, errno = 22, Invalid argument
>    len = 1, errno = 34, Result too large
>    len = 2, errno = 13, Permission denied
>    len = 20, errno = 0, No error: 0

Yes, and I think we can take ZFS out of the equation.  As a regular user 
I get this with UFS and for $mode values of 000, 100 or 400 (with umask 
0022):

	$ mkdir -p /tmp/a/b && cd /tmp/a/b

	$ chmod $mode /tmp/a && getcwdtest
	len = 0, errno = 22, Invalid argument
	len = 1, errno = 34, Result too large
	len = 2, errno = 13, Permission denied
	len = 9, errno = 0, No error: 0

Only with both read and execute/search permissions for the intermediate 
directory I get rid of that irritating permission error for small buffers:

	$ chmod 500 /tmp/a && getcwdtest
	len = 0, errno = 22, Invalid argument
	len = 1, errno = 34, Result too large
	len = 9, errno = 0, No error: 0

So a workaround for you would be to run "chmod a+rx" (or similar) 
against all parent directories of your repository.  Another one would be 
to keep the path length below 128 characters (that's the initial buffer 
size in strbuf_getcwd()).

Have you been able to test the patch I sent on Friday by any chance?

Thanks,
René
