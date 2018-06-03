Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048B81F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeFCIIt (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:08:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41220 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCIIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:08:47 -0400
Received: by mail-yw0-f194.google.com with SMTP id s201-v6so8231987ywg.8
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2vablAXiimcKAKcZnFrDsWbUfBwU455dNdqkZ0lL0Os=;
        b=j7Q3AIp92Bh3uslgNsO40kUY1cBePB51GGd4twAFKWqwLop4UZ8/0BT++HQbN4F7TM
         bzwGFklAzpEwry1d9NIVInMuDH5acnZBJ4ORFVdVBzrfcl/nlK1YgwnyN27bNqnXgOoO
         u2pVl5o60RQK/FEzNA4pLWavIRNo2uk2v1rl24L2dwyQA6xo8FMwDsXz/+u7k/fnHQmC
         TtclaLzEnChXFPTlgsM4ep15oobt6Y08kobLE9n8zCoah5FbhcTGVnwTxV/cZGLcRpXp
         lFVVjPRA2ybRgv8g+cq5QCWfm6vKYjEXdlxna836dCl/CoXzE5ffpJYTK5xvzwkWxSSA
         M0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2vablAXiimcKAKcZnFrDsWbUfBwU455dNdqkZ0lL0Os=;
        b=UzDG5Wae93RX3E2pJeQaeBkA+MJnJg6NmQZPP3rV+RqzAIZTv2DADdJITWwOP8pmNK
         36zHs3SZp9tOoZ7pzkwvn4A0JmwWuuCKKbn3Tu4AACiGWYrk+FMdTgZLLoDcaGOnJTQj
         SfaD2ooqsA+tSGEPPcSy94DbnntPEBb7Vrq6Cox75VU+5b94wzy0bg5/TelRLAswzJEA
         YfNaWRmb5gvr8O855UCNf8WOc62ohaEH4oPEY+1xoUELiiCzNDD4xTqKa9Ci/1RGTE0k
         Uk/Cwd5GEsLUPqiar1jGDT/z3XmOOWHIgpXqst1PmsC6IDsYqM57crsii6IgDDX6i1HR
         6MIg==
X-Gm-Message-State: ALKqPwecUX+gHuvXTX7ww6B55Kr0JiKWoyZd37U1T4WQqhWl0+1wNbQX
        LAgstWg/YW1+M03wRhRdAdXBZGGtVGJTSli7jT5Gkg==
X-Google-Smtp-Source: ADUXVKJmjwlT52uMHRkSk3Rl2aSzM0Yxkp8Q9s+zfYoWzmFPfEizEwyiZN6fMVeQmKbOGhqEuBuKWy/OB2AI4KpRRas=
X-Received: by 2002:a81:8203:: with SMTP id s3-v6mr8862018ywf.131.1528013327177;
 Sun, 03 Jun 2018 01:08:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:08:46 -0700 (PDT)
In-Reply-To: <20180602043241.9941-17-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-17-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:08:46 -0400
X-Google-Sender-Auth: JYWCYTwA1lAywuJQB5znCumHG1s
Message-ID: <CAPig+cSC0dx9hwMQt9wAMQNezPNm7_GP9UqbxH1ZtuqrqaS=pA@mail.gmail.com>
Subject: Re: [PATCH 16/22] refs.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/refs.c b/refs.c
> @@ -1845,7 +1845,7 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
>                 if (!cmp) {
>                         strbuf_addf(err,
> -                                   "multiple updates for ref '%s' not al=
lowed.",
> +                                   _("multiple updates for ref '%s' not =
allowed."),

In other messages in this patch, you dropped the period at the end of
the message. Perhaps do so here too.

>                                     refnames->items[i].string);
>                         return 1;
>                 } else if (cmp > 0) {
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> @@ -390,7 +390,7 @@ test_expect_success 'Query "master@{2005-05-26 23:33:=
01}" (middle of history wit
>         test_when_finished "rm -f o e" &&
>         git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
>         test $B =3D $(cat o) &&
> -       test "warning: Log for ref $m has gap after $gd." =3D "$(cat e)"
> +       test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
>  '

The change from '$(cat e)' to bare 'e' caught me off guard for a
moment, but use of test_i18ngrep explains it. Okay.

> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-=
manual-resolve.sh
> @@ -541,9 +541,9 @@ EOF
> -       grep -q "refs/notes/m" output &&
> -       grep -q "$(git rev-parse refs/notes/m)" output &&
> -       grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
> +       test_i18ngrep -q "refs/notes/m" output &&
> +       test_i18ngrep -q "$(git rev-parse refs/notes/m)" output &&
> +       test_i18ngrep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output =
&&

I hadn't seen test_i18ngrep take argument -q elsewhere, so I wondered
if it handled it correctly. Checking the implementation, I see that it
does pass it along to the underlying grep. Okay.

I also wondered briefly if it made sense to drop -q here since it
doesn't necessarily help debugging the test upon failure, but I
suppose such a change is outside the scope of this patch series, so
probably better not to.
