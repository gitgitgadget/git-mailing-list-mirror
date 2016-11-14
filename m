Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6F11F858
	for <e@80x24.org>; Mon, 14 Nov 2016 16:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbcKNQgS (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 11:36:18 -0500
Received: from mout.web.de ([212.227.15.4]:57267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932297AbcKNQgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 11:36:14 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MORtt-1cBYta1H7d-005s07; Mon, 14
 Nov 2016 17:36:03 +0100
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
 <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
 <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611121237230.3746@virtualbox>
 <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
 <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <35d3a07d-5d2f-aedd-94bc-4d92e5aa4661@web.de>
Date:   Mon, 14 Nov 2016 17:35:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qXdm2g8lVcwrr+UMxpJExvk5m5BA4jZQGMNacHzB+Xl10YMx87L
 HwzUvio1fakrmis4dBiMQchwSaPTx5hyVyHy+MgqRbbzPPcLSzpg6k7dxDxRBTBOosoQsPj
 JQ7R0MOR/cTOHCnsX414D3HK8cYV0jcIXUiZi2sa0Dyp85TGgT10Gyi8CzbSz+ra6BWTLPF
 27nMkYVArTr9jUDQSAOWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AY5n/CFIHpU=:z0PVmaV/rDOjGvW2M8ouVE
 7oWJsv1ZwhSxr6y/zFkiIEfqeC0lG8hHwTML+k90aZtgyBdFzcC/5fBbsRvNSzo7EPLun4Tmh
 1ieHkf+6uvITQm3IT7v6UYa6oeWE50PEHpXLLkx+rk4MW7MwhgnnirjIeu1IFQx81UvdZqDKi
 T31QDqGCKzm+XdMzoxMXsAoLbEUFx7u1Vq2JERoJO64EY1Qh5BxJvee3Y+2VSOxRCxFm4vm/M
 WAFU3wpDe6i0ZGLkNoZrPQXXcWJMi9jhbnIJ2NvdgYvilbu7C5NQe3ogfZDSS4Sk4R3/7dfQ+
 vzlrIomH2irkehfZUDbhbEusgSiyHfUd/M+wTvtaFHje+vXXQwnHwdrwCE5ga5Cn/xQIwO6Iq
 ntyGfZB8xb+okl1b6qrUzwoRKfoui0F4TnyWoeVIJzaCtHyQMbhiBm4vu+XkF1xmCoz7Mc8iP
 O5tgoH31Vog72K6BZHDycMrJPlxWiyBlNc8sFjuTPAEhB1RBVSjr8RqMHdzp+tKLAUyxuD9Nz
 7Kq7W06RXwWtaT6hcdhCBlsjftKqJQGkyA6qoQ7ESq4PPGrX1IxEoZz2+xGB9Lkn4A1Qit7wr
 XeXtMIp7cCfJaeD/Pm1NTtv3TuxWpToRaJQA5oKdM3LWTrWxh+SmZ1eH4vh2BjmfEnlmBpxm+
 Lkkb41n0JeH5d4AbjTC0q1CzXCeniQEXyFhw8efaggIGu85dq0MZibh2lGrzNoRXy46fomvB+
 N7GJF2d2Yi4NLn2i9HZiGitE9M57OKj5jXXeLIwOc8orQX7HCf9z8pqi9b1GK9HFXXEHb0Ej9
 f8Nv0M+Rw2B+VRrUd7R7HIEvJb2du5ZmLN0mBDvLd+1OMlJgIc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.11.16 10:11, Lars Schneider wrote:
> 
>> On 13 Nov 2016, at 02:13, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> Thanks.  Dscho, does this fix both of these issues to you?
>>>
>>> Apparently it does because the CI jobs for `master` and for `next` pass.
>>
>> OK, thanks for a quick confirmation.
>>
>>> The one for `pu` still times out, of course.
>>
>> Earlier you said 'pu' did even not build, but do we know where this
>> "still times out" comes from?  As long as I don't merge anything
>> prematurely, which I need to be careful about, it shouldn't impact
>> the upcoming release, but we'd need to figure it out before moving
>> things forward post release.
> 
> What is the goal for 'pu'?
> 

> (1) Builds clean on all platforms + passes all tests
Yes
> (2) Builds clean on all platforms
Yes
> (3) Builds clean on Linux
Yes
> (4) Just makes new topics easily available to a broader audience
Yes

> 
> My understanding was always (4) but the discussion above sounds 
> more like (1) or (2)?
All commits should work on all platforms - in the ideal world there is no problem.

From time to time things sneak in, which are not portable.
(in the sense that not all "supported" compile/run tests without breakages)

And if everybody reports breakages and problems found on the pu
branch, there is a good chance that they don't reach next or master.

Does this make sense ?

> 
> --
> 
> Git 'pu' does not compile on macOS right now:
> builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used uninitialized 
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> ...
> 
> More info here:
> https://api.travis-ci.org/jobs/175417712/log.txt?deansi=true
> 
> --
> 
> Cheers,
> Lars
> 

