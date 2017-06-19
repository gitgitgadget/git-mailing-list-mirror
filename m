Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE5A20282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdFSJwg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:52:36 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:54563 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbdFSJwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:52:34 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id MtMGdJY62HGLwMtMGdUxAG; Mon, 19 Jun 2017 10:52:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497865953; bh=GQI40VuGVR+6U2oNe7OL10dbzEIpbLTfOkE6AMLxncQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BOB9KO1pN4kB57rpFISF6Uo8Jmr4C1kBtEMoa8rPul8rfY8a6fUq8FzstQzhPBfMv
         W6KJr6xiUB0fVR1BTmbAR2ebMKvYcc7fXzZPpE+Yhdc5K0c9xxWkLqspfL0EzjcUHk
         s2gr/vu90VKg4GGw/YtxPw09K523LTjeAkFh5ZKs=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8 a=HynW4SlSJommDz6qhnMA:9 a=QEXdDO2ut3YA:10
 a=ezPG0ZpnnpEA:10 a=UF-tvkePCJwA:10 a=SHUmGpGg8TAA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170614102427.5220-1-phillip.wood@talktalk.net>
 <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
 <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
 <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0013aa76-d743-e002-72b6-68e1a567fdbc@talktalk.net>
Date:   Mon, 19 Jun 2017 10:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAK4HZXKmnLNlq4bsuZiqEUg5t0tlClMbB5TWqAEPlouYeVyisvFiUHrkpqhxQddFP0yfEycnP/OK6pRzCM6Q/nuWJZlGuOVn4eF6PnRv7pU9Dp2Qgiq
 /zswTvpUuV32M7Zytz/IXgrRkvFxu/lgg/GNQPZ/zfyPshhjI5Yz09UU/7qBlGNGz88SRESCG+vUIshq4/SUUUBuotGnAaGJjXGD5LE6ltzXHLqHW7gJzsCA
 S5wZXTt8UICXqal4ZlRRo5cj2N/xshG3Gz3FRYL3fKNiyZyA9XQmBXs4+ObzUWDqpghsxaRsIzqhU+oyyy6oKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/17 00:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> I've revised the second two tests as Johannes suggested to drop the
>>>> sed script. The first one is unchanged.
>>>>
>>>> Phillip Wood (3):
>>>>   rebase -i: Add test for reflog message
>>>>   rebase: Add regression tests for console output
>>>>   rebase: Add more regression tests for console output
>>>>
>>>>  t/t3404-rebase-interactive.sh |   7 +++
>>>>  t/t3420-rebase-autostash.sh   | 138 ++++++++++++++++++++++++++++++++++++++++--
>>>>  2 files changed, 141 insertions(+), 4 deletions(-)
>>>
>>> Thanks (and thanks for Dscho for reading it over).
>>>
>>> Unfortunately this breaks unless your shell is bash (I didn't have
>>> time to look further into it), i.e. "make SHELL_PATH=/bin/dash test"
>>
>> This is the bash-ism that broke it, I think.
>>
>>     create_expected_success_interactive() {
>>             cr=$'\r' &&
>>             cat >expected <<-EOF

Sorry about that, for some reason I thought $' was in the posix shell
standard but it's not. I'll redo the patches with the changes Johannes
suggested.
