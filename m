Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1BC91F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfI3VXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:23:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41779 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3VXx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:23:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so8156863lfn.8
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2VbDKLBc4Rv/8z9HcPg1eE+KfK8a4wa3vxlMuUOKy0=;
        b=A2DEQLsygbnYThyzy1p4gfTCKquNW+wEOih5TwDxM0jkSpt1GgCAhj0abkvaTsbXRX
         A3aZ/ld+3kKSjgs2oSwJY/AegeJICBwYMXSaiBv8Bb5SEm1vyJtSVpOUu2M1kflHDuuZ
         qHnC4hkshK6AmgC2yGYXHFnrHg/11lLlEeRL/5Jxuv9vONer9Rvx+GiK39B4dwIAijcF
         UMNPnwkJFcJD8LPW+0RsEdzMR+WT46o16NpKoq6lXw+OhE/EwSX29PrviarcD5UNpg/t
         T30nktqEOdI0HAYrsF+Qvi2BaL5WPt/CmSooGMcXB1Sk2fDOuUOv8MHyGHDDTONwBgUS
         LvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2VbDKLBc4Rv/8z9HcPg1eE+KfK8a4wa3vxlMuUOKy0=;
        b=P3jWKRdyv4+8Y8obb9vBHswExwyNovAEGKXnJCjRaOoKrDUTNBG7HR3H797R0g//wA
         Ph97ZcoNatbF395bNbZBkJBHDLhyDH6Bznsi1ohIS4uVyRIZp8vGOXKga4tpcQj86uZO
         3CH0tgdcRQugxwnowUwGG+bKec9EF45jWMTK/xXhLPsDwZfCuyYv7XetYw25rd6B1h+N
         tJ48SJDuqo0rh29z9f6C02UiXb6POEs5+rjAeURjTCvhSM/PoL0lxKEqtosltsRTOuO9
         OHX5bBQ/3WwV+UU+k83y9Lhrh3LFGsMNxlFlaJmFViBqp+Od+UvnSlIOboIUNGI5yszU
         pLYg==
X-Gm-Message-State: APjAAAW/4AH+Oem5MuzpYODGMzGFlWcdo5hhFPGvTZVUxviLHtmNzxoW
        g4NkYvuXRRb8lsICHnp62XSC+7t616GQ9Yjks3b/Q9A7
X-Google-Smtp-Source: APXvYqxZN/OvuOrPxTAGUgdntrQMDO7ofGOA+njJ4fsZRKGwEzWAlKerBUpNt7E4WEHddRoSmFjA0IhChbZTGvzaVW0=
X-Received: by 2002:ac2:5ec1:: with SMTP id d1mr11831075lfq.83.1569865018330;
 Mon, 30 Sep 2019 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190929204322.1244907-1-alexhenrie24@gmail.com>
 <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com> <CAMMLpeQLXN=jvD6MSJPdUTr60MiKdQq=zHFQ7aiatFuhqX1aeQ@mail.gmail.com>
 <xmqq36gei07z.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36gei07z.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 30 Sep 2019 11:36:46 -0600
Message-ID: <CAMMLpeQps8jvgpBXDnzqeeSsH7RA=__XjnDb4p_4SdGB-G2mSw@mail.gmail.com>
Subject: Re: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        CB Bailey <cb@hashpling.org>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 3:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Well, I admit that code clarity is somewhat subjective. To me it's not
> > obvious that "if (q->nr <= j)" means "if the loop exited normally",
>
> I actually do not have too much problem with this side of the
> equation.  I however do see problem with squashing the two diff_q
> calls that _happens_ to be textually the same but is made from two
> logically separate codepaths (cases B.1 and C, in the message you
> are responding to but omitted from quote).  After all, you did not
> even realize you introduced a new bug by doing so before CB pointed
> it out, no?  A rewrite like that that easily allows a new bug to
> slip in hardly qualifies as making code "more clear and readable".

Sure, let's keep the two diff_q calls. I'll send a new patch.

To me at least it was not clear what code is executed if the peer
survives. The fact that I put the goto label in the wrong place the
first time only underscores the difficulty of understanding this
function. But with a goto (and with its label in the correct place),
the execution path is obvious.

Thank you for being willing to look at this code with me, and thank
you for your feedback!

-Alex
