Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277B72022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965874AbcJYKxb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:53:31 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35721 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965801AbcJYKx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:53:28 -0400
Received: by mail-oi0-f48.google.com with SMTP id i127so36980070oia.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pE2hqRqqOqZzqxyZs7PsZnBh19SFgaiiOqWNu7bwde4=;
        b=lNMxqmKk2AjsyKRW6mO5LRwX24nV7rtO4UUPi5iZN4+E9vLOlgeMfL463S6irIvb/z
         qnzoU8xPSdFm3CN+UqmNP3r13MnooPKGBiVaX9KemV81lNi6Bh06BHwTbPAIUVLkCa0S
         1cVEQKaGgqxXZvxGG9jmfU2EEH5bddyMrGWI6tjQwnQD0f8zdLjDg3aU4AGhFSBiQMXm
         ZtxRy6w26HZDif37DWRMo2APDSeN8+JWHvzOhlQQYjTGhVzN+ILX7Eap/J2vaCLwIive
         +qWpRkLsmMscXfTwchaiiuCvS1qiNVsC47PAHRQFnRDhA5rOvvSp/mSFGZdtEJP03i0/
         CdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pE2hqRqqOqZzqxyZs7PsZnBh19SFgaiiOqWNu7bwde4=;
        b=GN4KwtqPQPbH2dyeUwy6u26DcEIai+SqzGbCzTKDmBtB91v6dVppRUZdvY98WmG9+0
         pKzoWcVju4IijUv4C3Jct2iKrSkQ6QDjtuYt+0WiPQtIlwx4h12BxT2HmIwGwA387Bcp
         Z5oIEdpPLxR+hzEUn2iorBwW6cpGlJlb6nAK+8ADzSL4MEEGHGmW6ZoLBi4rK2dQRIEr
         iLnEePu1fQbwYT3lPdQJGPLrU0g7cN83gqP/80wwElopjie+QfCo0nuZW0aSW2lLhXVH
         YmlvotGPiSThNcF/BlzE0WJHVEr4MGA8JDUWSEoWpS4dsbteUvfHFmeeoMd9rvVh7FxG
         XMbg==
X-Gm-Message-State: ABUngvfxPG/QxvTLjaHdV8m2n+fAyBYKHFeSHOz0HaJJWzzvjX/PlUsUn38y1a1Uo1S76gTT/y48zygZJKH25w==
X-Received: by 10.107.15.222 with SMTP id 91mr15555969iop.19.1477392807625;
 Tue, 25 Oct 2016 03:53:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:52:56 -0700 (PDT)
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:52:56 +0700
Message-ID: <CACsJy8Be-_n_5Aen2-7sod=wkCbXCGxoakf_H-1Cfb4Mg=T9QA@mail.gmail.com>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Goal
> ~~~~
>
> We want to make it possible to use the split-index feature
> automatically by just setting a new "core.splitIndex" configuration
> variable to true.

Thanks. This definitely should help make split index a lot more
convenient for day-to-day use. The series looks ok (well, except the
pruning logic being discussed elsewhere in this thread, but I still
think it's a good strategy).

> This can be valuable as split-index can help significantly speed up
> `git rebase` especially along with the work to libify `git apply`
> that has been recently merged to master
> (see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98).

I remember this. Since the apply libification work has landed, we can
now think about not writing index out after every apply step, which
gives the same (or more) speed up without the complication of
split-index. But if split-index is good enough for you, we can leave
it for another time.
-- 
Duy
