Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBFF1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760249AbdDSHAs (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:00:48 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34505 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760055AbdDSHAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 03:00:47 -0400
Received: by mail-io0-f179.google.com with SMTP id a103so15626058ioj.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWRWsh8VVE9BU9G6F8m3JJfjo8H0ap+GPDqgHXY2/78=;
        b=DqeHbKyKIszyfoSUgPtujeLHdnEfkTODOH3q1+WkhaB2rW713WGeVjSBnN/6WuoTYJ
         KIRZ/DuI1NZpwOou5w9N5BLg7p/Jl7SjFRwkDFvvsMut3uB3w6w898UQHoTOQn3soEUi
         Rs5Df9oK30COkltPZwmml5hY3NEDLQqmCtX8Ad/owRT2BY6sdytj5h0mFWOAXQMP1/ew
         kiIqkTAaHg90E1Udg1sxvgUOqOidavJK7pGISX0swI/Gyy8USqpj1gzGRqHcTeoOBSVE
         W74s8165eH6Y97LQ4KvFoZtAvEZRXogkDlNYJMbT/wIZ1erUNwXqn4ZzBLbbiLJ/+Iuz
         ohwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWRWsh8VVE9BU9G6F8m3JJfjo8H0ap+GPDqgHXY2/78=;
        b=MUQhF7yo5eZ04rr9FmLgD03uoQ9Gka3PJctKIXj9ge9c9S7+CWzeozCNgKMVJzSVKS
         PSif2XsOGpiNFwpkNx9/2XNn6Cc0eQtf4xGR2P4khAitrKMArZk0RxqSxHECxb1GU+B2
         y191lQZygfybAha5XLXymv1qWtNPkaZ8CaqWtIRe/gpVVvMB1fRz162Ti2E1GGeGtYDk
         CVTkEao4DKvHcjCDLcD9vMxfzxtsqSyPvkusW/g04bW4naNWp/p2YWZzhdWAoL+yTA5X
         j1v2SWhVUiS8Db/cge44ZzOMusT5CIKFg086evzWTv3ddBgSzXO5y/xGsN7UcbSjoX32
         VHJg==
X-Gm-Message-State: AN3rC/4FxyNbFdb+aKHpNbw4IcePowh7J+iPClq6P/zMIjayTrIPFnQK
        6BADjlJ4+BfAj2uARsIkXlqAoLuqFW2Z
X-Received: by 10.107.32.199 with SMTP id g190mr1736531iog.117.1492585247035;
 Wed, 19 Apr 2017 00:00:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 19 Apr 2017 00:00:26 -0700 (PDT)
In-Reply-To: <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
References: <20170418170914.9701-1-avarab@gmail.com> <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 09:00:26 +0200
Message-ID: <CACBZZX6XWXjvDKeR+a1Ymb4csXgOKLiF==VkKLp5S9TRVQhgoA@mail.gmail.com>
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 12:29 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 18.04.2017 um 19:09 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> Change various --no-OPT options which don't supply PARSE_OPT_NONEG to
>> make --no-no-OPT an error.
>>
>> All of these worked before this change, e.g. doing cloning by doing
>> "git clone --no-no-checkout" is equivalent to just "git clone", but
>> this was never intended, and is inconsistent with other --no-OPT
>> options which do pass PARSE_OPT_NONEG.
>
>
> First: Why does that bother you, i.e. what's the harm?

It's just unintended emergent behavior I noticed. I.e. I was hacking
up clone.c and wondering if --no-no-tags for my new --no-tags would
error out, it didn't, but it should.

> Setting PARSE_OPT_NONEG takes away the ability to toggle the affected
> option.  E.g. git clone would reject --checkout.  Currently users can
> specify --no- options as defaults in aliases and override them on the
> command line if needed, with the patch that won't be possible anymore.
>
> PARSE_OPT_NONEG should only be used for options where a negation doesn't
> make sense, e.g. for the --stage option of checkout-index.

That's a bad bug, I don't know whether to be surprised or not that we
had no tests for this :)

I thought I was just disabling --no-no-checkout for --no-checkout, not
--checkout, but didn't notice the subtleties of the special case
handling for --no-* in parse-options.c, thanks.

> Also: https://public-inbox.org/git/4F4D3545.6060704@lsrfire.ath.cx/

Ah, so this whole thing has been discussed before & rejected. I'll
just drop it too and use OPT_BOOL() in v2 of my other patch. Thanks.
