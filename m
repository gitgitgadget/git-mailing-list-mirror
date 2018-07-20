Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923621F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeGTWKT (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:10:19 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33748 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeGTWKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:10:19 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so5158366ybb.0
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jqG2OJrKyJHlc48tq3D5ruaVsykwn6z+F80UVpjoIE=;
        b=uxsmTPAVEapxqxSVFAR/nDGJICF2lqFyLQd1ZTt/kG+6bNuRW4vxrYY3vnW5T9C0gh
         2qHuXa9TRXra708HwwHZmR1VtgQIXw1Dvtww8Gr0yT+I1kj+zzMqPFUyTIGXG72cmawW
         8Kwb83wJtUnuhUzx6ENDJprjYwrSj/HDkNg3ihN62sWjEeUdRxPoHFXWkU4JWjTXvHqb
         Q3Dy/fdeuOqgIdPzPwjvJp8/j122dKd9YcITTPF+n/jVk7KGpOy2yPgfSD3TA3W6hW0G
         zXMIZwPd3qDNjgQH4+P48yHX8B8A1Zh0jnSjv2yp1LUt/diIrzlgxQCUmURYI6zL411m
         8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jqG2OJrKyJHlc48tq3D5ruaVsykwn6z+F80UVpjoIE=;
        b=RoEWNNkz6gBpan0QflAJKh4OCgYuo4FzCdcXQB3FCz6bzkcHd8VebCKDJ4RCX2RyWQ
         PbKd8OcS3oSTebB2oQ615P/vxi7RdM3QbcFgu3bgT1BZZH/EeDIHTqyX8szk50OSzEgT
         9t/qeY1wb3YzhItBO7+CbYvAuQ1eHQkxts4rhe5oTSX8l07tka6l9D+PH8FgpgKNOeov
         8ZTiR5G/jax/6UhkglGNQpx2HHECaKJz2Vdi/9j0OzwIcV9G084QVn8PkCyfW6M9BUTz
         kxDH+v95+/W8WQ8+d9bw8ir8WDBTow3/Imf1Vz5/jU2n/m2H++wvn1tuiIJaNKm3mQVl
         cVXA==
X-Gm-Message-State: AOUpUlHKAkFj8wH6OxdRc5f5v33CWl9cquFMKpFddyqz435Z3ghULZQ3
        9KBcqzq6fwDV6JqpfYP7j9x5bI+9oKEflAGj8PqWZg==
X-Google-Smtp-Source: AAOMgpddOy9g6ossz1oMv+8qqsvWw7XlxV/ZEi47XAnH5wXQ7jg07bpIPWvbwo7g0G+y5JdMKEC1ON4iaijxpGozhvU=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr2026674ybm.307.1532121615597;
 Fri, 20 Jul 2018 14:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
 <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
 <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
 <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com> <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet> <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 14:20:04 -0700
Message-ID: <CAGZ79kaLTJDmWhS8Y8R1cQh9TRXLawdoWHEzVC6PLHBN+VQekg@mail.gmail.com>
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20]
 linear-assignment: a function to solve least-cost assignment problems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:

> It is not like anybody (including me) needs realtime up-to-date

I thought the same for a long time, but contributing to other projects
showed me that this is not necessarily the case. Having a real time
update, even if it would be just "your patch is labeled 'under discussion'"
is beneficial as I would know where it is "in the system".

In a way I'd compare our contribution process to having an
incredible fine grained paper map. Most of the world moved
on to digital maps, that zoom in on-demand.
(C.f. spelling out "See banned.h for banned functions" in
Documentation/CodingGuidelines is a fine grained detail
that is not relevant for *most* of the contributions, but just
burdens the bearer of the paper map with weight; if this hint
is given dynamically by the compiler or build system at relevant
times, it is much better;

Regarding the real time aspect here, it is also very good
comparison to maps: While I know how to read paper maps
(or offline maps) and how to navigate my way, it sure is easier
to just follow the online up-to-date navigation service, that
tells me what to do. )
