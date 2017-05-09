Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034FB2018D
	for <e@80x24.org>; Tue,  9 May 2017 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750747AbdEIVI7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 17:08:59 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36254 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEIVI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 17:08:59 -0400
Received: by mail-io0-f177.google.com with SMTP id o12so1925653iod.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oxxokqAdEtFADZ+1ukIN9BHHmgg9/EtdkRI2+UZBVHM=;
        b=t7LcoS3i43yLmZZ1vwCvw9lB4544dTvEXIVz6LqfEaupGTkPww2r06FMWeRWUXRLL6
         lwY0WftOSpJkjYroEer/sMKrx3chdBP3QugQS3h4VdPCaSczFjGfwNcnoZXwO9au50Dm
         1okJdQ4pVbKnnzCfO/TDqshpyfIlBQdOYQxRJLCAeNgKxsQ/W8qtwhy8WaM+aKrMLgt4
         A/2qAag9eIXv5SNYG0VZO1CmhowoZuKDo9vkPXsw7+U3uUN4TVFLJ7qafcOm5Jzg9z72
         1zdxbbGUoE+6kF6oU+jxgNPOBawMr2ZARDJF97yOZbqYbgriNKHqAVRcjdar5Z8qqb33
         aJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oxxokqAdEtFADZ+1ukIN9BHHmgg9/EtdkRI2+UZBVHM=;
        b=gQ2hf6NhmxKqBC7G8JkVgsmHLUNamZwHYxLFZRAJ7bA2zKeGq/wT1vzrZcVke52WEE
         ozVUKW5a2L6G7H/B7KKcAwmLPC1x3jl4C6YD496p4JPWo5KnSXqHRwQ0HyWrIv7Lcb+J
         Fcbh68Ul25Z+KhvlIZgWEIgeftgQPQmF/lMNlwXrvdV5/LZ26Ykzw8kZoi2x1kWK/d7W
         9KDuNWYnZlmBWnoNbX3iMpczQS9VhuJjEoqHlsmOUGGdJn4Kf/ru42yDDLv0UsG6V2P+
         Bcz6ff7OFhnYX3ZHXCU5+TgvIXMTEDmFbRaRDzmWfhj4CbXMIEhIioaTkkiN6wFX8Q/T
         aI+Q==
X-Gm-Message-State: AODbwcCROVH/KM1JnYvOiBuCiYA/1xgA7Y4l+38q1WOcGOEj52SeAhOv
        d0nqifKIF5wHJWodhoOiR2KoF2c3KQ==
X-Received: by 10.107.201.131 with SMTP id z125mr412085iof.160.1494364138322;
 Tue, 09 May 2017 14:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 14:08:37 -0700 (PDT)
In-Reply-To: <4cb1d101-3efa-6376-64fd-2b9090d0b0c4@kdbg.org>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com> <20170509164515.31942-1-jonathantanmy@google.com>
 <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com> <4cb1d101-3efa-6376-64fd-2b9090d0b0c4@kdbg.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 23:08:37 +0200
Message-ID: <CACBZZX6T6f_XzqgAM8RO7sNsUy+0Qsawdaha7B4BtADt5fJszQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! use perl instead of sed
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.05.2017 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> Finally, you can just use -i like you did with sed, no need for the
>> tempfile:
>
>
> Nope. Some implementations of perl attempt to remove the file that it has
> just opened. That doesn't work on Windows. You have to supply a backup fi=
le
> name as in `perl -i.bak ...` :-(

This should have been fixed in 2002, and is in 5.8, the oldest perl
release we support: https://github.com/Perl/perl5/commit/c030f24b81 &
http://www.nntp.perl.org/group/perl.perl5.porters/2002/05/msg60275.html

But maybe __CYGWIN__ isn't always defined on Windows, maybe this was a
mingw build or something and perl was missing a test for this when
support for that was added?

This is obviously a trivial issue for git, but if it's a bug in perl
I'd like to fix that.

>>
>>      $ echo hibar >push
>>      $ perl -pi -e 's/([^ ])bar/$1baz/' push
>>      $ cat push
>>      hibaz
>
>
> -- Hannes
