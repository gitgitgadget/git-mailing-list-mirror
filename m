Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984E420A17
	for <e@80x24.org>; Fri, 20 Jan 2017 00:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbdATAOV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 19:14:21 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34486 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbdATAOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 19:14:18 -0500
Received: by mail-lf0-f65.google.com with SMTP id q89so6971286lfi.1;
        Thu, 19 Jan 2017 16:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nWrugYGIZ3ZoUaESUvwZTxghaCpRToFboljwcsL0Foo=;
        b=RgsxFclNtY7LQaPnIXui3DMXTgyonyWiSNhp5OYuzWutsEjl+mWFARxCFkMmJEK0p+
         2FvrYjknHywN/ASDFZsWFO9HPC44G3BpHQ3b+jVFg63BlEXb2RE7NshwC8FGh7GNTtgd
         YuQifeODM4EjKiBepH4S5HUl6vGZubw3DLWA1Rms8DbTWSmtWwURKZp4adt6W3Zw3nTR
         DpUr8iLjdrJ9pS4PX1PMERr63k/Y2i0fiTJjswf3UzbQ45WNbWWTOpxP5cARTiI4co7u
         9dUtAaGnjccIVZa6IWpaAgnurgb72r/br6GBo2XAcqFLMJQ1x1OWY55EJ706oPFnl3yv
         1sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nWrugYGIZ3ZoUaESUvwZTxghaCpRToFboljwcsL0Foo=;
        b=O6/cxD7Cu7lvGvtPPQajDpZqgIGeAirKtj4fBZRjFvCbRGLJZ8e6T+7X+7lBC/aS2D
         6GB7J8m66F/5wNM9pyPIvcG1nv/ib48Cjy8g/ANenqZBY4YbnbZp9vbJ+I/70f/xZ5u6
         jUfSuGOaTeL6mhe3iFqehoHmqRUmEJdEtUoLjoihQ6MOraAeTvo5m/0Mq83kSbsVsfUw
         ZwwnT78Rm4SVNmXBm0c8E0UMft4oXoIuRb4CvkP9+hl27TeC8iCxusfygK3KOMaIl8Gp
         IBQY4MifRkK7O3bpkS0uIAhkP1NmNClFHScoG65+sa9j/cJL0fUlwJOqJS3g7wFf2Ugv
         VFcw==
X-Gm-Message-State: AIkVDXIR0jlpd8piQ6okd+8H4Acye1VJSWvWdZSYpFf9ytAt300UyUeAFs6xMxt7fij7SpV8Rno394sGPDxJ7A==
X-Received: by 10.46.69.215 with SMTP id s206mr5692010lja.26.1484871216331;
 Thu, 19 Jan 2017 16:13:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 19 Jan 2017 16:13:15 -0800 (PST)
In-Reply-To: <1484870777.2707.2.camel@perches.com>
References: <20170115183051.3565-1-wsa@the-dreams.de> <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
 <20170119204343.xtotmjddhbum2mvr@ninjato> <20170119212039.3gixsrk7qco45wjo@sigill.intra.peff.net>
 <CA+P7+xo5N66a8-PeNRLBgwRN3rJZRbQuDnx8wCnW7L-0tz10Fg@mail.gmail.com> <1484870777.2707.2.camel@perches.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 19 Jan 2017 16:13:15 -0800
Message-ID: <CA+P7+xo8rZT_C=guKZYg1smRa+poh5v6a91xDjn=BUukgf-bXQ@mail.gmail.com>
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
To:     Joe Perches <joe@perches.com>
Cc:     Jeff King <peff@peff.net>, Wolfram Sang <wsa@the-dreams.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 4:06 PM, Joe Perches <joe@perches.com>
wrote:>> This sounds interesting to me! When I have some more time to
take a
>> look at this i might see if I can revive it.
>
> Can the terminology please be standardized to what
> was once called bylines?
>
> https://patchwork.kernel.org/patch/9307703/
>

I am fairly certain we've settled on "trailers" at this point. I don't
have an objection to either name, but most of the code today uses
trailers.

Thanks,
Jake
