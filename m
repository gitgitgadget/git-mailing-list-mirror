Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B131FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 17:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbdBJR73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 12:59:29 -0500
Received: from mout.web.de ([212.227.17.11]:55653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753379AbdBJR71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 12:59:27 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3k4b-1cK9us2sjJ-00rGIz; Fri, 10
 Feb 2017 18:24:27 +0100
Subject: Re: Trying to use xfuncname without success.
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de>
 <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
 <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
 <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
 <CAJZjrdWouNaNKU2sX89Xh=QqSbdB7srwgufuquYL_1B7H324Yw@mail.gmail.com>
 <CAKepmai3fBZMS2dXaJyvnP36LooLh8yjn1T6vGG=Pi1B1LMaCQ@mail.gmail.com>
 <CAJZjrdUcxe_K91CQXz_TgGHgXMsKaddwG5+JEWJ53pv5_GO1zw@mail.gmail.com>
 <CAKepmahcaV1Ro_wObkFxezrZntL6JQ_ft+06_3ZSrxEz-yNjzA@mail.gmail.com>
 <CAKepmaidYd4tMRwSNoTTga8s6ji-pc87fZqtxdeDcDVpFhcPWA@mail.gmail.com>
 <CAKepmagSysE_31Y3JJwhOKvD_kGfiyEXikep62g=cn9+=v_fZA@mail.gmail.com>
 <CAKepmai0NbQmZ-8KCm71qh4cBd9HOzVD1M87TAMhGPYaH1HsHA@mail.gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4ff5b2ac-d752-b7e4-8b32-8a5dd6c5b3bb@web.de>
Date:   Fri, 10 Feb 2017 18:24:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAKepmai0NbQmZ-8KCm71qh4cBd9HOzVD1M87TAMhGPYaH1HsHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Q+4p8YBT22XkZTSQhuUsnut/AcQd4lWLVhYEP9y3GAMnGgXmw/M
 LmHWUb8l9VmIocIWSE5zr35rxaaqT93Ed76jmtNm4cguREske2rnePOPH+1sNaZnyqRC9jV
 4Pzf5JhNS1iE7YXTUscplCWzYgX2HOB9vWaXe022eLq5rRngt8stEQ5mY/QlgdOjh6M4Qau
 AFUFFXhGPc/Q3s4PD+4kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7plhHpOGTVo=:VU4gePyCHCVm5C3SK2xlWX
 pqiEn2wI0iWo3yO+PHNywhbaS2Ruo0Q759q68lLTvHgC8J58X+4wyQVHf0kRO4TTYI81IMhbo
 tLGLRzm+QVmsWXRiwmq3oXyAaZGVGa+ROGkNH3p2AXtygbYMrf6vmS8y5C/fv1IYvT57/tQbb
 5iLFyaWCx+P56Pin202jl4R+4g3o5swDbDT93dPwMkA1B7LgBoqiwr+rt8HpyH01uB1NUv5Mg
 LZAde+w6xvXxuRr3KJ9QwDXcwKhRnMc93TKEqyEO6MN4QmqwXLWlfKNQueeVokUDAUJ/4uFIW
 aHh0D9cK2vO7KQsNtdgr/ClQ/161YFhrNxfvhvdILhskVro+b2jIL1iFsIpB7oKiHR//NUS5R
 7m1TIQKJghH8PsbxcKeZl3aqwiBHwFzr1uiCsHGLZQ4JmJUzlGJZOAT3/q+oJS29hZ+rQOYx9
 obJOgo1tFKt4cCMHXiUE1LIZF23kkNIxpmkdr140Tf5f0j2Cw0uY/tnZUQQoAzaLVbQXsKCcR
 jXFPV5VRjUK/uFiWaVbkQVoHbSZyB16h4bBdl/qDMV5vQXXOF993MEf54VKQEmbN+63G0tSQZ
 02FwzI0TuXNASJd3dEKS7PSmASKwKQE+J7xWauNpfebdNAW4mPFE8DQoUU6cpmBHjQohReaw4
 9avA4quSCwdhFQvDdNEmF3ubBqB+rB8Tp+yU+kECUDBO1IGsudDIS9Mp5bwcn21RJTSIT3nca
 EkjY8e5cU77w/PJcCMDbqdCba5hNLNstAtbSJP+7pg6/skMpRqQLwwJiAsKDUBlUyVfq9iYqW
 SnoQaxM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.2017 um 01:10 schrieb Jack Adrian Zappa:
>>  where it has grabbed a line at 126 and is using that for the hunk header.
>
> When I say that, I mean that it is using that line for *every* hunk
> header, for every change, regardless if it has passed a hunk head that
> it should have matched.

Strange.  That should only happen if no other function lines are 
recognized before the changes.  You can check if that's the case using 
git grep and your xfuncline regex, e.g. like this:


   $ git grep -En "^[\t ]*<Type[\t ]+Name=\"([^\"]+)\".*$" *.natvis

And you can check *that* result with regular grep -E or egrep if it 
looks funny.

René
