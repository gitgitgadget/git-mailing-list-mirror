Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8661F453
	for <e@80x24.org>; Wed, 26 Sep 2018 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIZORY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 10:17:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIZORY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 10:17:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so13051933pfi.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1/qUePBg+de0LYGvnj8X/GUY6vhRj83TihrYlFJiLU=;
        b=caKnmw6w0yWgiEETWAv+D0IkdymBAThP+QHyR/uDhO6046DrVpOS/yyVlutGXXLYok
         ER6KkvWRLRMTux2MSYBt/PZGIvx1osKAiz38Mc4Azq0d5vJZHZVRS1rXseYVs8hyeNes
         r9k5OAaGH3hsd5S2yjOsc+Jnf/nBWYuZo9kfzIfGhAsyJLZ1jA54Pn4hCnjZzPJgbCHG
         BCmUml31HKlCCxcLtyg5Bz4pzfwPVLMNDyQnetcpqX2DXv09F5XBv6Wp7JvMYh3a7SMY
         m0BL7UfL/f2A6r0VDNx3ERLpoW4ItRWEa0CnAzecB5nz3pFA49zxC4l5ADOlHQi5Xm3Q
         RoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1/qUePBg+de0LYGvnj8X/GUY6vhRj83TihrYlFJiLU=;
        b=EXsSIR9GqDlS6/13s5gMTns2dDNJ2TPyIB6WFacsdOfLGH17VBIXEjNE8QSebCkMim
         g2hIcR/gzfmZwhOBdtj0rffGNun8IyU96av47P3XCod6KwRcS5PFCIsHRtb4+kybBAi5
         tcZCwXXwapMZkyN1bIs9BUO44EJ21ve725WHNyONODpUMpV5JcP1yAVWrwyvljX5stWB
         pwnjK4TV0UM+uo+WgAVAg8lsJp86s4/0u6GMhGvCd2d4JmXuu3ghS8CjdkQ/mpTZfGMY
         Qkij4dUpwrFbsoscqvFFgCUQbrhS5pvz03hgGDT2HcBIqDGqxmkDL6ZXkyGO5bqmS4WF
         SoLw==
X-Gm-Message-State: ABuFfoipelAJWnOwYMqtrPRzvRtOnY5/1T04JodQj+aAeVPdcl6BdRJM
        6N1uSkqp2ecqGQSJfAQ7qXb0Y8Vq62qo8kivnQY=
X-Google-Smtp-Source: ACcGV62w5F1P/40JEbPzndrtNtlxh0OWI8utaaNzcVTCJQUYQcAG5xRfsed2iM5tnPDxiPGYr6kXpt62PudZDbBOY18=
X-Received: by 2002:a63:ef4f:: with SMTP id c15-v6mr4447797pgk.368.1537949142723;
 Wed, 26 Sep 2018 01:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <6319b34fc808ff6d8948e59f381cc5342b9ef17d.1537375332.git.martin.agren@gmail.com>
 <xmqqlg7wyol5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg7wyol5.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Sep 2018 10:05:29 +0200
Message-ID: <CAN0heSqA192U-eH8CZJJbKNcimPYxqn6yva6mstsEHnH1-DEGA@mail.gmail.com>
Subject: Re: [PATCH] git.txt: mention mailing list archive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Sep 2018 at 21:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > In the "Reporting Bugs" section of git(1), we refer to the mailing list=
,
> > but we do not give any hint about where the archives might be found.
>
> And why is it a good idea to give that information in Reporting Bugs
> section?  Are we asking the bug reporters to look for similar issues
> in the archive before they send their message?  If so, I think that

Your guess is correct, sorry for forcing you to make one.

> we should be explicit about it, too.  Otherwise, the list archive
> location would look like an irrelevant noise to those who wanted to
> find the address to report bugs to.
>
> For example, we can say something like this:
>
> >  Report bugs to the Git mailing list <git@vger.kernel.org> where the
> >  development and maintenance is primarily done.  You do not have to be
> >  subscribed to the list to send a message there.
>   +If you want to check to see if the issue has
>   +been reported already, the list archive can be found at
>   +<https://public-inbox.org/git/> and other places.

I think that one reason I avoided spelling out why giving the archive
location was a good thing to do, was that I didn't want to begin a huge
list of "please do this and that", scaring away potential bug reporters.
I think your "If you want to" solves that problem very nicely. I'll wrap
this up later today.

Martin
