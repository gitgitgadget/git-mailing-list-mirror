Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A06D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 13:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeAENyu (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 08:54:50 -0500
Received: from mout.web.de ([212.227.15.3]:59946 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeAENys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 08:54:48 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoCT-1ewRxr00Bx-0117I9; Fri, 05
 Jan 2018 14:54:38 +0100
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
To:     Junio C Hamano <gitster@pobox.com>
Cc:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
 <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <5A4B2DA5.907@hiroshima-u.ac.jp>
 <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <955dae095d504b00b3e1c8a956ba852a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <5A4D9089.3050209@hiroshima-u.ac.jp>
 <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de>
 <xmqqmv1tfpqh.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ee76246b-579c-fe01-eb9c-d400061b47b6@web.de>
Date:   Fri, 5 Jan 2018 14:54:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqmv1tfpqh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JMiZcDI5C1Py+5bWu//at++h8UT5AWywb/YYA7LKQPUdaLqh8qi
 bMr5RxE1X75zTRz945RJCurHOu9WTxj6hPjdCzJRAkWnPqm++M6Wtw2Vpwe5wHJuKqusPjt
 KyeuNb70YdWSp2CYT07YZSGDHIHhnYJgQF5jc7MAZ8il5vi+rtHMRWwxa8+zRwn7JVoNH4F
 3g+q+I/I6ycbvIl1kK80w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/t7j+gfzKfw=:C7NkZroaaw7u9wFmQecmFi
 teCRAO/PojbW1H4dFI5NTXctm4uSyd8+KWWzATchUMYFhs5fArIqQ+x71YYwLa/DeetzzGnxs
 D2fgdx+JfVfrXQKgqXgsLd7AMxwdMHw3Bf9J6EYZG+GG/trSBSraNaFR92m0njI04XetOY5X2
 Qm1C3VR6lkxrf5JdX04N9MF+MtODVOnha2NS2CnB523TC+6gE700Qa+TI6j6e+p4T9y8ilCAo
 2J628aPOnUYG3rOoiMWV8Guz0BQwx+rkiKrmXjyICDkQvY+vXUgvbg7VakX8yPFumc3nGBFxA
 gTonQ3IXxAzwhZKXkR792WwlgZtSRdzpv6VjNnAZTZX71WdpcONxNiFYH+bBFyUhM7UI6gSSl
 d9tMwHWULhOrYwruT3QCXLuvVwbkEXdsD0jbwZDL49Tl4YvneeWw2DhV8fnVDdtODV7KxhC4i
 h80f6wiQXUpGOhisulpRGn0URBCDaDWiZJeBDPkXJW1FEgeK6sAvQlhqpEVj78cX7s6MYP/W2
 yGVh6pSnqKge3VF0/5aH2u+bkneLxUUmvSAx2zYKvoOu7dM8x+wwV79JZfCKnGLM5dA5+Z3RM
 +v+kTZssV9UvbEikG3YgbGu9tixsUWwuTeK0I9nwAXrMIT6GltaoTIrKlPmdElzqIMMAxP87P
 lUa/FaZcCthEkXkUH2S1NPTj/UvuSlFSOl0GugnySlN0WtxYOYozXlB/e9hmJ0PtjR6cErNFK
 SlDpBEJYU7+9f4Klv4HTLdrBKEaqpvTIf91Qu6CFu70NwS5nBo1ZOVRGspmY7mPhkLT5Ew6DW
 YxI0BJnhScPNJFQXE8A1WWv/4S3zr4dLUtaDKwchNqQQKCEZco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.01.2018 um 19:22 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> I don't know if it's a good idea, but perhaps we don't even need a new
>> option.  We could change how pathspecs of untracked files are handled:
>> Instead of aborting we could include them in the archive.  (Sounds like
>> the simplest possible interface, but may have practical problems.)
> 
> One practical problem is that users who do this
> 
>      $ git archive HEAD Documentation/ | tar tf -
> 
> would be expecting (at least) two different things, depending on the
> situation they are in.
> 
> So at least you'd need an "--include-untracked" option, I guess.

Right, this breaks down with directories -- most build artifacts (e.g.
.o files) are probably not meant to end up in archives.  We could still
do it for regular files and symlinks.  Perhaps that's too confusing,
though, and an --add-untracked-file parameter (or whatever we want to
call it) is the way to go.

René
