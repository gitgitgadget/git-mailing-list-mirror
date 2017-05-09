Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FE92018D
	for <e@80x24.org>; Tue,  9 May 2017 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbdEIXoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 19:44:32 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36460 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEIXob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 19:44:31 -0400
Received: by mail-io0-f180.google.com with SMTP id o12so3781554iod.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fmRuPspTA0d605b9H+rWP0tB7EJ6XNQq0ZIp4c3TTDc=;
        b=jJyhIG7yRzfmDDE4/BonzPZwGvqBXwL55X8PUEAdAfzcxpGPzKiIvUQImCK9xZD12m
         cusAi6vkqq518QVf8UClxATy25lLnOyEyC+5L7dxEP4bspyD21AuWNo9AKEnzr2VkmTP
         6Nsor9O0YxBoFn4NMfdxHe4I5nGT0e8zfGwnZUx5w02BEU/nWk+4kNKlIYvmDUJb0Agf
         DP3hAE+YjNWaviZxeRU0votdhUhmkM/ao0FkHSrkHx7kNBXHXpLL3BJFTBWVtqrZ3Yjj
         IT82o0P5htPMCRqCsU+tMRyU1dX+RSWEc1Aek4ChcD5yXiyy5l5xye8ZN6GD8uLF4Ihq
         eSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fmRuPspTA0d605b9H+rWP0tB7EJ6XNQq0ZIp4c3TTDc=;
        b=L/eRJbw9/ux0AkcUfeixr14NChF7ItKDlja5yCGJz0EoYDYBN/6cAnQKUNcr+s+RIH
         hBf4pBLNl4L0++4OiI2MWiV9p+Xl/JkEiq5ocN/Rcur9eqsY9Sp2CGUr9xrrITS5Ub3n
         aDZVi+ntSrFh7xfsx41kAv2UKurBUUJNHk6Hp2d+yz810tIFRxsGSKKg1XjB3LbJkTAu
         dhZhnHzHsO/gUMlJS59H2hcigrWXpCSJq+iemWg4ISdOVqhL00zWz5BQXh6DIbAfpPpi
         K2SNSgew60RebZeGwlWXGs0q5pBFZz8Ywsq110ILdDS3j8A/jbL6SPneL/I/LAXUmqEd
         lgTg==
X-Gm-Message-State: AODbwcCNn8kYEjwxn94DXZGvjtkic8U8fo4oUybkDEvgRWtrOKNgwAqI
        geFaOeVThYfd6RSxKLS1gTDoDR3yUQ7M
X-Received: by 10.107.178.12 with SMTP id b12mr960256iof.50.1494373470640;
 Tue, 09 May 2017 16:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 16:44:09 -0700 (PDT)
In-Reply-To: <xmqqd1bh1wqy.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com> <20170509164515.31942-1-jonathantanmy@google.com>
 <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com> <xmqqd1bh1wqy.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 01:44:09 +0200
Message-ID: <CACBZZX7diKKuz0r2uWQsAmxDkWm_2Afi=zWSTRMYRwiobEGwpw@mail.gmail.com>
Subject: Re: [PATCH] fixup! use perl instead of sed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 12:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, May 9, 2017 at 6:45 PM, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>> ...
>>>         # Tweak the push output to make the push option outside the cer=
t
>>>         # different, then replay it on a fresh dst, checking that ff is=
 not
>>>         # deleted.
>>> -       sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
>>> +       perl -pe "s/([^ ])bar/\\1baz/" push >push.tweak &&
>>>         prepare_dst &&
>>>         git -C dst config receive.certnonceseed sekrit &&
>>>         git -C dst config receive.advertisepushoptions 1 &&
>>> -       git receive-pack dst <push >out &&
>>> +       git receive-pack dst <push.tweak >out &&
>>
>> The test should have a PERL prerequisite now, that's missing.
>
> For a single-liner like this, our stance has always been that t/
> scripts can assume _some_ version of Perl interpreter available for
> use, cf. t/README where it lists prerequisites and explains them:
>
>      - PERL
>
>        Git wasn't compiled with NO_PERL=3DYesPlease.
>
>        Even without the PERL prerequisite, tests can assume there is a
>        usable perl interpreter at $PERL_PATH, though it need not be
>        particularly modern.
>
> So unless "receive-pack" that is being tested here requires Perl at
> runtime, we do not want PERL prerequisite for this test.

Oops, sorry about that.

>> Also using \1 will likely be deprecated in future versions of perl at
>> some point:
>>
>>     $ echo hifoo | perl -wpe "s/([^ ])bar/\\1baz/"
>>     \1 better written as $1 at -e line 1.
>>     hifoo
>
> Very good advice from a Perl expert; thanks.

No problem. Hopefully my noisy advice will at least lead to fixing a
bug in perl if there is one :)
