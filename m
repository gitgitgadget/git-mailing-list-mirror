Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477651F453
	for <e@80x24.org>; Tue, 23 Oct 2018 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJXAK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:10:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51089 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJXAK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:10:58 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so2450470ite.0
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONdXJC3d5t4fQLlGKEOov9l6xZZjFGyikJDiSpmvUCE=;
        b=P4GdqqMIybiIt/jif4PFUYvUsM3OWRjsKZaM8UPRts3tAwX6j2iLhF8+cb+gyxJrh6
         FymQtF6hIaPw97lFTDdRSwZ+SZaVxDTgYtO7honQiUdBh/ds1hbvdsEzOz3muqwpjl/5
         fpjm7oW0V9/mLq+0r6xX6GBncdqYCpHbaFrcGDn6cyTUGFIK+TSzHsVL2qLtAdUjpVz2
         dpbOU16q2HwU4ocaRQbjGCkPirqE2+vNcCM+Ug2GswY95My6gKnWTTxQeku2EHseziEI
         ZqUxBNCbw+Dq4w0O92cDQVjrQk2duogMnrWAFhgcCc7qentQ8ydbeKRx8xRypmI3nTfM
         ZK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONdXJC3d5t4fQLlGKEOov9l6xZZjFGyikJDiSpmvUCE=;
        b=js4QNdLSggJprQ5Dify9I81NkyCLlygs/ntLIXYyMa0bBBKrxvcK/auU1m8UWXAgDO
         QGfxH2sx+vTWq7/ZY85SHsNv65Ijz6qwO6NHd2yWk3hfuzpe72nDt8qdh+SuVZpCzk1f
         YoXGzfHN3bNy1pn0OupofkxuMmYL4Ipaow3JB71QoZLVCx/1zpWDwLHLWynjMuF1YdYh
         st9VFG0JGHdoDi9tkOYrDvp5/lAcbwrpFkcQ5llNwqSHGyfCrYUThW2IUMjkfLV0tiFS
         S+RhM5Gw1XrogXMSHaPh18YoVZseCmj3jYVdfXTEvnHd87avqzdzlKmIpHrg97KPEgBJ
         Ni5w==
X-Gm-Message-State: ABuFfojJno5sikRkfGJXRPi2UG3nxXu1LxqsZRo+z9C7VBS/Tu9YT/aT
        LdlhbxM4yGEMqZ1Drzgmp1lIC9t0Y0mr7uJgw3x/XA==
X-Google-Smtp-Source: ACcGV61NlznkJspM8TDKHFJknm+BPPr02H2teltNwBXDJwRJ252BRLTlO8q0HXX4fj7Xqa2t4qB586n67SVblyRyMmc=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr12890151itc.123.1540309621929;
 Tue, 23 Oct 2018 08:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-2-peartben@gmail.com> <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet>
 <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Oct 2018 17:46:35 +0200
Message-ID: <CACsJy8C+9f3hFxmrqAN2hi1AeBTa1yZdnwX6iJtsy_OrEfTWpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 1:01 AM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Sent: Monday, October 22, 2018 4:45 PM
> > To: Ben Peart <peartben@gmail.com>
> > Cc: git@vger.kernel.org; gitster@pobox.com; Ben Peart
> > <Ben.Peart@microsoft.com>; peff@peff.net; sunshine@sunshineco.com
> > Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after
> > reset when --quiet
> >
> > Hi Ben,
> >
> > On Mon, 22 Oct 2018, Ben Peart wrote:
> >
> > > From: Ben Peart <benpeart@microsoft.com>
> > >
> > > When git reset is run with the --quiet flag, don't bother finding any
> > > additional unstaged changes as they won't be output anyway.  This speeds
> > up
> > > the git reset command by avoiding having to lstat() every file looking for
> > > changes that aren't going to be reported anyway.
> > >
> > > The savings can be significant.  In a repo with 200K files "git reset"
> > > drops from 7.16 seconds to 0.32 seconds for a savings of 96%.
> >
> > That's very nice!
> >
> > Those numbers, just out of curiosity, are they on Windows? Or on Linux?
> >
>
> It's safe to assume all my numbers are on Windows. :-)

It does bug me about this. Next time please mention the platform you
tested on in the commit message. Not all platforms behave the same way
especially when it comes to performance.

>
> > Ciao,
> > Dscho
>
>


-- 
Duy
