Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB0B215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeD3QMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:12:38 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:45858 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbeD3QMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:12:37 -0400
Received: by mail-ua0-f178.google.com with SMTP id j5so5729092uak.12
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G6LkdZJ8opuTjIG8duKa/vNYZCBHPKqRDA1TybixknY=;
        b=bUspJBHnQsfGvfUHLUirFGH7utc+BFsfOQ8fwa3npD4UYdgHrpdTrAHsLdcGKXw7Vt
         UVF2AJ2h2jYU+TpOxmvFFi0OOrBfgkqNJtKldqtdf6lU3uo0bsohMGGpaHf88Il+3fy9
         mXsf83cloCKUNi+TMcVvfCPNH+MAMXUptmi8m6ftX7eqA5QJLHZJlUK1x6kF9AyJ62RD
         ccyrnygqok82WqrSfWAnLE6ipsrwEJUAt+6Bi9HKthmHZcp9VQFRjRQd6oPj/WaKgjzv
         ff9XSfDC0QXLySwigobcE0bTNzQzD7kz+63ONuRK7hxrRpTowJAV4lMtpyBhwT8ZA3dA
         nCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G6LkdZJ8opuTjIG8duKa/vNYZCBHPKqRDA1TybixknY=;
        b=HJoC6b3guNrDPQj/5CJrTFCREvQdV7hltIPXR7Rytqx2/Rkmo7SaXHK0Heo7ep2jCV
         7mfZ0sk1nGRV2Q8a2v614gE3oU8s95k8hAauOHG0ijg/qNEhgBHyN3/XOzE7EDntSzXc
         I8GIM8w0vSq3a9holwuL6ULcbF48LWaf1GnTJy5ISd8mwif0mwVhLWON8qammc9K6/6e
         Gq6nVXHOJlmLFKOEyA1Jns992hCxAIAlB8MCg2m8XXYuStLquLxXxY/SFIZC2HM/7X2S
         XfBW/NTnXNvVVZ3BoEM31YWuuQnDL+erSS5GxM5Da3biV60Rkr72nLucFclwFm8dKjuX
         lqkg==
X-Gm-Message-State: ALQs6tA3rT+SswdX6Ir/bAnIqZkzwV0tWZBM0NdSGdax89s8L+mKYvla
        7SmkVEy0xK8HbwvSvJp5oEzaXUMuv6L+I1CTYuY=
X-Google-Smtp-Source: AB8JxZqR890N24Sd8q2SbzZJBgY8vf4/NhGoR7K48URNNjERtWX6DcKb1JqxxfZx89p8kDqvbDCmV+/HpqpZxs18XsI=
X-Received: by 10.176.21.232 with SMTP id j37mr9559666uae.199.1525104756172;
 Mon, 30 Apr 2018 09:12:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 09:12:35 -0700 (PDT)
In-Reply-To: <e753d8fd-5329-b819-0076-0ff4659dabf1@gmail.com>
References: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <20180427181937.7607-1-newren@palantir.com> <e753d8fd-5329-b819-0076-0ff4659dabf1@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 09:12:35 -0700
Message-ID: <CABPp-BEC2cnpdvDsMPFodvNR06G5E434Hpdmaex+6+zHpYm_QQ@mail.gmail.com>
Subject: Re:
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@palantir.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Miklos Vajna <vmiklos@frugalware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 6:11 AM, Ben Peart <peartben@gmail.com> wrote:
> On 4/27/2018 2:19 PM, Elijah Newren wrote:
>>
>> From: Elijah Newren <newren@gmail.com>
>>
>> On Thu, Apr 26, 2018 at 5:54 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>>> Can you write the documentation that clearly explains the exact behavior
>>> you
>>> want?  That would kill two birds with one stone... :)
>>
>>
>> Sure, something like the following is what I envision, and I've tried to
>> include the suggestion from Junio to document the copy behavior in the
>> merge-recursive documentation.
>>
<snip>
>
> Thanks Elijah. I've applied this patch and reviewed and tested it.  It works
> and addresses the concerns around the settings inheritance from
> diff.renames.  I still _prefer_ the simpler model that doesn't do the
> partial inheritance but I can use this model as well.
>
> I'm unsure on the protocol here.  Should I incorporate this patch and submit
> a reroll or can it just be applied as is?

I suspect you'll want to re-roll anyway, to base your series on
en/rename-directory-detection-reboot instead of on master.  (Junio
plans to merge it down to next, and your series has four different
merge conflicts with it.)

There are two other loose ends with this series that Junio will need
to weigh in on:

- I'm obviously a strong proponent of the inherited setting, but Junio
may change his mind after reading Dscho's arguments against it (or
after reading my arguments for it).

- I like the setting as-is, and think we could allow a "copy" setting
for merge.renames to specify that the post-merge diffstat should
detect copies (not part of your series, but a useful addition I'd like
to tackle afterwards).  However, Junio had comments in
xmqqwox19ohw.fsf@gitster-ct.c.googlers.com about merge.renames
handling the scoring as well, like -Xfind-renames.  Those sound
incompatible to me for a single setting, and I'm unsure if Junio would
resolve them the way I do or still feels strongly about the scoring.
