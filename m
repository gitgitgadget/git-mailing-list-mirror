Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E010C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 05:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B3C20734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 05:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KnTMK+MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgHJF42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:56:28 -0400
Received: from mout.web.de ([212.227.15.3]:48469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgHJF41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 01:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597038974;
        bh=KNWAqbOzR9dDb988O4lAVel0XA52fqRamKO1xKgdHZ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KnTMK+MSUZ4iLCaS1wR9Cracdpyv6zI8/NtIWkzDaIh5rXhidyi8tQcppN9T3dCpl
         39ULAfH1gxa4Kua8LwIO7mFlvaq6tt8wFk25wBsLfcDwHteExWPrHNhMPTbQfW0wPs
         cAfncJOXS+dqAOrYZJACPMUTs3ZHkSosCA2UH0xw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtqS-1kBX8f3dGK-00X0TT; Mon, 10
 Aug 2020 07:56:13 +0200
Subject: Re: git bug
To:     Jeff King <peff@peff.net>, PANEL Christian <ch.panel@free.fr>
Cc:     git@vger.kernel.org
References: <1596725319.6764.7.camel@free.fr>
 <5387a5b7-4551-53a0-abdb-e26cc2702536@web.de>
 <20200807000226.GA12088@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c223cb39-501f-8ed1-9b82-2f7c2cb22886@web.de>
Date:   Mon, 10 Aug 2020 07:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807000226.GA12088@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hSuOcooq/ONGtevzyuzKnEEPHLVU1qxVHWQBSumrXLLJtAAn+N9
 pUCfgbV/qR+5jMdZ22uVW6WrS0D7zI3xwDsdxef2bz+2M+Og1V4DGG3kTpoVoSd6u8jksXe
 MG0ZbAIuym1f0o9weSRdGWPrSw2fZnY/09MwR41nwMEylhQ1he8rmb5msk/b5LYFBZ5SLCZ
 pJXYtFWRMwZbeSKjBNprQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a1dudrGLjbA=:W6Bn+1lHee6DIPKx9UaySd
 GvjHQdCuJ31QzGD903qYbSrfrP2ohD4F2tn+A43spBmYrn5wWJUG/+9EWpk9wxMY40QMwSS53
 w1kxSIYiAtk5uddnLJQ4BpFxuVbYeSyGFUM4nh0TnY6J/6GpoOTwgns0mzXdm8vgXf/MBwCLE
 gOZklLqTcIOlXirLTQAuapUO1j8Y7e9x4bzIcF4cUmNRAfJ/Kp1mg1OHiD17tmVvkmvl8+5mj
 7vMd9okHat+LTX8pL6D1UQwK+r/ErUMYZ3ciuVq+u5hgA5Psg6r0uBmGGjgScvuqWnhBPjSKu
 yJOU1h2GjhDTcDk59PImJwelkjH4XF0qkTwBdrAUIfUOdhdaEKn2qAzXd1daHryfUTYSPaA/M
 qr9fDKsCLb5pvF4VmR+WcvNnVXgl2KoXfTQHFUIYnWriFaX7zBYyQHt8ojEtsZ5PVWxXbMsU5
 bFRLCtYYXXk4DwlZ4ovZep0oHiilrsZrIs2uLovRDQNBYv/6O94FlhQ0f9u3+sWvR0z2u0fBi
 wYBAvOJl18sIQD9ZL8tVoRxF9qrpNI1fjs5A5oiHhE3NGvf6IRIbQf38pRnNwUQMap3Dq2Kxb
 dEY2K/BtY//p5nyHxDu99YmOs0K0y3FvUFP0927WYvAUQZYZUdIe7vOe8lGnE1o/cKrITo7MT
 kwEeh++uajO1hIYfkyN1MqBayz4bUAAn7BVeNvgnxG6w786X9wMTbKWMCxWfA7YY2J1cK2Vy6
 pJUwiW4pecmmJo9qfiLj96mMDN14x6Q9bXUMLOk7bAyYm2yxyJ3o71I/L314lJI46og5CwMDv
 cC0r1MGu094aOO1GkzJiFPkJpLrVKyopumiCtb+AyP4l3uExKec4qZn3WbbnYSmhRzTPBN1f1
 kOiNP08fcKDxiAxQZ5x0wzQ+2gJmJm5jD63gLNefhYeybk/IbKa86zQajXVhZO/zHwhnuhzjF
 pbIPTYXqlPm5WgOmfkLKOHEf5+090V6IMdhVrXm4EPjknsgiyUKg/06VsM1CGK0XL1DjSCuhh
 +WDouYURm31lLLxKCjXreNmZL2xIOtIMeyAMQwmJ0ruLapNMo6lXQyOcpG6XV9C01vYVQSv7b
 oo297Plb7unqMr+QoYMCkkVLUcjp9dOaeuDpDC8n63ePH6wFxmy6W7SAYyJEtegh9TZCVV9wi
 3QPRMlmKt81aS1PE8+4iKtuMXZJvxmEHqm0dTI/NjiKdkzXcOEEWIctQB1vS68acRTiB/Y17s
 eaBCojc1jDKoS2yKZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.20 um 02:02 schrieb Jeff King:
> On Thu, Aug 06, 2020 at 10:23:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> So "file" is no longer ignored.  Committing the .gitignore change
>> doesn't change that:
>>
>>   $ git add .gitignore
>>   $ git commit -m 2nd
>>   [master d4c95a1] 2nd
>>    1 file changed, 1 deletion(-)
>>   $ git status
>>   On branch master
>>   Untracked files:
>>     (use "git add <file>..." to include in what will be committed)
>>   	file
>>
>>   nothing added to commit but untracked files present (use "git add" to=
 track)
>>
>> Which steps did you take to arrive at a different result?
>
> Perhaps also:
>
>   git check-ignore -v file
>
> would be helpful for seeing why Git thinks it might be ignored (e.g.,
> another wildcard rule that happens to match it).

Right.  And there is more than one possible place to specify files to be
ignored.  E.g. you can use info/exclude in your Git directory (i.e.
.git/info/exclude by default) for repository-specific patterns don't
want to share.  See https://git-scm.com/docs/gitignore or the manpage
of gitignore(5) for more details.

Ren=C3=A9
