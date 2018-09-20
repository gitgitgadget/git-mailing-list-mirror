Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6688A1F454
	for <e@80x24.org>; Thu, 20 Sep 2018 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeITTWc (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 15:22:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46434 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeITTWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 15:22:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id t20-v6so939855ply.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xL5LnnipNSRxNvvuHbZIEewSnMMMWW7RTjPaDz0Fuis=;
        b=AMdmU5XVS7o/0SuQjcusOJ1AnU8Lc/M1y9Z1UrQl7KincSwIFe1oUELosbLGmQrsHh
         18tPh+GxZqaSynN0SQTcGVc0dPqUHPDLDGYFRHMkEJh6qkBZHYWTYmNpYoD29DA/huR1
         L6UXmC/R5O0xc/kcppd591GLLc91RTEyaDlIZIYhikzfAjc5UYAnP+7L6HSXnaZNWqNg
         rL2movmPtYw+ApNhp6yp6k6SrUi5VTok99uU4MtnGjI8UDUkff/JwuyEjzHwxiVDgi8f
         50xvPMzeudBgD6xNbhTObKj9CEtfdrK+Mj3fUZbZ/iSYtxhD+xqBPxbIo57Z6Az48Ud/
         bEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xL5LnnipNSRxNvvuHbZIEewSnMMMWW7RTjPaDz0Fuis=;
        b=NMGG3YIad9GwANGnT9ZX3YRmCpYoKvqwD3uUOiYOoszgXiXxe7rtwXubRm3QF+aRSu
         pPhYKry6vl2X+yC1wWBWeK/c7ydCb6UEluLe6f06VvNx/kEb83JITz0uehJXBuIZvScK
         nQkZG1YpbyeLrXXX7DfMy3SjP0h1yxV8p3/74ybchxp+JRNufwUXskleOEz2GWnxEUn0
         VN3CsxD8529TGepHXb1WL2lB5btj4pdQWVOfQYy8JmfwJEyEPJUP8w2qfRFlQ4zInObd
         z9smcYFsgfcL9Q15uF7uipLgiWwHpGaRFb6WweGkLoXkbGhVYctIVvEDfpZnbLOsjC+m
         8XQw==
X-Gm-Message-State: APzg51BjqQ6R4w7P4jEqvs4pnL6eqkdc2wchunh0iDv3yENfYSoJ7f0C
        2YzOqNmW4dkfxR1CtktBrpFm5Oo0GoW9UA6FgeAVyQ==
X-Google-Smtp-Source: ANB0VdaGWqt7EE68oK+ja53xgwfojBeACUs40RPE9Hq1YUgK2gWJvcKzBDNDS/Q28KayWTP8we/Ba2WUMjNw7R3lkmY=
X-Received: by 2002:a17:902:bd04:: with SMTP id p4-v6mr39985800pls.105.1537450739678;
 Thu, 20 Sep 2018 06:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537374062.git.martin.agren@gmail.com> <65f42c947aa2b392075740673a5dc889fd6e64e6.1537374062.git.martin.agren@gmail.com>
 <38803edb-de41-90db-33f6-f1a0d5344608@gmail.com>
In-Reply-To: <38803edb-de41-90db-33f6-f1a0d5344608@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 20 Sep 2018 15:38:44 +0200
Message-ID: <CAN0heSo89WS69VXuPp02nQizordMWgNG0D0o-f-tm02Tp_gGEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] git-commit-graph.txt: refer to "*commit* graph file"
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Sep 2018 at 14:50, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/19/2018 12:30 PM, Martin =C3=85gren wrote:
> > The full name, by the way, is not the "commit-graph file" with a dash,
> > cf. the synopsis. Use the dashless form. (The next commit will fix the
> > remaining few instances of the "commit-graph file" in this document.)
>
> The file is literally at ".git/objects/info/commit-graph" which is why I
> tried to use "commit-graph" everywhere. Why do you think that "commit
> graph" is better?

I noticed the discrepancy between "commit graph file" and "commit-graph
file" and briefly wondered if it was intentional, i.e., if it meant
anything, but the dash vs no dash seemed pretty random to me. In order
to figure out which was (more) correct, I went to the synopsis. But
admittedly, that was quite arbitrary. For all I know, "the commit-graph
file" could be the better choice, grammatically.

There is the file named "commit-graph" as you note, but it might on the
other hand just as well be called "cg.bin". I would probably try to let
the filename "commit-graph" influence the user manual only if we would
have written "cg.bin" instead. For example, if we would talk about how
you might get out of a hole by deleting the "<...>/commit-graph"
("cg.bin") file manually.

But that's certainly not to argue against "the commit-graph file". I'd
be happy to s/commit graph file/commit-graph file/g instead to keep
others from wondering if these are two slightly different things. And
if the concept and the file have the same name, all the better.

If you agree, I'll do that in a v2, where I will also note in the
Options section that `--object-dir` takes a `<dir>`.

Martin
