Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFEA20248
	for <e@80x24.org>; Mon, 11 Mar 2019 05:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfCKFkR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 01:40:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45650 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCKFkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 01:40:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id 125so3148208pgc.12
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q41nvHTiV/DrqXlOrcjgfvomvrLdYIy/AODvrwQnJ4k=;
        b=XNpQNW2bmUYlcedXndX6Tx6EUcoHI0T6x3SJfLCEi19oyHy9XUeoAKidALwJlhTVk1
         w+ZNU0yV+r5XJSRveCbIEwG0oINi0MCn9fga1l499QX9RpNZLXEc96sQH1+6lXm+LTcJ
         5U+3A2AMz2a8KNoy3S4IlF6bcBFuCcS17G6kdmJ1Y71BonoeLG9XzkVzZ6tUnFaPvzUg
         inRP9NzfUbAAAForac+IMWNh/QGX7E2BAfjlWPleckz+OSnUnE8RIUXIZTE7ziI+7Hde
         JLn15cuWwy8dAugpE6MhGqJDptQ8Cv4T4LDLmmopid98ap8tD2YIMkw5HqSa6xvXcB1V
         sy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q41nvHTiV/DrqXlOrcjgfvomvrLdYIy/AODvrwQnJ4k=;
        b=ti+Huy6KzFQ7xwVallZPvjyvnP/11IRHETuu81uQqsIPzV3+Lak0gDzP+mJ4GssuoF
         sbzooJls61psUXsxdCDyIg7Juk6Hy2jVbYi4D7sx+uiDyr/d85sy1Pea0K6f+YbdJmry
         xv6X9ZmRXQbnMIjMlZiyz93Q6SwSkMOtoysrK7G/iGFDG+VAXMQTvGnxS1hYYMl9febs
         z64OV8Mlyjd9uLedXU9Sjib8ILbC4pkQqOAgHU0WSisoUlPMNHyyF0wksmHntEUYvwlC
         ThskQd+bElkGwbRl7xLO8n+T0fAU1U0AvriuNrZfKAwxDgGhzx0fgqGzG37zRkeghirS
         knzw==
X-Gm-Message-State: APjAAAWM30cwruq2qPwegebgi2KjVTLPojKRbtUGTZH1MWuwNGxKaXgx
        stadmpv/5HFz/GjjSI/WWgi88jE3PjBOpEfdZvfnfADh
X-Google-Smtp-Source: APXvYqzhuct+8vC4bHE8rdOGjcjSKNf0ntz48fnZ8zSMdz2U3gx4+aKbUdMQcuw91uDFIlYWpttkCatHb3iZCAw4G6U=
X-Received: by 2002:a17:902:e711:: with SMTP id co17mr31688724plb.171.1552282816125;
 Sun, 10 Mar 2019 22:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com> <cover.1552230490.git.martin.agren@gmail.com>
 <xmqqk1h6kt9z.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1h6kt9z.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 11 Mar 2019 06:40:04 +0100
Message-ID: <CAN0heSo=qPvzqWA7Z4D2EXHw+DPOu70CS_wzR09Ot+aYYRufjA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Mar 2019 at 04:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Since this has hit "next", here are two patches on top to address this.
> >
> > Sorry about this.
>
> Thanks.
>
> If it makes it easier, we can eject ma/asciidoctor-fixes out of
> 'next' when we rebuild 'next'.  I actually am tempted to start
> 'next' from empty for this round after merging some obviously
> correct ones that are there to the 'master' branch.

Ok, then I'll take that offer. I'll squash these two patches into the
original series. Thanks.

Martin
