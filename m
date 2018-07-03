Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F781F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeGCVfA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:35:00 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46738 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCVdX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:33:23 -0400
Received: by mail-qt0-f170.google.com with SMTP id h5-v6so2918064qtm.13
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSzsP08zRMafOlMaRfjGTFwkg7l/KeVED91V36PM4/w=;
        b=U8d5almk0uP84EIONXnf7vEwsHKBdNe5D5am/G7O2n8DYorpjILC0NIqCooi45rs5A
         IKTMy5+t1IVAJwa6rhcpHsdRC0F1T/GuDo7sBf3OmikHPAJg1eyoO2KY7BdgC0wyDTML
         3NsSVREMfWfJaj8lZeGgZspk5D6bBCN3IRIE5qbKSc9Y69cfq3wVBM/QwWc2ImoTy/Lj
         Dl08nE8o5ZxT+1nVsxgti0E6x2qKv8lJ6l9aXBfV+eKxRTqGbjgqzux7tqP90ZeMs1v5
         LlBG5hW6Vo889zYw2OEs1Eyy9OkuXv+GNu0FtrRti31z2lmgXeb6Qctwps3WDHh1wdK5
         buOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSzsP08zRMafOlMaRfjGTFwkg7l/KeVED91V36PM4/w=;
        b=GxeAwac09Wsyyw2CpGIpMAcLASCzhwAK6C0ibJp8Twka0Bq2yLVqzlE9q2nxPzNEL9
         HH7a/g7vygnApzJVozp4/W/WJ3sqmaV0LS2RA3J6AkT+oEPsuLraPhlu/ik8QqqOJRVY
         5yeICs7CqYUtlL1GrUwE81ftEf/FYZUl7sVE1IuXjuC0ai1A0okkltP32Wgr5rbZmFzE
         f6IxuEUYxcdB0+QTyOeA4k2swuDgLgVrWEirsx02J2M/Y91kcmsppGi2J64qsjZOmglY
         I8h6WWcGPJ4Q9DkNwtt51EfZTQif4rdJZ5IhhdKVlIHQfhXeWoYf8mLYevqdCek4P+s4
         ygTQ==
X-Gm-Message-State: APt69E0VIayJxRFVeOBPp5/W4Wt9fArt2EMXbLuewWZyVIowSqyWgMj/
        3kOie39jF+s2tfSRUZE5fd+oqoj8/AFr0wUfyJY=
X-Google-Smtp-Source: AAOMgpcgcW/Dpd6j6/6MUIX/kY6mxJWawnwZqcB/hM2xmBztLbnaIbXJRMEP+wPmtuajvrlXynYsaj5VsSP6BaBJSj0=
X-Received: by 2002:a0c:98d1:: with SMTP id g17-v6mr27870964qvd.27.1530653602091;
 Tue, 03 Jul 2018 14:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
 <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet> <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
 <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
 <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
 <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet>
From:   Tiago Botelho <tiagonbotelho@gmail.com>
Date:   Tue, 3 Jul 2018 22:33:10 +0100
Message-ID: <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Jun 2018 at 12:21, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Thu, 28 Jun 2018, Junio C Hamano wrote:
>
> > What I meant by "many separte grep calls" was to contrast these two
> > approaches:
> >
> >  * Have one typical output spelled out as "expect", take an output
> >    from an actual run into "actual", make them comparable and then
> >    do a compare (which does not use grep; it uses sort in the
> >    "making comparable" phase)
> >
> >  * Not have any typical output, take an output from an actual run,
> >    and have _code_ that inspects the output encode the rule over the
> >    output (e.g. "these must exist" is inspected with many grep
> >    invocations)
> >
> > Two things the "output must have 9 entries, and these 9 must be
> > mentioned" we see at the beginning of this message does not verify
> > are (1) exact dist value given to each of these entries and (2) the
> > order in which these entries appear in the output.  The latter is
> > something we document, and the test should cover.  The former does
> > not have to be cast in stone (i.e. I do not think it does not make a
> > difference to label the edge commits with dist=1 or dist=0 as long
> > as everything is consistent), but if there is no strong reason to
> > keep it possible for us to later change how the numbers are assigned,
> > I am OK if the test cast it in stone.
> >
> > Another reason (other than "many separate invocation of grep") to
> > favor the former approach (i.e. use real-looking expected output,
> > munge it and the real output into comparable forms and then compare)
> > is that it is easier to see what aspect of the output we care (and
> > we do not care) about.
> >
> > It is harder to see the omission of exact dist value and ordering of
> > entries in the outpu in the latter approach, and more importantly,
> > know if the omission was deliberate (e.g. it was merely an example)
> > or a mere mistake.
> >
> > With "using a real-looking expected output, make it and the actual
> > output comparable and then compare" approach, the aspects in the
> > output we choose not to care about will show in the "make them
> > comparable" munging.  If we do not care the exact dist values, there
> > would be something like s/dist=[0-9]*/dist=X/ to mask the exact
> > value before making the two comparable to see that the expect and
> > the actual files have the same entries.  If we still do care about
> > the entries are ordered by the dist values, there would be something
> > that sorts the entries with the actual dist values before doing that
> > masking to ensure if the order is correct.
>
> The problem here is of course that you *cannot* set the exact output
> in stone, because of sorting instabilities.
>
> So you have to play tricks to sort (twice, with different keys) the
> expected output and the actual output, to verify that all the expected
> commits are listed (and only those) and to verify that they are ordered by
> the distance, in descending order.
>
> And this trick, while it still makes the test correct and stable and yadda
> yadda, *also* makes this trick a lot less readable than my version. And
> therefore makes it more difficult to verify that your test actually does
> what it is supposed to do.
>
> Ciao,
> Dscho

Hello,

first of all I would like to thank all the feedback provided in this patch it
has truly helped me progress on my first contribution to git.

After looking through Junio's and Johannes's suggestions I believe that
the *only* test we should add will be something like:

-- snip --
test_expect_success '--first-parent --bisect-all lists correct revs' '
git rev-list --first-parent --bisect-all F..E >revs &&
test_line_count = 9 revs &&
for rev in E e1 e2 e3 e4 e5 e6 e7 e8
do
  grep "^$(git rev-parse $rev) " revs ||
  {
    echo "$rev not shown" >&2 &&
    return 1
  }
done &&
sed -e "s/.*(dist=\([0-9]*\)).*/\1/" revs >actual.dists &&
sort -r actual.dists >actual.dists.sorted &&
test_cmp actual.dists.sorted actual.dists
'
-- snap --

The only change I had to make was use -r in sort to
revert the sorting in `sort` otherwise we get it in
ascending order but the revs are provided in descending order.

Kind regards,
Tiago
