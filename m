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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEC81F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHaUnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:43:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44521 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaUnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:43:35 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so15179346qtk.11
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SFkofSvpW6WLJxUEIaSXsxL40U/nr7IivGZsV2Zp7d8=;
        b=GI5BwYMNO9eO8M2kB1UzevOQE1VFJQ4zDCAjBxzTKwkPHexlllfYUkmW41twu27PrA
         VqMK4F+LOiAqx8diy7JVS46fUgZBjtvFfadP+hsvZNq1MIV5elHVQ9Wu5FxlXHNfz/78
         W0ZnehGEMUmoZ+gXRMx1tBpnOf6K2rM+SN7nTHu3CqPtJNRBcrtPqkVwt32w2oEI0LjF
         dEYooHXH4my8ygXmw/5w15Tt6QQ0ze6H5kr7jf8lHwSdk6c+ar9GWQK5EIHar4GUwN+0
         fOxFYD7RZdxXUacwheCmjuybBQECOsO3pXOHBiSeRa6cJERxpsfhqvJr94EbVfCIb9WB
         inFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SFkofSvpW6WLJxUEIaSXsxL40U/nr7IivGZsV2Zp7d8=;
        b=Fw0nMvsZc/VuDKgZu3dkOyxq7jEk015onX/9iZBNi7hQVamGBgtGXTJNpy/qCQcIso
         Tq3DMBbJLSl20N0S3bxQ64U2eIfF8M+lCx8tEubtpUGkxAAvtD+zw7QF1PB3bETTXnH1
         3O65LejmBAmCiT8hPgCm+BJ1R3UQ2M+Q3QscdvOCcqM2CJFSliUZW2+Lg05vDeDSX9oH
         52jwXrC+jXa0S9yodOLTNiH29zzj8Oyb/ujYTh7akOZuSKyohtr41kw9qKxkNDrMx65m
         y2hADfZCHyM53yIBCV/svSqnVrSP5j7khL2t7hDtIOnejcvYFzLBR0HVb4AFW8P+qjTT
         XVIA==
X-Gm-Message-State: APzg51ANcjp8Nl/088q83OnOfRk8t80hUUShPm6uff6ukopMdX/Yn5zW
        NKXKSH8L4Ml2PpBBEA9wBfP2Cdv8NBfYhpogaTU=
X-Google-Smtp-Source: ANB0VdYadt6oNzmyg3OoIpnVpKNavKPC7zll6J5WicZ4UrdCBTWLjGDug9Iqe2EGXOkyxJvQTnLRMJpUEnHwyqqaBzg=
X-Received: by 2002:ac8:5191:: with SMTP id c17-v6mr16840261qtn.35.1535733317330;
 Fri, 31 Aug 2018 09:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180813192249.27585-1-avarab@gmail.com> <20180830201244.25759-5-avarab@gmail.com>
 <87efefcwme.fsf@evledraar.gmail.com> <xmqqd0ty33nz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0ty33nz.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 31 Aug 2018 18:35:04 +0200
Message-ID: <CACBZZX7A79KRMprLUaYbSrECBsdc2_4EF0WqhcOmU26cWvoYBA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] push doc: correct lies about how push refspecs work
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Thu, Aug 30 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > [Notes to self]
> > ...
> >
> > Later below this we say:
> >
> >     Pushing an empty <src> allows you to delete the <dst> ref from the
> >     remote repository.
> >
> > Which, perhaps given the discussion of deletions as updates, should be
> > mentioned earlier in some way, i.e. should we just say above all these
> > rules that by "update" we mean non-deletions?
>
> You raised good points.  The rule that applies to deletion is quite
> different from the one for update, we want to make sure readers know
> updates and deletions are different.  As the rule for deletion is a
> lot simpler (i.e. you can always delete unless a configuration or
> pre-receive says otherwise), perhaps it would be sufficient to give
> the rules for deletion upfront in one section, and then start the
> section(s) for update with a phrase like "rules for accepting
> updates are follows" after that.

Yeah, that was the plan. I'll do that.
