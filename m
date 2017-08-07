Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46A520899
	for <e@80x24.org>; Mon,  7 Aug 2017 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbdHGKSS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 06:18:18 -0400
Received: from mout.web.de ([212.227.17.12]:51304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752766AbdHGKSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 06:18:17 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Martm-1dufWG3B0s-00KOLZ; Mon, 07
 Aug 2017 12:17:50 +0200
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use
 -gt
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>
References: <20170806233850.14711-1-avarab@gmail.com>
 <20170807011832.oy6lxf2ewkmzg65s@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <56fd58d6-acc7-042a-1b68-9854ed54361b@web.de>
Date:   Mon, 7 Aug 2017 12:17:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170807011832.oy6lxf2ewkmzg65s@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:i8ci5WdCPFPYy6pm/lg2yx25CeTwJDVW/XzY+5LF5F9FNd2BudF
 A9iwNwBDK17dOKm6XxCmV5Lvog2wwmgv/rJsnnVrev9gK1J5EZFmJ8VaPBJICZQjkP/mdcN
 Lya2a7x0QNKYxSeSu1fNUK/lyDgXMsQqr8Q7mWalgiz+nxb3lW6j6LHeUYiSQ88bYx9IbYj
 5i84cws6BxnVAcbvQasRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nX9t8+IPAG4=:aqqvPwZXSKWtnsRANN7WXt
 KInLukxMPJMrKsSsBE6zb/Y5v6hTZu+sdPnWJzmXy8SRhA4GW4vq/yqiwuJAfoDocZVj+lURc
 VLyFN99eThZnHFaSdpJGwJu7nmu5iBnMdymodQnPNNsbFfhMroQcBM88Znywdykvi7pQ36lPy
 F8N6RrFiOZsXkojqPdPkChmXVKxjivESb4aB7xOBdSdOsy/sGvaZI3uzGpajp7xQdW93xkfQE
 MgFmMh8shH5FHxkcIaK4xaQlEzZEietvMKgyfhG+WkenH/87YUkDBRLIeWrN7GAHIJ0K22EBk
 jxLNv2DDjFhs+IOIAu3RbYvGVFBAfKjUk1AFGVm2XEOoP+Tio0PizcrVezZtQEDCVCEcgVd0e
 1LeUyQkOnBzLGe9GDghwU1ylstp5tCUlt+7Cu9yk/CMr61EyxsINjDxtT3X3dIbkXkWtYMTvS
 9Yf/IgVNCJ6TNwLxZkiBONLYsC6riAZ7uTQFrgg7xBfILJ3ku0Vxs1SZ0R4m5hed0ReFyymMi
 b1u/CPKkG+cwKH5aRFe9jcMyiNR59GlTfp4Oa907QjkxRXuqancijC8E0Rg4Dy/5qkB+HeT02
 zJMH0W7fvxhHZnFuifNXkOAPsb3A+zbB+4oScv4FQiEy7tsw1gVhvBDsykJsf4U6q7v6rmT+X
 2REqpharePG6DkNCDwBH+inx8q5Ae/TkuNxYn/y+rbqysu5fpN3S+IrmRyIRNVxNIME3Q+LTK
 YosWaCcdgRRdts9fi1Teo2UKkcvqyY21g1Xr2l6BWQGuEtte2HWReCnGkoxDR+8KmXVIN0EkS
 i3lGuO/1HffzSGCUqpyptQ3ZRr8rjLGXeRTvGqPzN+VOK21Bmc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.2017 um 03:18 schrieb brian m. carlson:
> On Sun, Aug 06, 2017 at 11:38:50PM +0000, Ævar Arnfjörð Bjarmason wrote:
>> Change an argument to test_line_count (which'll ultimately be turned
>> into a "test" expression) to use "-gt" instead of ">" for an
>> arithmetic test.
>>
>> This broken on e.g. OpenBSD as of v2.13.0 with my commit
>> ac3f5a3468 ("ref-filter: add --no-contains option to
>> tag/branch/for-each-ref", 2017-03-24).
>>
>> Upstream just worked around it by patching git and didn't tell us
>> about it, I discovered this when reading various Git packaging
>> implementations: https://github.com/openbsd/ports/commit/7e48bf88a20
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> David, it would be great to get a quick bug report to
>> git@vger.kernel.org if you end up having to monkeypatch something
>> we've done. We won't bite, promise :)
>>
>> As shown in that linked Github commit OpenBSD has another recent
>> workaround in turning on DIR_HAS_BSD_GROUP_SEMANTICS and skipping a
>> related test, maybe René can make more sense of that?
> 
> I've confirmed using the NetBSD 7.1 man pages that NetBSD will also want
> DIR_HAS_BSD_GROUP_SEMANTICS.  MirBSD will also, according to its man
> pages.
> 
> As I understand it, the only consequence of not setting this flag on BSD
> systems is that some directories will be setgid, which, while ugly and
> useless, should have no negative effect.

Right; specifically it's for newly created subdirectories of shared
directories, which we want to be owned by the same group as their
parent. That's the default on BSDs, and we have to set the setgid bit to
turn on that semantic only on other systems, e.g. on Linux.

81a24b52c1 (Do not use GUID on dir in git init --shared=all on FreeBSD)
introduced DIR_HAS_BSD_GROUP_SEMANTICS with the rationale that setting
setgid on directories may not even be allowed for normal users.  I can't
reproduce this (t1301 succeeds for me on FreeBSD 10.3 even without that
build flag), but apparently at least in some configurations it's not just
a cosmetic issue.

The skipped test 'init in long base path' in t0001 is a different kettle
of fish.  getcwd(3) on OpenBSD respects permissions on the parent
directories up to root.  E.g. after "chmod 711 /home" normal users would
get EACCES when they'd call getcwd(3) in their homes there, while e.g.
on Linux and FreeBSD they'd successfully get their current working dir.

René
