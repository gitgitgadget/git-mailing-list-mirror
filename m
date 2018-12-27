Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0D6211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbeL0XqZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 18:46:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbeL0XqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 18:46:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so19599974wrt.11
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wco7BqkJNjPxuSk/2+x8Htd/DVXZHESzpNWdYRrjlM=;
        b=jVbYuVJGRnZ9BlQu0XvhB1fLhEsnrh0TwIyuhZCdIDP8n9tatpcmaWAD/9e7xNtqJm
         vRkiVLFAdoea34Sb0vnNdvKmaMN98V/w4D0kFZv/q6kL3T3waOcsrZo2XL/fIkOjIR/o
         poYBur2btnsIuMxYP06lO5+OTPeUp7aQM0XQuvmnmPJnJp27x4za5JJnv9XDXFL99BBq
         XZMgL6RHoce8OH/cT+ioD1Xexcnz7E67Fvua/TfL/rtvlp4qiXuged9tMIr74L/nJ8UY
         WScUih88Khg2IDlFp9PhbxdonmWqEf9fFsLtuDRx4wOr3805cg+4Y7YNdwA+eYQowouN
         /Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wco7BqkJNjPxuSk/2+x8Htd/DVXZHESzpNWdYRrjlM=;
        b=BFS2GS7vsC03KdD0I/Ajwk6wQHIW4gLOrvbftc9JAxg5DiGaJ4/VmECFsjDBbGOV1u
         eqP8p7WnBLgNtVgkUmtnlJb5hw31b2l+3U8rK+LNryVz4NUhEMlUgyzMzIYpTMLiP/rP
         gPcVldWOswUCXhUUU/tprlznZnTztTbFyfO2KUB3EoKuFgr1DqI1Wlls1h+tcl1nklOR
         WD60aJ4NMM/qVcelzwySDjwAxHb/OBsxzVig0WzfawxZif3Ho1ttggIfpmiwH1WbilxZ
         AyKvWRBC0wwfvEOG38CkT6hEm7PsvBT750sd/IAh61uEApawBe6pW6J0IMb+O7A19GUp
         Dtdg==
X-Gm-Message-State: AJcUukeh8tyCT7fAX0m8EcAY4sISmj6pUYL1GCmZDD/ARPLhzu/1GsOm
        Iwrk1K6snB+y8f9nw5WnWLwoYVgTxPzGj7QM/+c=
X-Google-Smtp-Source: ALg8bN7gS75tej+0eG6z0LR4lvwOcQ1qrZn2RgbGQSj34iWs3GFKkJHsOs2+H+lDY1w6iJu2uXsEno7l+5NqKw9pMF0=
X-Received: by 2002:adf:ee46:: with SMTP id w6mr24297676wro.261.1545954381882;
 Thu, 27 Dec 2018 15:46:21 -0800 (PST)
MIME-Version: 1.0
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com> <20181218175418.GB31070@sigill.intra.peff.net>
 <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
 <20181219155928.GE14802@sigill.intra.peff.net> <xmqqftukq66o.fsf@gitster-ct.c.googlers.com>
 <20181227162417.GA23147@sigill.intra.peff.net>
In-Reply-To: <20181227162417.GA23147@sigill.intra.peff.net>
From:   Erin Dahlgren <eedahlgren@gmail.com>
Date:   Thu, 27 Dec 2018 15:46:10 -0800
Message-ID: <CAP_Smy0tMe=mq2u6OFBfYzutHvoLETOyRtFEzLVViupjMLVLrA@mail.gmail.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 8:24 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 26, 2018 at 02:22:39PM -0800, Junio C Hamano wrote:
>
> > >> Side note: One of the secondary goals of my patch was to make it
> > >> really obvious that neither the GIT_DIR_HIT_CEILING nor the
> > >> GIT_DIR_HIT_MOUNT_POINT case can get us into the block protected by
> > >> (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)). With
> > >> your suggestion (and it's a fair one) I don't think that's feasible
> > >> without more significant refactoring. Should I just settle with a
> > >> comment that explains this?
> > >
> > > Yeah, I think a comment would probably be sufficient. Though we could
> > > also perhaps make the two cases (i.e., we found a repo or not) more
> > > clear. Something like:
> > >
> > >   if (!*nongit_ok || !*nongit_ok) {
> >
> > WTH is (A || A)?
>
> Heh, I should learn to cut and paste better. This should be:
>
>   if (!nongit_ok || !*nongit_ok)
>
> (which comes from the current code).

Yep, but I think we can benefit from De Morgan's law here, where:

  (!nongit_ok || !*nongit_ok) == (!(nongit_ok && *nongit_ok))

PATCH v3 (just sent) uses that transformation like this:

if (nongit_ok && *nongit_ok) {
  ... startup_info->has_repository = 0;
} else {
  // !nongit_ok || !*nongit_ok
  .. startup_info->has_repository = 1;
}

Because IMHO (nongit_ok && *nongit_ok) is easier to read and reason
about. Added brief comments as well.

Thanks.

- Erin

>
> -Peff
