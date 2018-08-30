Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E491F404
	for <e@80x24.org>; Thu, 30 Aug 2018 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeH3VCv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 17:02:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41300 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeH3VCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 17:02:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so11035919qtc.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cWqxjYcocuJHqrMPgukgyoW1A/19FSvHCA0thfBsWMo=;
        b=Mc1+nwi+9BU10bxyURgYi8uc+EmQpzzB2EmwHZPnS/Ppn8d8rIoA7pz4up2DpOBh45
         AVlpYmhjb4rQ6MvpWYafdvisBt8qRb6WCPpr/IrxTDc9Zi0p7mhs8hK94XQVWrKwLbV+
         +zxpLJZrf+7qOEGNrd3XteIa6puO887X1TFOoyUcAj58ymYdKsTqd0+bQB86sxcS/D4z
         PFj8Mo6BzB8bcbAyeswgIirG9mHbY6fy6+O6JtTmp2kFP8DzvljAtviFGu78zxEze2Ja
         l1zYyKEHc/4LwNbHOcl855iOTeH9lpnBvIGoHhcOdplBwqyaN8G79Fmw5rl/GZSgzG6e
         GtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cWqxjYcocuJHqrMPgukgyoW1A/19FSvHCA0thfBsWMo=;
        b=GgHbg5JXxtkAv+6BXrxE+ngzn70opq+nDhWr7HmdJklKItP2Az3JLAtw7NbQyiqN+g
         NFdczalhhmsDkFQmV/pB2WY0vjUkYVmQVO+1kxSUa1Mq2DaT9oIz+Z+MdEZHQY3QbpC6
         zTTvc1PKPbS696xBPmYCzxA5P4O9gtkpNt0NW5q1u1AZZVP2ANQONjImu11j1Six9KKo
         kEsXvniBeGfDTmBnBo4GCsCUE8v1ztIAiIM0ESKkDl8GEoRpUY1FTFmZgH7BL1An19/W
         1WL8OdmAP15bvKTzsG8q1NBETitJNVQsUxwAYlgOU5DZ7AUCTCUjfvx+hueOSut3+RfU
         GWSw==
X-Gm-Message-State: APzg51CWnODMl3LtHT3SDW6nezdP9t2fgUX8jVhkJwORjCiNJ9mQa7Sd
        rCVhmfWqAt6f4V7lOBH3SFRzodyv/Yt36BWWqPE=
X-Google-Smtp-Source: ANB0VdYElzUVkqarGuixYndf9IOD1c3GN/feb+Vpvput5sXCiuIpBfg4Sj9iC3O1oZxzCJI5E42A/HI0pGNGzhgB5Qw=
X-Received: by 2002:a37:10d1:: with SMTP id 78-v6mr12261737qkq.72.1535648386230;
 Thu, 30 Aug 2018 09:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180429202100.32353-1-avarab@gmail.com> <20180731130718.25222-7-avarab@gmail.com>
 <xmqq8t5rcnhg.fsf@gitster-ct.c.googlers.com> <87o9djdi0c.fsf@evledraar.gmail.com>
 <xmqqh8jb7uax.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8jb7uax.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 30 Aug 2018 18:59:34 +0200
Message-ID: <CACBZZX5FmuctKaE6Z3O-Mt6X40=RpCGUaae3AGhrSrTwH9AMhA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] push doc: correct lies about how push refspecs work
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 5:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > I.e. the non-refs/{tags,heads}/* update logic treats all updates to
> > tags/commits as branch updates. We just look at the tag v2.18.0, see yo=
u
> > want to replace it with the commit v2.19.0-rc0^{} and see "oh, that's a
> > fast-forward".
>
> In my old message you are responding to, I asked what you meant by
> "will be treated as branches", and after seeing "as branch updates"
> above, I think I know what you want the phrase to mean, namely, that
> old-to-new transition requires new to be a descendant of old.  But I
> think that is weaker than what other people (including me) thinks of
> rules to update refs/heads/* hierarchy (i.e. "branch update").
>
> You are allowing to store an object that is not a commit in
> refs/blah/my-tag in your example, so it clearly does not protect the
> ref with an extra rule that applies to "branches", namely, "it has
> to be a commit."

Indeed. This was all confusing. I've reworded in something I'll send
shortly, which should address this confusion.

> > Arguably that should be changed, but I won't do that in this series.
>
> OK.
