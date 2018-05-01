Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDF421841
	for <e@80x24.org>; Tue,  1 May 2018 11:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeEALWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:22:53 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:42065 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeEALWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:22:52 -0400
Received: by mail-ot0-f170.google.com with SMTP id l13-v6so12607336otk.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UPieGKfweWllvZBqxUoVbqj4CVusCfjfe/C/ADTVOg8=;
        b=Xk0dyGdeyL0UMLxI2jv9+L0LefRvR7HfkoSO+k1KInQEB7JkWo5n8xThKoXNCAj/1X
         f1CZSO7EWEctGbrGWuv/qdCHhw9ukuhD68uVncmtb8V8tlUh24tMJXEG1wo8CzO36Rte
         7IJSXn/8XSQ7KnXsnPs/RgZatmeXn5qbs8P0S5HAMKyhw3KX8fNywkD8Z4Tau9n5xe3j
         ZdVuPc2PAR+YiWbDPycCi1EV4mMa+blTQNl8XHVik1UCfc6ey8M+VnLnrRCPF37jYWS3
         qWfbughkKZ2SaKc9LLHYSV5DEqAjDBxNJdppqxDL9J5ybUvKS7Vbd2df78zz/IPkR0qg
         ACTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UPieGKfweWllvZBqxUoVbqj4CVusCfjfe/C/ADTVOg8=;
        b=jKjNW9VZd3W0x0rnuRThIIKZxglcD7wrF6frBgGgLK0KkUcsSfMyDe0J0HLBuUbtYb
         qHuKC1NOWcAYHicMbAjrcqOiLBq8nUZKzAs+KUt4Q1DbQM0mxL1j6JnbOOKZC8ro8jLT
         OscDJBcnLyvtxqzSovtpwk1iPTo8CPBv4UhGRZs7V7bXMzMuE955KPROsn6vlWENtrnF
         AHDbIL3XLh0wDvl7ewKjwlHN2qLVHVUPbHNljSVxksVkJSvcBzrKx8lupb9M57o5OIb+
         DlM897+8MG8ySBXylcK61YdFAsoiihrswvw+M0weyrhmNzJivE1TDzdol9IK2PGOus6K
         PGRg==
X-Gm-Message-State: ALQs6tBJiFqzJnxt1Yb5sfO8sy/SPPaOqb85NGewL/Z9hp8/AnIInBBe
        Q1kOfzQ+Xotn9uKM9YfW9gvj98zIJqXC4dSIBLE=
X-Google-Smtp-Source: AB8JxZooXi3EUfk86bgE2idUGoJf2XNhjPKodxZmMGungZZUMxlnfmYpNRmFBpJ6WkLlzo6tOOaa9JiT6iPcI8uIhWk=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr1678225otr.173.1525173771856;
 Tue, 01 May 2018 04:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 1 May 2018 04:22:21 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805011257400.79@tvgsbejvaqbjf.bet>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
 <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
 <7087f0b9-1362-f8ca-315d-96d27b91b26b@kdbg.org> <nycvar.QRO.7.76.6.1805011257400.79@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 1 May 2018 13:22:21 +0200
Message-ID: <CACsJy8BugBtVBZpL+1S5ix+UQzxPaM_L1bBio1fgED5ZQ2XfNA@mail.gmail.com>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 1:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> If SIGABRT occurs as a result of BUG(), and we know that this happens for
>> certain cases, it means we have an unfixed bug.
>
> Not in this case: The code in question is in
> https://github.com/git/git/blob/v2.17.0/t/helper/test-ref-store.c#L190-L201
> and it is called in a way that fails to have the required flags for the
> operation.

To elaborate, in this particular case, developers are not supposed to
call calling create_reflog() on a submodule ref store because the
store's implementation does not support it (yet). So it's definitely
BUG() to catch devs from doing so. But due to the multiple layer
abstractions, we also need to verify that ref code will bug out in
this case :P

> This would normally indicate a bug, but in this case, that is
> exactly what the regression test tries to trigger: we *want* such a bug to
> cause a failure.
-- 
Duy
