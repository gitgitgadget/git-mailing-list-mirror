Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE83208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 17:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdIERYU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:24:20 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36305 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdIERYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:24:19 -0400
Received: by mail-pg0-f49.google.com with SMTP id m9so10615496pgd.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6A57qGYYMNNcGyBK3/H1fAKLNSHxq4w8ht7dZi2dkmU=;
        b=OVfNrog1VMwazAD0HfJSCpKvXWNkWY9WXwoYfmKWcStPMN0MymGqu3o8I3wLbAkznZ
         K13yrIp9g2s9zsSzsK+r6T8wET8hlDzqbkhlBz1KuaecLBbhM5GxFn6+vGfqMU1fAwd8
         Z5qSx2V0XAbgU63GXxDu+ECkk7X9oZfQACBEBcKRvNoowbIU7vhdzO48WGoImP1EvwMj
         TZx/DET2iEQAAggSelZ9/rbzhk+Wz+Z2MAAlmRFh2GCPhWbX4dlBtXgmajIoS/j7wS1f
         +dZTXlFHrJYwiOk9m1EZuUTOcVTBuMMRpxr1XGltiSmwGgQKl4JRa6yMDNqy8r3kbV6q
         bWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6A57qGYYMNNcGyBK3/H1fAKLNSHxq4w8ht7dZi2dkmU=;
        b=OxpA6fJtphMJlt6KwTOzz/tTcDjO6r17qOXg2m8yEu4Cm/K7sa7j1f+3K3bJDn+5fc
         XqRBkiec71Uq1YHaoeM5U3PPwkTwyMbq9Ek/bbbj1LjH1C32LWTnAC1Ehmjuwtzj2DOQ
         vGcBHP0tOFzX0uoYohg6VBM/fb0GF0Z7cFEtWUsEEvlBPWiDtJP9H3ioJAKArlzA853I
         SozTvPRU9hXawOlSO89YfKjZtvgr483MjqMAzXzoA4rLYelPbM6NG/KigSjhuHztKV/4
         Tepz3TVQfCcGEE+cdAO0NzMTovdxBA42vfmWkrJUxS8Va6f8rSAKSKWTYAIMBTrtx1ae
         +TDg==
X-Gm-Message-State: AHPjjUhtDUqHYZ5ANb1CNX6H/j/ZS4dVfssvC5TK2fx7R6JY3IXaqeqt
        DEPYCH2qOHyAUHDWEuKXpC9Jhhh0Yg==
X-Google-Smtp-Source: ADKCNb671zuek5ZYdN0HqOAC3n/HGLlZutMuYv+6wRm9xBtEs68dAaqPmR8jiNmO8Fq1W+il26UbabtXRJ1HWXEPU8g=
X-Received: by 10.101.80.140 with SMTP id r12mr4629500pgp.267.1504632258734;
 Tue, 05 Sep 2017 10:24:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 10:24:18 -0700 (PDT)
In-Reply-To: <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu> <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
 <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 19:24:18 +0200
Message-ID: <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 12:02, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> On 30 August 2017 at 04:52, Michael Haggerty <mhagger@alum.mit.edu> wrot=
e:
>>> v3 looks good to me. Thanks!
>>>
>>> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> Thank _you_ for very helpful feedback on the earlier versions.
>>
>> Martin
>
> Yes, the earlier attempt was sort-of barking up a wrong tree.
>
> Once we step back and observe other users of affected_refnames and
> realize that the list is meant to to point at a refname field of an
> existing instance of another structure by borrowing, the blame
> shifts from files_transaction_prepare() to the real culprit.
> Michael's review gave us a very good "let's step back a bit" that
> made the huge improvement between v1 and v2/v3.
>
> I wonder if we should be tightening the use of affected_refnames
> even further, though.
>
> It is may be sufficient to make sure that we do not throw anything
> that we would need to free as part of destroying affected_refnames
> into the string list, purely from the "leak prevention" perspective.
>
> But stepping back a bit, the reason why the string list exists in
> the first place is to make sure we do not touch the same ref twice
> in a single transaction, the set of all possible updates in the
> single transaction exists somewhere, and each of these updates know
> what ref it wants to update.
>
> And that is recorded in transaction->updates[]->refname no?
>
> So it seems to me that logically any and all string that is
> registered in affected_refnames list must be the refname field of
> a ref_update structure in the transaction.

I'm with you up to here.

> And from that point of view, doesn't split_head_update() wants a
> similar fix?  It attempts to insert "HEAD", makes sure it hasn't
> been inserted and then hangs a new update transaction as its util.
> It is not wrong per-se from purely leak-prevention point of view,
> as that "HEAD" is a literal string we woudn't even want to free,
> but from logical/"what each data means" point of view, it still
> feels wrong.

There is a "Special hack" comment related to this, and I don't feel
particularly confident that I could make any meaningful contribution in
this area. To be honest, I don't immediately see in which direction your
suggestion/idea/thought is going, which tells me I should not be making
a mess out of it. :-)

Martin
