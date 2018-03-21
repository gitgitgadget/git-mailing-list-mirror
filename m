Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D3B1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeCUQMl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:12:41 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33982 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeCUQMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:12:40 -0400
Received: by mail-ot0-f193.google.com with SMTP id m7-v6so6183412otd.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=glILiK0U/EbvplswdPc0F1LRquJRPoxKqhMpYt1/oAQ=;
        b=uqua6u3ZTYVnI31dsrUi6cMXMWbu8TBAj/ikOAhh3l2pbKmla+X6qpG+4I7g3DdBtq
         clbLsr0m9DB1ezegffN5IOzuj00R8ggyCSL3ZvKLFU3PVdt48C/F78xRBmVc4Cbohaap
         rr3yayPN5lIrpHfDRrGdi7qXUdSYcWwJsZNfIdheh4my5sjP3H+DGZTYKLugxLgid6Ly
         IKrKxh1zafMxScfNEIGEzeNESc3/jPF8bOLJ+R4AxzwX5Vz30Orwh8p7iB7Wrx293Lsm
         FNGa3jIR4dv6vmBW89iHVC/kC5eUb+W02rVUHXCel8VFDQRDn9+ADXVSk2G01U0bXnis
         qLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=glILiK0U/EbvplswdPc0F1LRquJRPoxKqhMpYt1/oAQ=;
        b=c61fuIJFzXcOe4/lkVRszfXOaq/x9S8PQuZoY3CTAIeVf8tjd23PRppOOX5We8hLsL
         VxxwXQusLaiMeNZF6w6QGfzL+Tn8Z0yZPAzQO/Kp/v8DBvHO0nSjnjc3ME0Ny95hmSfo
         zwWnoogx1MgToMuwNWl8NFZLXRLomOi3JzoYrIXaXBIGkxzoHiL7jaVxxss8qtNMumFJ
         2t+GLYQXNksg6NEjJkmluT1K5oqf1aIwFaiGOr9pXlUbTuvWwwdtKKO05Vy/WT5D82KS
         ZgehJg6EeBtFV+dU+zbHRI1b8bm3DPXEFVi34DtoCeVxlKZTVhAXlVP6lMJxnDz3ToNC
         2U3g==
X-Gm-Message-State: AElRT7EGWrPwbdTRf3z7TrrhqnzC5iBl9GOx1mxAMZLNx+Wx09yQL6hE
        uR9R9jqX6jlZNEM4CecujxjC2VqKa3urRkXzpRE=
X-Google-Smtp-Source: AIpwx4/NjfvQ1j6pgIdxCDMlr9MVx1TLOYu8IwAxO99asrPT/vh5tnjjbO2Bxu97NbDkHPp4x45f4EcySSF9Z+g25ks=
X-Received: by 2002:a9d:550b:: with SMTP id l11-v6mr4823474oth.356.1521648759680;
 Wed, 21 Mar 2018 09:12:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 09:12:09 -0700 (PDT)
In-Reply-To: <20180321080343.GA25537@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com> <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
 <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com> <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
 <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com> <20180320180806.GA16521@duynguyen.home>
 <20180321080343.GA25537@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 17:12:09 +0100
Message-ID: <CACsJy8BErdP31AGxSDBMQ-a60WVMSVsUjaJj5xscFGUbgyCWwA@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 9:03 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2018 at 07:08:07PM +0100, Duy Nguyen wrote:
>
>> BTW can you apply this patch? This broken && chain made me think the
>> problem was in the next test. It would have saved me lots of time if I
>> saw this "BUG" line coming from the previous test.
>>
>> -- 8< --
>> Subject: [PATCH] t9300: fix broken && chain
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  t/t9300-fast-import.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
>> index e4d06accc4..e2a0ae4075 100755
>> --- a/t/t9300-fast-import.sh
>> +++ b/t/t9300-fast-import.sh
>> @@ -348,7 +348,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG=
"' '
>>       INPUT_END
>>
>>       test_when_finished "rm -f .git/TEMP_TAG
>> -             git gc
>> +             git gc &&
>>               git prune" &&
>
> The &&-chain is broken from the first command, too. It's "rm -f", which
> is not that big a deal, but...
>
>> @@ -365,7 +365,7 @@ test_expect_success 'B: accept empty committer' '
>>       INPUT_END
>>
>>       test_when_finished "git update-ref -d refs/heads/empty-committer-1
>> -             git gc
>> +             git gc &&
>>               git prune" &&
>
> Same here, but we probably care more about noticing update-ref failure.

Yes. I wasn't sure if that update-ref could fail but did not check
since this was a side issue for me.
--=20
Duy
