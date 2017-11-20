Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478FD202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdKTRZi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:25:38 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34206 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbdKTRZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:25:38 -0500
Received: by mail-io0-f177.google.com with SMTP id q101so16499857ioi.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JpZwasqHIIj9LUXT8d75rh3dY3WE/5kK5/mEJgOjgCs=;
        b=QELFZ8UylBMTnjrcIL+uacBG5Vo4gu+K9j3mBnA7h2r+Cp/z9tmk5A0Q/3mm7B4eKq
         IUukLWsmu1sABnrGEkK+Mgl5GvvDahtpLYR8MJy2ARb2m3sbp+h20WkTmGdWSIws1GEg
         uvXry5GpERpiSKgv+4UiCL2lMjRRCTPkKaY3zmESw6U/Xa9bUbIQmUyuM21ho5e3L1ao
         LISLdYSDX3QmEE36hppKgZ923471tQSwBUFT5wJfMCO1de1A/19Rz9JN/D6tjg7ddnph
         9JHaBJuEj7PcJN5G8nDrGNCqQf3F2h3+Ct0Reu8pV7AxoIkjw8M5zIw74G0tQbu3xmHN
         8WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JpZwasqHIIj9LUXT8d75rh3dY3WE/5kK5/mEJgOjgCs=;
        b=iVa9vK9VBhjGVZ6y9CU6qW6w1k18D1F7vKxYhX4giyp5CMzZ730mjQ3GHYcUBhoAud
         vq+anHK3hJ13aVmeVA5LiSOK1dnAururFghhhR1bwpbItjhkyO7GYxD8IeyokoB9J4a6
         5goPPuBlYw6mHguhLrFg39C650qjdKFf2XHy4Ru+nyYQfsBCjKzAB1+F4MwQDXcIgbzz
         2YQYnlzSQ1ofJjxIDAIkPaDwmOrydqwE4Ga1YUBKzZnVvhWHcH/a0+Emi3OtQ6yyE62Q
         7nfNXC5/aIR+wiZ7m3WnBUfVueVaO3Wrt6rL2oP2ffHDKDaOfcWR2czQus07TzNw9h+r
         Uz+A==
X-Gm-Message-State: AJaThX50buBYQwRc/0eWysprb5ZtQwu7EtqldfB8kZW1FVZnQXUh84n7
        7eSMOP3CZsEpaIhGEwY7QGX0ELV7ys1KYU7HX6QzOTyr
X-Google-Smtp-Source: AGs4zMaajK0FLB/c0n6jzxkv4VptDpD5o3GSTMIJXLXhCjkI9HlHNHs195BIuXYpUgwoxpDyge/y0yKN0LLPAIechho=
X-Received: by 10.107.47.234 with SMTP id v103mr6376621iov.96.1511198737290;
 Mon, 20 Nov 2017 09:25:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 20 Nov 2017 09:25:36 -0800 (PST)
In-Reply-To: <20171117220210.6xqi26mabbyvxc2m@sigill.intra.peff.net>
References: <20171115125200.17006-1-chriscool@tuxfamily.org>
 <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com> <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
 <20171117174258.GP3693@zaya.teonanacatl.net> <20171117220210.6xqi26mabbyvxc2m@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Nov 2017 18:25:36 +0100
Message-ID: <CAP8UFD3LhR+FRMM--SQVZ_m2-g2w-WkmmFX7aqrp9S5A9vi1ow@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 11:02 PM, Jeff King <peff@peff.net> wrote:
>
> I'm actually tempted to say that we should not be building the tcl parts
> by default. IOW, instead of NO_TCLTK we should have USE_TCLTK. That
> would also require an adjustment by package builders, but it would
> hopefully be a really obvious one. And once the user has told our
> Makefile that they definitely want to build the tcl parts, we'd
> presumably just trust that the tcl path they give us is sane.
>
> But it's possible I'm underestimating how many people actually use the
> tcl scripts. Certainly I don't, and git-gui seems fairly primitive to me
> these days compared to 3rd party tools. But then I don't use any of them
> either. ;)

As I wrote in the version 2 of the patch (yeah I forgot to mark it as
version 2) I agree that removing NO_TCLTK while introducing USE_TCLTK
and not building git-gui and gitk by default is simpler and probably
the right direction for the future, but I think it might be too big a
change for now or until the next major release (Git 3.0.0).

Especially it can cause issues to people who were building and
installing gitk and git-gui because they use it. They might not
realize that USE_TCLTK has been introduced and still think that they
are building and installing the newest versions, when in fact they
would not and keep using old versions.
