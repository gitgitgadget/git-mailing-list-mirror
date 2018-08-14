Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAE01F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbeHNRSB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:18:01 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:37501 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNRSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:18:01 -0400
Received: by mail-io0-f178.google.com with SMTP id z19-v6so18395894ioh.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n48vCopQfcuuzXbO4RKDaop4DfQLGTmqj/fjoRzfvVY=;
        b=ArX3p/WpA1sbcO+1Whq3IazU47poda9C6nZgWt+lpa+0YmUJCeILWaw2iRxzTBY/6P
         wccWOywW0uRVNlRZ1s2JaXvshIyi68I4xMIIQyE2Y+2sGQvv+eGl6PEfUKNX9PtIQA9M
         UNa1dGsR9flK28AWUF6bfn52zVXYz0ZEd31NB3tg+K8iJvo4nCJXpdu+/MqxFkK2oXjC
         sL8V1v889Q2sKExqWplRzO8WiLzNOPGj2hpadgKGl18mRqULSUN9afwUhFtGA9IOXstj
         Xuh25RqJw94Ex+qLZMHA54PGAGaY4Ie9N3Jdrbpgzn8PuUByZ5VSaofO+nrHQX4sKrEL
         tM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n48vCopQfcuuzXbO4RKDaop4DfQLGTmqj/fjoRzfvVY=;
        b=pGJOxFaVS7H0uq2Qzhn6GTNEEb8nRPfdEP7dkuyvLtsZJVN7BxczLYZjWgnKavM2+U
         Eqq774XpPPvSIEHKHQBsJKlZo5sK+SiLTKKxMRNbblXxTOP2ItPAu9bzUYG2vnMMOGbW
         lW83YI2PjaIOUf3MPk01HTQ9r8u8NNHdqbyIsU+6RIuw9pelMtRwRj/mLjBTbGZmn5r7
         rc7mnT3AsdEkk7vU8HJRyYf+/1IyMjvSWuHsiRt9OxL7+iI9ELgAYAHGGmq8ae9F/UUv
         XRkJI+BKbZFEyo+/dRxkVpdN9UnRhMc6SdykFPnb5oDf3kKShQRCaO2Kp+bCYHSC7Rsw
         QPEg==
X-Gm-Message-State: AOUpUlFohW4kgzzlnrgYjy9dUtxq1Y9nUro/tcw3zkdhlezDWOwn6Yox
        JuzYoCkc3vYp24VyV0T7K7tfhEDI/tiD9dfGZz4=
X-Google-Smtp-Source: AA+uWPyEDkgNhYlyFq+PvBhQUPI3jPD4HcTbQ/wcU4YH9w1DuTJf1aFLrXLpiJ+X79EdbpuMZZ81rUALQ498FB8UFE0=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr17028865ioe.282.1534257036211;
 Tue, 14 Aug 2018 07:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
In-Reply-To: <20180813210617.GA19738@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Aug 2018 16:30:09 +0200
Message-ID: <CACsJy8Dbf6+ZjLk0vgYvzhwweOdp+5QTno+ejoA-r2YYsdpzrQ@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:06 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 13, 2018 at 01:41:51PM -0700, Stefan Beller wrote:
>
> > > Oh, using "git shortlog" might be also simpler ;-)
> >
> > I guess you'd need to memorize a different set of flags for that
> > as without -s it would be harder to parse than the oneliner above.
>
> I frequently using "git shortlog -ns" to see who is active (especially
> coupled with "--since=".
>
> I also use "--no-merges", because it makes me look a lot better when
> compared relatively to Junio. :)

--no-merges makes me number one. Not sure if I should laugh or cry :D

Going off topic a bit, can we count the number of topics of each
contributor? I could do it by decorating git log with remote refs from
Junio's repo and counting based on the two-letter prefix in the
topic/ref name but that's too hacky. fyi Jeff you're up to  second
position now with 34 topics (I'm unfortunately still the first with
38).
-- 
Duy
