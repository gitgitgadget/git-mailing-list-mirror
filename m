Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEAAC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC14E206F1
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0U3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:29:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0U3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 16:29:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so13083947wrs.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 13:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjgxN1w/scGdgxoktQcy9kD/DzzAofEiUmrsMMhbgwc=;
        b=MJ3F4GufRnGZJuVQm63WOqEtPtN3wdo9QPC+clKc5mFf5Jt5ByIM4/VBU+ssgjIoG8
         CruuwgUK+hAvAwgap8/T7CieRzuiODJdXN0k1BP/6TKme6qltC2v02ujmtQB7yfMeQsv
         ZT0WJaII+HoXPV1a9hLm++QWSAXx+gaY68X2S5nCJGwcWEDRZLDS3oL3dUhgSsz0mGEZ
         Nl9Kh9wqwIsf0BD+5Hl8Q1QGhi2ISDr09B7GdPEQ9CAi+Ak/KEpYKzfx+GTFOiTKlSn/
         VWRUAZ9o9q5fvnODEKG4GbFT/aGw4oTgjwtynsnQSSnugwz55CD4PFeI5WvqYyq8PthX
         hRvA==
X-Gm-Message-State: ANhLgQ2RBc6IIUZR7jZqlPXJe/HNnuFPBwZn847O4khStacBIjLusDAf
        oZW326IRmRwt5KWFbaD1U5tZGDKrZ97phZ1PFxdPN9+I
X-Google-Smtp-Source: ADFU+vtAiYXl9LnY8m8BRKmryxgUsSk+iStKksZ2MQYrnQ2qAoXMqUhei5z10ojwfF8l7sxKbOCMACv439sxukN7h2g=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr1252700wro.415.1585340971232;
 Fri, 27 Mar 2020 13:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585209554.git.liu.denton@gmail.com> <38924d9c4994b5bad93cbbd2659666f6b452a89f.1585269773.git.liu.denton@gmail.com>
 <xmqqimipherm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimipherm.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Mar 2020 16:29:20 -0400
Message-ID: <CAPig+cR0rNnVRF-Xei-n2HaxLR=9yF=7aya3mdApaqfEXmcPLg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
>
> Forgot to do the final "rebase -i --autosquash"?

My guess is that Denton sent this "fixup!" to have it queued atop [1]
in response to the review comment[2] pointing out the bad indentation
(rather than re-sending the entire series just for one minor change).

[1]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTpV2n66nYJdQpG0tYCu5f=PB-a9Boa_NNfVaUOshDVug@mail.gmail.com/
