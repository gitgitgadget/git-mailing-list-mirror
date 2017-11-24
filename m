Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3AB20954
	for <e@80x24.org>; Fri, 24 Nov 2017 10:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbdKXKYa (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 05:24:30 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38787 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbdKXKY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 05:24:29 -0500
Received: by mail-it0-f46.google.com with SMTP id n134so13136764itg.3
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tl9+R2hO7dFpyEAIlou5bKgciQ0itDXZpgPRCFbHaZE=;
        b=mufgRuzMXmq8o3FP63B9KZhhdZI5ysdFQHyD5ErZVuSIFyNG0iYY51L6KfeM828xyd
         qkGYr+NdHjbOt/ei08f/VQesEYGQUbks5tikMvvN0DEirf74BDUG3WEvfnBouvFPkhgZ
         U3VrEvxQ9kW1MEEWcJ/hm67RDmUie5k1CBfoByA/+8zeqVb+jHcDL5nXBbGNqvqx+kLc
         BocPebNnn65AZdT52bdNzSSlURAekpmitfv0xu86cN+f7ECCJmD+MAME5up7/mjqAsHI
         wWEJxISW7OxKZ2aICw9pOmJtLGp0MvLvA5MuQmX7sgyKHGlLjnArds4KKYVt3C9WFxHD
         hhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tl9+R2hO7dFpyEAIlou5bKgciQ0itDXZpgPRCFbHaZE=;
        b=pvXy2HzsI7B20/7d6sO+QMDwhSNiXZDKI7hpvNP7aXPWkbOEhNyneVPIbEmmJcy3N7
         heIR9yjsgY961X4Gr9sjWIx5pVToaSc9KtBMcC3JbSEd0BnnxpNOGxpeTMCWBGkvCwj1
         IFfBByNy+MLAQScKNol9LaohfJxCBOSrrCgx7BIAFPIXem33vqwNqUKeTrpnaA0eNfZa
         U8KFr4yR5xC+r+TqOlOJlR989cmNI7mON2ppqOiiy2WjT6yBTL1bItt9ndJ3Ynd3bgSu
         xH3/kzNxc6qZvD6LBIR+JXbmO0gjL/uSOuAu9CuoYDFsz6uXH9klGRVqmFzlr/iKtL8r
         1+Nw==
X-Gm-Message-State: AJaThX4s/MurMMmeOhWVZB4S024BpKuIZSO7RI0a5IFXLqVZcCjbh9NM
        XYLxAbGKpG8nNFaqayTjOJA2ni8CMgi8h1JhMeo=
X-Google-Smtp-Source: AGs4zMZGUvrlJWXIJxhnKv3xycJrtvQRkF8UJEqZPUEN3whBQffzfEbEIPUNggQAlnIYw7NXGz2XuOvTZWzQecYdGA4=
X-Received: by 10.36.145.203 with SMTP id i194mr15593949ite.73.1511519068775;
 Fri, 24 Nov 2017 02:24:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.200.11 with HTTP; Fri, 24 Nov 2017 02:24:08 -0800 (PST)
In-Reply-To: <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
 <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com> <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 24 Nov 2017 11:24:08 +0100
Message-ID: <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 10:52 AM, anatoly techtonik <techtonik@gmail.com> w=
rote:
> On Thu, Nov 23, 2017 at 6:08 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
>> On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>>>Subject: Re: Unify annotated and non-annotated tags
>>>On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>>>
>>>>> If you would like to mimic output of "git show-ref", repeating
>>>>> commits for each tag pointing to it and showing full tag name as
>>>>> well, you could do something like this, for example:
>>>>>
>>>>>       for tag in $(git for-each-ref --format=3D"%(refname)" refs/tags=
)
>>>>>       do
>>>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>>>       done
>>>>>
>>>>>
>>>>> Hope that helps a bit.
>>>>
>>>> If you use for-each-ref's --format option, you could do something
>>>> like (pardon a long line):
>>>>
>>>> git for-each-ref --format=3D'%(if)%(*objectname)%(then)%(*objectname)%=
(else)%(objectname)%(end) %(refname)' refs/tags
>>>>
>>>> without any loop, I would think.
>>>Thanks. That helps.
>>>So my proposal is to get rid of non-annotated tags, so to get all
>>>tags with commits that they point to, one would use:
>>>git for-each-ref --format=3D'%(*objectname) %(refname)' refs/tags>
>>>For so-called non-annotated tags just leave the message empty.
>>>I don't see why anyone would need non-annotated tags though.
>>
>> I have seen non-annotated tags used in automations (not necessarily well=
 written ones) that create tags as a record of automation activity. I am no=
t sure we should be writing off the concept of unannotated tags entirely. T=
his may cause breakage based on existing expectations of how tags work at p=
resent. My take is that tags should include whodunnit, even if it's just th=
e version of the automation being used, but I don't always get to have my w=
ishes fulfilled. In essence, whatever behaviour a non-annotated tag has now=
 may need to be emulated in future even if reconciliation happens. An optio=
n to preserve empty tag compatibility with pre-2.16 behaviour, perhaps? Sad=
ly, I cannot supply examples of this usage based on a human memory page-fau=
lt and NDAs.
>
> Are there any windows for backward compatibility breaks, or git is
> doomed to preserve it forever?
> Automation without support won't survive for long, and people who rely
> on that, like Chromium team, usually hard set the version used.

Git is not doomed to preserve anything forever. We've gradually broken
backwards compatibility for a few core things like these.

However, just as a bystander reading this thread I haven't seen any
compelling reason for why these should be removed. You initially had
questions about how to extract info about them, which you got answers
to.

So what reasons remain for why they need to be removed?
