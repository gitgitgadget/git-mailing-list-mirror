Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6061F463
	for <e@80x24.org>; Fri, 13 Sep 2019 12:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfIMMVy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 08:21:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfIMMVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 08:21:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id j191so4633337pgd.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GIJpBL4KHeFZUSgI7WMpjzi/kpVEGHULwsXBxc8l3gg=;
        b=OHu9xWv2WWzFjzVI846UFdt7ymVSXORm6n/M7s59IK+dOwr3pyH2K9DXyw1FpZPm4r
         g7pYzd9FlqCyDwP+1fguF9ohRBkwBURCPFJPj4gY1NXyXy0MDwrdVIgxwYTMdetxKdD0
         t9upJWnEwhQXDf5Kp2FgWIFDoentAG1U9vtOOriyNdqmMY0RdByBIvviyAW1yT2aiWSZ
         G6z9te76XtUg77m+qVRislTWLIarrH5i/PZUXG19jh2n2OZg8Yge2aTspLKgxYtqJmdB
         rxPVSMy6l5VqzjWTvnSpU9eHvreOSTgNtYikkTuGzQxvvrN7+eb34b0KO17DLzkW57ad
         3iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GIJpBL4KHeFZUSgI7WMpjzi/kpVEGHULwsXBxc8l3gg=;
        b=roG8PvJpzn76qYs7SMxA73yhKqsb24YHkTgufF+BfQLyOt7bazH2HJJ1xCaS6obUQv
         WmFXR53oL7v7C6GLv40wgDOBqeBLkYUb/+zcvXcUbLwCOypLQF5QDMLkSKhqA8Sk6fKC
         MXUXz5A16sO7BvMhxW0gDJHQsjjADPaUcTsFYObzuxArnvthg0CCToKXynoPNj402gRN
         6kz9lShQuSB/f9y+9kPSGY+SM7AI9iGZpHx64lB35tCCD5gSCLDFd1467eJoEuC1tY0p
         7VNOlUeaQQYKKAa1xrKPrrGIOXCR4CiFQ6fe8IinQASYeywJBrE+ps0XFvShOKJKwleK
         27Ow==
X-Gm-Message-State: APjAAAV5rVOqdOZMNXrevbZgL/n1W0BZC/Gn5+owXFNNqeMlhOfrKLSl
        H7Bc3YE30b3GPW6raCggliocv4Oi8CxIoRJKeb8bXw==
X-Google-Smtp-Source: APXvYqwgg8ZJZNm0KTh1LcGD2TKNoI8TbfLBisRGqwIYDCfhhoiZP4DeQFfSUTMsGTnZ40T7aLGU9aOJulHXT+jfsFk=
X-Received: by 2002:a62:2787:: with SMTP id n129mr17243438pfn.45.1568377313073;
 Fri, 13 Sep 2019 05:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567707999.git.martin.agren@gmail.com> <20190913044828.GA21172@sigill.intra.peff.net>
In-Reply-To: <20190913044828.GA21172@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 13 Sep 2019 14:21:39 +0200
Message-ID: <CAN0heSrb6VnG2v0y=xsXjO=cDsM6atwLmZC6GRBLBQE+bSW8LA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Fix more AsciiDoc/tor differences
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Sep 2019 at 06:48, Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 07, 2019 at 04:12:46PM +0200, Martin =C3=85gren wrote:
>
> > This series roughly halves the line count of `./doc-diff --from-asciido=
c
> > --to-asciidoctor --cut-header-footer HEAD HEAD`. Together with my recen=
t
> > (independent) mini-series [1], I claim that Asciidoctor 1.5.5 now
> > processes the manpages better than AsciiDoc 8.6.10 does.
>
> I looked these over, both source and rendered output (both with asciidoc
> and with asciidoctor 2.0.10), and they all look good to me.

Thanks.

> I think the delimited literal blocks are _slightly_ less pretty than the
> indented ones, but this is the solution we've been using for cross-tool
> compatibility (and I think it's intentional in asciidoctor to deprecate
> the indented blocks, because there are just too many corner cases). The
> delimited ones are also easier to write correctly.

Agreed on all of this.

> > Patch 7/7 has an element of black magic to it. I wouldn't be too
> > surprised if I've managed to appease my particular versions of these
> > tools while not fixing -- or maybe even breaking? -- some other version=
s
> > [that people actually use]. That's where I think a quick test would be
> > the most valuable.
>
> I can confirm that asciidoctor 2.0.10 has the same bogus output there
> before your patches, and that 7/7 fixes it.

Cool. Thanks for testing it.

Martin
