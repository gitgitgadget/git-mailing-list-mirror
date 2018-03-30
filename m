Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB471F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeC3QhU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:37:20 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45975 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeC3QhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:37:19 -0400
Received: by mail-oi0-f45.google.com with SMTP id 71-v6so8179987oie.12
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsFYtmGdcCumFt7gT3taKHH+ymVDjhFppZXNrRySVhc=;
        b=Izi6MH7g6ELVi/Bh0fK+CDU5a+lUwsWH0tWUXwliXnvWWSZ7+5dolgIBs4g1pE5BU8
         /ZbXe9snUamgAZ4dbS4Hhtkom0eHOuRoSRjUn8H3dMXb0S7WACtOuH15o7P8Ng6T5OoB
         g4jn2qeTCc5mF86ZOWTUp56qjC54dHxAnlLxAUf8TsoR+XUNy3ttMB5Prmq7aXKT5c3z
         kyqTMzQ0wV6dgfzasrmiTsWV357oVcizgIN9yvhfJM0cbIUt5Ycjnaf3YaJUU4Ernjcf
         uEyRa24RkdZR+jMb2GeEq1wXPaFgg9NZ8xyvIQkKQ//nYwD1fYmZh1UYLs2VJb5p9eQA
         2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsFYtmGdcCumFt7gT3taKHH+ymVDjhFppZXNrRySVhc=;
        b=oNA+P5QYXd0I3C/dEqCjxKFi8RzARGjs201GQCdOfM6lz8Yy5XsxJH2gC7vM6qJafa
         uf92kmxrVaIFM8DaqCqTJ/yl675kzWtg0T/8vqyLnGFSHpay6tKLBMwXM7geIGeU5LdJ
         Xmnt6pvU99i1xzJZzlO2TmgElmhZC7XeC0YOL+m03/Kmvqq7ZE1lRbaMMPEt5QtmCby+
         8WQkVuLsm5nG/HAYWhggsx3ftOXlEX3lcN8ZYHZDTrQrZmoqSrth2bMi5Oil+ldrr1QK
         AcGkmI6Jc/C//N9QkPaS6CeROhvZaJfMPzxQ/7LsipKZCDn5XfnsSz1NITsoRHPRg1GG
         rAhQ==
X-Gm-Message-State: AElRT7E1MccVYpygGSNDoOt5igq+pKAcwimhIgtNpltrp/gvJND192pN
        FJn0bPmMsUQK3EZuUPiDqEGnyNYqOdchXhQULV0=
X-Google-Smtp-Source: AIpwx4+jfDWMHyvgQlXESMGbqlz9SChUGDbhM35i87KYfFm7EJ7SkoPNrsAThN6fsQPQ7tQTiJJud6g9RxIP2iwVmtE=
X-Received: by 10.202.243.84 with SMTP id r81mr7560073oih.281.1522427838884;
 Fri, 30 Mar 2018 09:37:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 09:36:48 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Mar 2018 18:36:48 +0200
Message-ID: <CACsJy8DPof1jFe_cOS5+5dRHehU+_Y9y86P+5f3s_C0u85BXBw@mail.gmail.com>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 2:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 29 Mar 2018, Jeff King wrote:
>
>> On Thu, Mar 29, 2018 at 11:15:33AM -0700, Stefan Beller wrote:
>>
>> > > When calling `git config --unset abc.a` on this file, it leaves this
>> > > (invalid) config behind:
>> > >
>> > >         [
>> > >         [xyz]
>> > >                 key = value
>> > >
>> > > The reason is that we try to search for the beginning of the line (or
>> > > for the end of the preceding section header on the same line) that
>> > > defines abc.a, but as an optimization, we subtract 2 from the offset
>> > > pointing just after the definition before we call
>> > > find_beginning_of_line(). That function, however, *also* performs that
>> > > optimization and promptly fails to find the section header correctly.
>> >
>> > This commit message would be more convincing if we had it in test form.
>>
>> I agree a test might be nice. But I don't find the commit message
>> unconvincing at all. It explains pretty clearly why the bug occurs, and
>> you can verify it by looking at find_beginning_of_line.
>>
>> >     [abc]a
>> >
>> > is not written by Git, but would be written from an outside tool or person
>> > and we barely cope with it?
>>
>> Yes, I don't think git would ever write onto the same line. But clearly
>> we should handle anything that's syntactically valid.
>
> I was tempted to add the test case, because it is easy to test it.
>
> But I then decided *not* to add it. Why? Testing is a balance between "can
> do" and "need to do".
>
> Can you imagine that I did *not* run the entire test suite before
> submitting this patch series, because it takes an incredible *90 minutes*
> to run *on a fast Windows machine*?

What's wrong with firing up a new worktree, run the test suite there
and go back to do something else so you won't waste time just waiting
for test results and submit? Sure there is a mental overhead for
switching tasks, but at 90 minutes, I think it's worth doing.
-- 
Duy
