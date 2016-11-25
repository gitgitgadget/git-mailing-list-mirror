Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40131FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 12:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbcKYMZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 07:25:10 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33051 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbcKYMZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 07:25:09 -0500
Received: by mail-yw0-f169.google.com with SMTP id r204so61914525ywb.0
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEioUJw4i5ZXnH2l/l13JysV7ysnsa6+wLCIbCwbyP8=;
        b=zT3ZHpiC2W3EXNNSvvP7zwT3feLqeDjLFujcfp/Cmoi+csTYqkREj5WJVqj+cUAJc7
         KEa5ys1pZnRqLUNX2hGPXK0JP7Xf/44mqBMy/IRdNcjWAuJR8dXKZzf1Z+YONcF9/ikH
         fpLfaRYTyv8vY3blM9PwFvKTJ6AvccDJIxN48he/3ELE/z1bt9QIxYhIbYQlS90YhB50
         sBdWyuIhmkPfgUFIUo9NUxSSv3QOaG2iEWdN2C4FTtlNz9a6J7ZaHV/nV7MAfjTbTmIW
         obT1KMfLtOpTPBrCaI1JfpuBCNHWesnZS8QdRzbReFMk2uSh0TuGcx41coWPZFhXx+xH
         /MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEioUJw4i5ZXnH2l/l13JysV7ysnsa6+wLCIbCwbyP8=;
        b=XWXCO2Rn3IPYHQ8DaAJDzvDR6PenhJUzR1H097tEVBtGkgqnfgpvQ0ZZc+EzbNQrPn
         4dJL0UMHq9N3V6yoSei2ph/7n/gWCIUTUMu2qhdvo19UmFaJPoQXph+6cghbQD1E3Asr
         2iBE8ooIWR4+zNHtmOzLrKoxIoWaOx5O5PFmtYqbmIPrsfPtBi1QuN6ygSKEMGGjm9lZ
         Sft/ksEoi0fJGfPFcO54HARtR4f0oGT5Gjsol+OApsmYXjBSWKlQhQ75eSfFQMJgSgU1
         c5memIAKMS2Zz9JSryCHxlivDEOTRaqqq2q7srELgRvaCI6E0qR992juOg2dRTXYem+B
         UmNw==
X-Gm-Message-State: AKaTC03yDZ6JaYX11O7S2AOI2I4H8R5rXjndhOCQte9myHAWPr8SgLuNQ8J3sFCiVOqDmq/GDlUN/JBx3lR0tg==
X-Received: by 10.13.219.205 with SMTP id d196mr8962071ywe.118.1480076708483;
 Fri, 25 Nov 2016 04:25:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Fri, 25 Nov 2016 04:24:38 -0800 (PST)
In-Reply-To: <xmqqbmx6nnpg.fsf@gitster.mtv.corp.google.com>
References: <20161122100046.8341-1-pclouds@gmail.com> <xmqqbmx6nnpg.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 Nov 2016 19:24:38 +0700
Message-ID: <CACsJy8D+vyO0LF_A2Wym+PUg=HOTPyDe-1fVwv8zN797pL-rmw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Minor fixes on 'git worktree'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> This fixes two things:
>>
>>  - make sure the first item is always the main worktree even if we
>>    fail to retrieve some info
>>
>>  - keep 'worktree list' order stable (which in turn fixes the random
>>    failure on my 'worktree-move' series
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>>   worktree.c: zero new 'struct worktree' on allocation
>>   get_worktrees() must return main worktree as first item even on error
>>   worktree list: keep the list sorted
>>
>>  builtin/worktree.c | 26 ++++++++++++++++++++++----
>>  worktree.c         | 20 ++++----------------
>>  2 files changed, 26 insertions(+), 20 deletions(-)
>
> Any tests?

I discarded the idea of adding test for sorting because it relies on
filesystems. A passed test may just mean the filesystem happens to
return files in "good" order. But I guess a test wouldn't hurt.
Somewhere out there some user may still have a "bad" filesystem and
the test could help catch breakage then.

Adding the test for the failed parse_ref() is possible, I think. But
since that function is destined to die, as I promised to use
refs-provided api instead of rolling out a custom ref parser, and I'm
going to have another hard look at refs subsystem for the
gc-not-looking-at-worktree-refs problem, may I make another promise to
add tests after this function is gone? It should happen "soon".
--=20
Duy
