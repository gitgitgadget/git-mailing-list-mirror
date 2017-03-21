Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1CF20958
	for <e@80x24.org>; Tue, 21 Mar 2017 06:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756539AbdCUGQ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 02:16:58 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55611 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756485AbdCUGQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 02:16:57 -0400
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 565BF1A1FE3;
        Tue, 21 Mar 2017 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490076333; bh=Rd5jVTIJrFmsVhxQgexzPMNHJntgHbpI8X69y6rDSzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6ABCNW1vaV/trBwj7nCazkcoW97hs1H/EvIYn2IamkEe3iasYm7RfiWIfKHHlPa2
         uASxLYV/jpnqGdZCkkd7nlj+oxLIWhC1hY/9wrwpCkOXvFrLHLDrguIh8KUogWFk6i
         jKTlSBxbmdrsPZPWKEJ5VJ1JJFfgvlZAPr5dmk/w=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id CB3E2402DD
Date:   Tue, 21 Mar 2017 14:05:26 +0800
From:   Ivan Tham <pickfire@riseup.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: Re: GSoC Project | Convert interactive rebase to C
Message-ID: <20170321060526.sXz0cdJwc%pickfire@riseup.net>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
 <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
In-Reply-To: <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
> > I am Ivan Tham. Currently studying in Computer Science in APIIT Malaysia. I am
> > interested particapate in Google Summer of Code 2017 under git organization. I
> > would like to attempt "Add more builtin patterns for userdiff" particularly for
> > shell for my microproject.
>
> I'd love to see proper shell support!
> Although there is already some support for shell (by looking at diffs
> on our test
> suite) ? So I am not sure what there is left to do? Can you clarify what you're
> trying there?
>
> > I am interested to work on "Convert interactive rebase to C"

Are you sure about that? From what I had looked into userdiff.c, there is no
support for shell. There just a recent patch for [go patterns][0]. Or perhaps
I should have rename it as "userdiff.c: patterns for "shell" language"?

> +cc Johannes, who recently worked on rebase and the sequencer.
>
> >  aiming to port
> > most builtins stuff to C in which we can reduce the size of git. Additionally,
> > I would also like to convert scripts to builtins as an additional milestone.
> >
> > What do you think of these projects? Would it collide with
> > Valery Tolstov's Shell to Builtins proposal?
>
> Curious why all people ask about colliding with Valerys proposal here?
> I do not think it would collide, as submodules and rebase are very different
> areas of the code base.

[0]: https://public-inbox.org/git/xmqqk27jvg28.fsf@gitster.mtv.corp.google.com/
