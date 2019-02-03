Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE211F453
	for <e@80x24.org>; Sun,  3 Feb 2019 08:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBCIRQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 03:17:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42294 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBCIRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 03:17:16 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so6768774vsd.9
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 00:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVzfcFKrghj8StrkdwDXtEDJeTtO8K3iJceJRO+9wLY=;
        b=UsnAznIdzQdWucvbVAWjZN1+mMRB/L4baVQ0R97HQvTWP2qusFx0v33/qUWZejaNWS
         9fVz+lwIheyH7C2wL6uRZg78WDTRZyIKMcIoR573cpAUrgws5lSXuQT28nJZO3idVt1t
         rivqns1tWHS0QjmR7y7GQTKomL0U5vwFyaK8uUO8uqv0soziOKJhT1ltOZ8XeA4uzOKI
         jhvTS3QQ17ZxdFMIkQHS2eBkxQQa/akL7JHE+injpBpxDwg/wHoRTwVP3f9c5ZrKnhlT
         FYnRa0vzA+3vLqKvKNZnshmNN7l2ryWI5BnsgzzlsSb7jOjn/VIVNvrzt/qrRh309Csf
         jVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVzfcFKrghj8StrkdwDXtEDJeTtO8K3iJceJRO+9wLY=;
        b=AFPeekvIRbuj/XDOg1XBpKLU7w0jvvg/xgmHe8+DtDPNFDXKxCO2PjTh6n0TdsIAsk
         4VHu9L+i5oozdFy2cougJ+3tj6cyGJMnBWhoZd95HxnuVA+K6x9udiHHYayYTNdr7Kbx
         IcMoMoZKHYMsapthC36OjOvf5FteOmObdZLJNSoxcuZpP1AZC+Lnl4I9dtPjAEY66bPY
         Yn9qRuZ1AwcFiq33UOS30OPaQ8sDgGk3Pw6VbPJFhiQx/NyR9dXWf41CpuQQ0QSoXemY
         LMMrZJ/6HyLflj9OTJS2ej1IgXF73bT1HzgMUzVeSK6gCJxojBHwW0y5bEd4LJpnKqZk
         uXTA==
X-Gm-Message-State: AJcUukflkWkNmuX3McsKixW6wAPCuTjze4EnPJPKg4Q+PuBIPk5L34nJ
        p5n9W2zBCROWGALRjYPAscy+Mvd7YO4ha400b1exwCTM
X-Google-Smtp-Source: ALg8bN7cwYPd/sjJXCWk4wLo8575UX9LJoFryL7x+HSgLJwl+lO1XdsMpGh3lqETAxKY1CKoNPfTyO47VkIh6eLpIqs=
X-Received: by 2002:a67:8513:: with SMTP id h19mr19971723vsd.91.1549181835122;
 Sun, 03 Feb 2019 00:17:15 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
 <20181219232200.GB21283@sigill.intra.peff.net> <CALjAwxg2E_48kQYt1GHkcXvVmaFyPY3PGG9rHZNMp+++UqKfow@mail.gmail.com>
 <20181220151037.GC27361@sigill.intra.peff.net> <CALjAwxjyS5raGbib5KyUPZzS+9UyB1fpCN2fybYoYOctXe7iyA@mail.gmail.com>
In-Reply-To: <CALjAwxjyS5raGbib5KyUPZzS+9UyB1fpCN2fybYoYOctXe7iyA@mail.gmail.com>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Sun, 3 Feb 2019 08:16:48 +0000
Message-ID: <CALjAwxj2oDH8NGoLgoPV_=FZ5yRcS=bCKtsuZ1Vin7o8Y+OuOQ@mail.gmail.com>
Subject: Re: Periodic hang during git index-pack
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 22:59, Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> While using trying to use git to clone a remote repository git
> index-pack occasionally goes on to hang:

On Thu, 20 Dec 2018 at 16:48, Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> On Thu, 20 Dec 2018 at 15:11, Jeff King <peff@peff.net> wrote:
> >
[snip]
> >
> > with each blocking on read() from its predecessor. So you need to find
> > out why "ssh" is blocking. Unfortunately, short of a bug in ssh, the
> > likely cause is either:
> >
> >   1. The git-upload-pack on the remote side stopped generating data for
> >      some reason. You may or may not have access on the remotehost to
> >      dig into that.
> >
> >      It's certainly possible there's a deadlock bug between the server
> >      and client side of a Git conversation. But I'd find it extremely
> >      unlikely to find such a deadlock bug at this point in the
> >      conversation, because at this point the client side has nothing
> >      left to say to the server. The server should just be streaming out
> >      the packfile bytes and then closing the descriptor.
>
> I think it's highly unlikely too given how many good runs we generally have.
>
> >      You mentioned "Phabricator sshd scripts" running on the server.
> >      I don't know what Phabricator might be sticking in the middle of
> >      the connection, but that could be the source of the stall.
>
> I think you're right. I set up a seperate sshd on a different port on
> the same machine where there were no Phabricator callouts and the
> problem never manifested...

Just to finally follow up - this was confirmed to be a bug in the
Phabricator server side git+ssh wrapper and the issue exists in at
least Phabricator versions between
2016 Week 28 - 2019 Week 3. The Phabricator ssh-exec PHP script was
doing a select() that would very occasionally fail with errno set to
EINTR and then going on to cause subsequent git data to not be sent to
the git client. It's unclear why this started happening more
frequently for us but we had recently changed to a faster/more
cores/larger AWS instance type and we also switched to a later Ubuntu
14.04 kernel...

See https://discourse.phabricator-community.org/t/sporadic-git-cloning-hang-over-ssh/2233
for a longer description of the issue that was reported to the
Phabricator developers. That link contains a patch by myself that
resolves the issue, a link to an upstream Phabricator task made by the
Phabricator devs and a link to an upstream Phabricator diff that works
around the issue in a looser manner than my final patch.

Thanks for your rapid reply and guidance Jeff!

--
Sitsofe | http://sucs.org/~sits/
