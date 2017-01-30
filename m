Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CD61FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbdA3R0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:26:49 -0500
Received: from mout.web.de ([217.72.192.78]:52003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbdA3R0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:26:47 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lz376-1cTs2G2w0O-0148Pv; Mon, 30
 Jan 2017 18:26:36 +0100
Subject: Re: [PATCH 4/5] diff: use SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de>
 <alpine.DEB.2.20.1701301704110.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3058e7e1-c779-0183-9394-e9cd5e05cc3c@web.de>
Date:   Mon, 30 Jan 2017 18:26:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301704110.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:R0DSALe1BKnmMuaPIutch2a+ou2bsGxl1QXDeLvhTNTCw3s1WMg
 JAlRpMiK1/pJsFBz67hWc2XWH/o4+bfAQ3fdch4qaMJXR0QZI3EQxs4UaHCSd6eqZesjIAZ
 auKsr8Zwg9D+5OuaSbbVWvc5m6PN0T/+HILG/JEnXkYOM1ItYRca9PmTHEx/4QGcrKDQg4m
 Vnd1G4dt4GpcbPPbqnHnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r+AKdQfgOrk=:EglRztCQhaAdxTFVxAY/FS
 LnwzSjutVHwDz0IPJ1WCa35IQCw8sB8Nh9cfbdGQsJ1bMK0tjYsNLwrzXCwJByGRomGUEZfVR
 36PMSWAYDsO6tl3WJcAhFhg7iGDt3TvRZtHisrdQAEYFEycf5d1oWo+u5Z2BHCxV4fu+wkmK4
 BjT4QNx+uesRLSX4JQzpOvaRs7ct4p3eg/KoaxWrRfA2nw27mI8TgD0X8GelocpQRZrDUdPaq
 +jfs4Vysdkz9VDVO69vlpJIoOGHpHBSjhgWT6+JU60CwwPBqzK/Ui/G3wZcaycO4BJ4CeCrHD
 6CCcjaxH6gzUCi61BYrTpmsnVgDZejCvJ85winpHJlFUl4tyJEWu5t7xPrNOTj/g8Ng4KA3Ny
 j+CPWQgCDmlcB5PBUsrWwuUduplSdEGSM9yN6EVb9W04f5LFAmLCeQjE/+f+YDeJog4FnU+K8
 cyPXUQX+Djaodne2xH76LLDWAXeCOm8BLBksmJ1aN0a/pvvH/T37Gr8KffvBpOtVIVTLpLOfj
 js48z14w5UKLrNLXnVomNxcWEwLHbYiVaxG+U0DPM1mxJ+Rr6LK2Daock5PpttHrh2DQV/gjO
 NUg06Lsul2RB8o3TKHz5OnohjOPkpbhtgQqbsRqzLA2z/zC3kFqQSQct/6gCaVptJnlvLoVAg
 UdH4NXJnyeokU1JL+CCfatTmH/3pPbfzZZtIN1CKMMzH+VY508xD/RpfCZHu1+Jezpc2ddejw
 gYSg+hYRIA+T9DSXQBaFx45l4YyH6PTWofA9xwfvZqx2JG1ZBfdFwfbNEMFEEYPlt5JPr0p2Z
 w+Qgs9q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 17:04 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 28 Jan 2017, René Scharfe wrote:
>
>> Use the macro SWAP to exchange the value of pairs of variables instead
>> of swapping them manually with the help of a temporary variable.  The
>> resulting code is shorter and easier to read.
>>
>> The two cases were not transformed by the semantic patch swap.cocci
>> because it's extra careful and handles only cases where the types of all
>> variables are the same -- and here we swap two ints and use an unsigned
>> temporary variable for that.  Nevertheless the conversion is safe, as
>> the value range is preserved with and without the patch.
>
> One way to make this more obvious would be to change the type to signed
> first, and then transform (which then would catch these cases too,
> right?).

I'm not sure it would be more obvious, but it would certainly make the 
type change more explicit.  In diff-index.c we might even want to change 
the type of the swapped values from int to unsigned, which is more 
fitting for file modes.  In diff.c we'd need to add a separate variable, 
as tmp is shared with other (unsigned) swaps.

René

