Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240DFC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353857AbiCXUtx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Mar 2022 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354581AbiCXUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:48:24 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217CB0A77
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:46:52 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22OKkpwQ012973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Mar 2022 16:46:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Tao Klerks'" <tao@klerks.biz>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com> <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com> <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com> <xmqqils3gort.fsf@gitster.g> <075d01d83fb2$1506ded0$3f149c70$@nexbridge.com> <0deea44e-b919-81cb-d8bf-ebea4c9ba426@jeffhostetler.com> <076101d83fbe$e6ce5e50$b46b1af0$@nexbridge.com> <cd5dd46d-fc47-1af8-6ba7-ddf1617a7b2b@jeffhostetler.com>
In-Reply-To: <cd5dd46d-fc47-1af8-6ba7-ddf1617a7b2b@jeffhostetler.com>
Subject: RE: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
Date:   Thu, 24 Mar 2022 16:46:45 -0400
Organization: Nexbridge Inc.
Message-ID: <076201d83fc0$4a202140$de6063c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGzDsbg2lz67pgmA1z2cDpXTOUgQHHL5OMAJXlRvoBuEN8YgEapCjIAipY7sICDXG8EwF70lNnqxrK/0A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On: March 24, 2022 4:43 PM, Jeff Hostetler wrote:
>On 3/24/22 4:36 PM, rsbecker@nexbridge.com wrote:
>> On March 24, 2022 4:28 PM, Jeff Hostetler wrote:
>>> On 3/24/22 3:05 PM, rsbecker@nexbridge.com wrote:
>>>> On March 24, 2022 3:00 PM, Junio C Hamano wrote:
>>>>> Subject: Re: [PATCH v8 21/30] t7527: create test for
>>>>> fsmonitor--daemon
>>>>>
>>>>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>>
>>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>> [...]
>>>>
>>>> May I request a bit of extra time on the -rc0 to -rc1 cycle for
>>>> this? I have a feeling
>>> that while testing this is probably going to go well, I would like to
>>> have a bit of extra time for anything that might come up. There are a
>>> lot of moving parts to this series. Not being critical, but debugging
>>> scripts on my platforms can be a bit rough at times.
>>>>
>>>> Thanks,
>>>> Randall
>>>>
>>>
>>> I'll simplify the `start_daemon()` function as Junio suggests, so
>>> hopefully that'll reduce the amount of debugging that you need.
>> Thanks.
>>
>>> BTW, which platforms are you worried about?
>> I'm worried about NonStop ia64 and x86. It's not just this series but also the
>fsync series. I think it's going to be a bit of a rid this time, but hoping not.
>> --Randall
>>
>
>I currently only have drivers/backends for Windows and MacOS for the builtin
>FSMonitor daemon feature.  Since it relies on platform-specific code to read
>whatever filesystem journal or event stream that the the platform provides.
>
>So t7527 should do a skip_all on NonStop IIUC.

I would have thought this was applicable to Linux also. So use, it should skip. Be in touch when if you do down that path.
--Randall

