Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F371FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 11:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdFOLoA (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 07:44:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33126 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdFOLn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 07:43:59 -0400
Received: by mail-io0-f195.google.com with SMTP id j200so1612876ioe.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r9paJ49YlZid9cbnoPvZ5U9zwlyRemLcxrOb/dl4/lY=;
        b=l1pDU+EmZVMN0KDiWLdUPHXYmCibZvz7CAdgmab/P5DFQkI/WB61vLHXa8PCtYbT4m
         cnBd3hN0m/xJId6GJVYAjAtv88mquCGQSHgVLY+OKsvt2vhsfKB49oL08B6dh5zile45
         UsRwNMcpNWuadZDQwyOJqkPzRUOjzSu9id5ufyYvIiwWo2inheTDjjn/SGDJvX7x9jfl
         aissYGjhONapPFSeUmNXVCKlXhYhaeH4292gL0KgThsy92EzQdE237fg6O7LXh+EmFk4
         5nbd1yk2UgpWXsu3J8VZ2lWNzsRBRI4tZwNu8jr5KHgQoEQNqDwRtBxpMr/gSWJT2/2K
         aAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r9paJ49YlZid9cbnoPvZ5U9zwlyRemLcxrOb/dl4/lY=;
        b=kpL30BiptUtT3k1w/ZA19TDs8nnVB9OZHHMwUD62jA0TFP+80DHsMHRAzZPcyCyY30
         9M8jEnsh5oj/D/KWb5k7g41cgPKCOPy6VwmNRxYvlM1/pRGYqCXFdywnfWCO2C1vGBQt
         0SxCX2VwQkfWLa4hFg8WnBFCW4TbS0TiOCSAysLUbrnWNH2diPlX5ICN8IrwMP80CASj
         4oKAEQmrhxFmAoob07vNYP/RSkFDHBkHLWnRMlikUtzsBYMFnM8XChPPGqDKGqThh2yx
         1kYuXA3HGb2gqVI5Uc3sfu8euK0ZG93UCLXvJVrlsbHv4JsBjWRdzbFmOITcORQ0nPm/
         Nukw==
X-Gm-Message-State: AKS2vOxjIanOrlJruvZ2Y/1QUnBtHLZQWSrimxzKtofJXFkNOicrmQn5
        lRmLsBHQGqV9lguhC2TOpntZM7elpg==
X-Received: by 10.107.181.22 with SMTP id e22mr5189733iof.85.1497527038500;
 Thu, 15 Jun 2017 04:43:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 15 Jun 2017 04:43:17 -0700 (PDT)
In-Reply-To: <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
References: <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com> <1497084241.8531.2.camel@gmail.com>
 <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net> <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
 <1497255003.1718.1.camel@gmail.com> <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
 <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net> <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
 <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net> <1497514760.2394.6.camel@gmail.com>
 <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 15 Jun 2017 07:43:17 -0400
Message-ID: <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 4:42 AM, Jeff King <peff@peff.net> wrote:
>
> On Thu, Jun 15, 2017 at 01:49:20PM +0530, Kaartic Sivaraam wrote:
>
> > What about, "not making any assumptions" about what the user would
> > think when he views the output of `git status` ? Why not try some
> > general messages like,
> >
> > * Staged changes
> > * Unstaged changes
> >
> > instead of the messages such as
> >
> > * Changes to be committed, Changes already in the index
> > * Changes not staged for commit, Changes not yet in the index
> >
> > which seem to make assumptions about the user who view the output ?
>
> Saying just "staged changes" is definitely accurate. I don't know if
> some users would find that too terse, too. The phrase "not staged for
> commit" gives more information if you don't know what "staged" means in
> the Git world.

Perhaps there should be a message pointing people at documentation
explaining the index and staging terminology?

Offhand, this is something I was wondering about the other day - has
there ever been a discussion of what level of proficiency Git expects
of its users?

> -Peff
