Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BFB1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 15:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeFTPll (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 11:41:41 -0400
Received: from mout.web.de ([212.227.15.14]:39261 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754030AbeFTPlk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 11:41:40 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPW7-1g2X9C2yNP-00cU0U; Wed, 20
 Jun 2018 17:41:25 +0200
Date:   Wed, 20 Jun 2018 17:41:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180620154123.GB19382@tor.lan>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
 <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
 <20180619205310.GA30710@sigill.intra.peff.net>
 <20180620061306.GA7813@tor.lan>
 <20180620124006.GB7932@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620124006.GB7932@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:OBrkQukzy0vSPiJUJBzFND6ym/uChMRlkPCiPWwNcvcDCxNHcn1
 MLAX8Tsq6JmnaRCcaTZVZEYDYa8G8qeShUAaWmgwl2XirdGeUhiRPXSzV+ybgZ2sundu1A5
 Ne7kDo4Kl3LMsHEHgmZcL1XfY8Vyl6q40Q8kSpa2Em/cV0jLINu/zMnWdOmzUNZkmFq4rCO
 fxUUXkkHv9vayIwMEcc2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qlXS7r6Ecco=:/KDizwDpkAxpBPLqIFTV82
 sz14PsOqBdRAuplzayUoE7+BWg7d4XPMaa3nQ4urKUfcCstWwbgzwIZz+19UnuuFj7SSkCTWU
 v9ZNybGsT3EHBfcYTlUEY9d0wLMZ72lmMvgUpLU9dPzsLRNMYaD0sEHIAAiSt6w2rBQFzGhOt
 LJVuDTm2TMjhE4pPivb4U8op7E5otq0ZcAtuyTxS3X796fnjekq3qeBARbvLR1jL72wQR3meg
 TD6psWEthSy9qWP3mo+80TIH+Y7Coi4YdEynHVGz7JcWk2PDso0vd30zhfiZUkxaLC8mzrS9v
 gIbnRh9dr5EDZ/z3fUbugM/YYg6OW3Y4IGJxHc7sDHrOq33JXQSXF09JrMwuGXwPaO2KrsToU
 1FpUtocqRy7dF3ZwWDanUEVosGM13ZfWMmvdxShpXUhgSguVjkVJfe1613h6LrcHVSVwG36tL
 YOzSBa2hbPX2UInYlg64dpy8j3lj3nx/TxrW7cFSqw6wJEAmM6m2PMBaE+tnbxhFj1GN3F0Bj
 lnQ27b0hT0G1D7AnpU8shBHUsU2vDAuV+4gRcKp/Ru28D1dvDG8OZ8eILbp8hMMQfSz5Wlx7l
 wZI38s3F1kGO4nuEX3CDpvgkAeZv6xwBd/RuL7cZWbt/J3/BMdoeAEOH0acbFOJ9ZS1d5GOni
 PhWYanigK72OGNG+YMmUskjleFT62tDj6GykEKsmgY9/Ji34qVc9LRwKMJS0G9ija5dxjzvW/
 IsuB/K4sFIucJaKQYIqR/39uttFI8aFyUrvumkPlUNMXazQzkQTxCf0hXX8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 08:40:06AM -0400, Jeff King wrote:
> On Wed, Jun 20, 2018 at 08:13:06AM +0200, Torsten Bögershausen wrote:
> 
> > Good eyes, thanks.
> > The "-f -c" combo works:
> > 
> > -       gzip -k fetch_body &&
> > +       gzip -f -c fetch_body >fetch_body.gz &&
> >         test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
> > -       gzip -k push_body &&
> > +       gzip -f -c push_body >push_body.gz &&
> 
> Do we still need "-f"?  With "-c" gzip is only writing to stdout, so we
> should not need to force anything.
> 
> -Peff

You are rigth, -f is not needed.

I was confusing stdout with terminal :-( 
Most often stdout is the terminal, but not here of course.
