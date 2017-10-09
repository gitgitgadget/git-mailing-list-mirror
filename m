Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670A42036B
	for <e@80x24.org>; Mon,  9 Oct 2017 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbdJIJEg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 05:04:36 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:55991 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbdJIJEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 05:04:33 -0400
Received: by mail-io0-f178.google.com with SMTP id z187so20580338ioz.12
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=h/N4sm1h+cB9R0N8lslztG7MJZZDxDnnMSmjWkrlvi0=;
        b=KCtn8fil1PI1NtZIWI0nwss46pwmTvljX/01IAap5FcuiaAt1F608WANVYdbWnHhTL
         /uHUsUkg6St775bag4JVnwh9IV200SFb+XNSJbOFKnNadCSlX7nb8OmHZmoTou5NUNKV
         cKEdiMj3lUJIjUAnLDGJVQGHyFtyxYygHmcnPtI9jOyRdFzXkDj35sTtyKxP5HMlyn2D
         9o3R3ChzYo2d10pecO6E5IWkGju4D0LqDD0vkK4sSe5clHoAJ2eKEj1hKmscn79bbdTz
         9yX55a3HD0maSK8uLhMPfL+VV5zreKW9nI6B+A2z8EuWL/c8xfA+lm9DlPnr3/CmipIP
         niog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h/N4sm1h+cB9R0N8lslztG7MJZZDxDnnMSmjWkrlvi0=;
        b=hRWzzX5U5eaC6Bm2BB5aaQWNdliiR8DYYYi88x71RjAuESKx/p8BZRc5gFdCBLpTW1
         aCcnZ+xg7zirtmqNShxqpWTmUw5dBUNfq7okoxXzUH6i0ajN1AopaReYfs2achgG9/y9
         oxgBuwVcKkr3TYCAUgYVtJq2x1Kq0wh1PnWLo2xJgpa524jj1gjvjDh343vjMLRsx+Ks
         sHLN6YF7STxOhWi+wkAEtSO10D4WhvJJXd3YDcuHFusQvbQdW3CSD9+n04S7vH4JhJl8
         mS50bTHOizSC5Lgj9NE3GbG3tN/aWLs84SaujoNMnEsv+aeDW8GS+hWNyJ67tO1YZrHF
         XeIQ==
X-Gm-Message-State: AMCzsaUfd3u/8WpPOSAB6AjIGpReBVEPwqoUoJEYfsqf9eBg0Zysu3Uy
        b15mlOLrPWMPgM7QdWKHC6Tw04g2ermpCgFuMvgvEw==
X-Google-Smtp-Source: AOwi7QAhx6e4518d+GM+BBNRLHtoQBpmaWc8rW6rp/5WsxNp2QPuLg8SOvwcYOHeHm5aMRdqqfXv4FkqbTZVkb4c4X0=
X-Received: by 10.107.137.38 with SMTP id l38mr1753804iod.138.1507539872399;
 Mon, 09 Oct 2017 02:04:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.198 with HTTP; Mon, 9 Oct 2017 02:04:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2017 11:04:31 +0200
Message-ID: <CAP8UFD1f=sXnnUS1kmBBdfdhE3ugZ91RtYXgsTjSQhuQbBt=-Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 32
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Andy Lowry <andy.work@nglowry.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Marc Herbert <Marc.Herbert@intel.com>, Eric Wong <e@80x24.org>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-32.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/259

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday October 11th.

Thanks,
Christian.
