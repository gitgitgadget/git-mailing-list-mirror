Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B86D20188
	for <e@80x24.org>; Tue,  9 May 2017 10:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdEIKXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:23:17 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36415 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEIKXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:23:16 -0400
Received: by mail-oi0-f41.google.com with SMTP id h4so81516591oib.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPQ/VvcIW2cK8Dn6SRQCUngrR8lnGmN5J8g6b1kobg4=;
        b=VESFHTc5J0DHTXk91CK4xO0VdP/zv8FQLZrwqJkAkQmL9dkeya/zUmVEwc6C9nVIUR
         krRMG5etIDot3qsxGqSCvSu2o2Y0SNGd2ctt7XuFy7bUmYsmfwvamL7HVGXK0iIM3904
         sCvgcNNchHGuR15ytHKJhs8eI760H7sCur3+BRyjzewgO6K/pGr/sII4kHdZM5f0qdJv
         pMzZkQkJHWwNGC2z9rLtQ+PTAFPrXt9MoUloj1Mq8AlcJhiSGxcYng3zv/NgFLsWQEaT
         1JWDB6rJ9Fug/1YsR9EVWE0w87YrPbds1PkC1YFa6S5wKH4TGiDME6bbMTwxv90AUAFz
         /U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPQ/VvcIW2cK8Dn6SRQCUngrR8lnGmN5J8g6b1kobg4=;
        b=mDY1pRB+tv7jhKfj2cFylb6ga1Sghjg1CHNfKzuxSFlpHA6wSEWSOEt5ZBgGXXg9ps
         Wv4AekBR7IBGPoX1/GIXqcF9Xi4ZpWQeE1qV0ztVW0KiADyjMsq2vrHw0CXarz4lxIky
         iQmVFRPMwaXsPUVqsVC0fKnMJbTENO0SgQqKBJ2gDcdNxo8HC8ivAKKO65Ratr2L8kMk
         2oahf6tnHBykOeWyvjppmIN+NtQEZB+7mBojOvQYLlHnj/CckmxAwI1Wgs5WQIHenqHw
         166oE97d3agxQPC2Q3+5cl3k6E3ZWnIdfcG/RY1hj75/chmts+hq9nugXLNChwlMiX9p
         0Lpw==
X-Gm-Message-State: AODbwcA4T4LtrZWNdF5gzL8Sgf3ALDIe4C/VlHIs0ogQlrYfsM5CI7WR
        MOQ6U21DM+klMel6u8bI+OxDF1Ct3Q==
X-Received: by 10.202.220.130 with SMTP id t124mr6506511oig.112.1494325396232;
 Tue, 09 May 2017 03:23:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Tue, 9 May 2017 03:22:45 -0700 (PDT)
In-Reply-To: <CAPc5daVwnsC2iqrX4PYL9LJyfD76dA1TS3xCNM7qHtmfHd0aWg@mail.gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com>
 <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com> <CAPc5daVwnsC2iqrX4PYL9LJyfD76dA1TS3xCNM7qHtmfHd0aWg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 9 May 2017 17:22:45 +0700
Message-ID: <CACsJy8DyAV4y_-gsjk1QSGkcq+-jGX6y-ymuHvUEMfV3gxJa_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/21]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 7, 2017 at 11:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, May 4, 2017 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>> > Changes since v1:
>> >
>> >  - fopen_or_warn() and warn_on_fopen_errors() are introduced. The
>> >    latter's name is probably not great...
>> >  - A new patch (first one) to convert a bunch to using xfopen()
>> >  - Fix test failure on Windows, found by Johannes Sixt
>> >  - Fix the memory leak in log.c, found by Jeff
>> >
>> > There are still a couple of fopen() remained, but I'm getting slow
>> > again so let's get these in first and worry about the rest when
>> > somebody has time.
>
> Hmm, is this topic responsible for recent breakage Travis claims on MacOS=
 X?
>
> https://travis-ci.org/git/git/jobs/229585098#L3091
>
> seems to expect an error when test-config is fed a-directory but we are
> not getting the expected warning and error?

Sounds about right. Let me see if defining FREAD_READS_DIRECTORIES on
MacOS X makes travis happy.
--=20
Duy
