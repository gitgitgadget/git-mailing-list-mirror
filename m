Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B6A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeG3N7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 09:59:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39236 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeG3N7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 09:59:21 -0400
Received: by mail-it0-f65.google.com with SMTP id g141-v6so16506920ita.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djlOONErIfaDmWcUhV48yAJIQFdP4jVV9l3rdKRcyq4=;
        b=rieqFCHXoUZD98oNzFoPVCRRrchuD4+gOzLhB+YNWl+5PUSvy+ZNNNLkWdTwZ1c5OT
         k5H+D114wIvnbvZoDzmpOLgC4UZZHJVvPdSBkmvIE6Hw0mhbOlrceBFCvY2p+2c/3hso
         6C6/j82olWtUZI9G4kR8tzFKsrHQO78jy53zOKnGJdt2S45dqWl1tubNKLn6CmvOWfWb
         oJKTRDui+HDLZFuR3KqwJE0UpdXH1lx7az1WffCCod6ohYbkd6rI4p5B42l3PSZk/h+n
         +L/dT3gLDnr+S9ATIWZ6F+UiphALZqUOoZEFjwSPsV9X684qB66MjRGZSVtJM75XWCfg
         g8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djlOONErIfaDmWcUhV48yAJIQFdP4jVV9l3rdKRcyq4=;
        b=kv4EqF9D/WvJ+Aa6Wde9H15Aew050EUyeCR9BB3gnOLfA8nHT9iban1cd7EjlCaT5n
         4B9UFRQxqqXoCVe9Z87fTz7cxepspWXQdF0ILs/UW7DX5FVWC7GXWtM+Z5fuCjSwUcSZ
         PvP7l6a4U5/rPqVYrSTcN45qNUJiW4QcEuYqgLz+tkWUhKY87o7t4OK/mTEOWijVIjOf
         2SbcvmiHZ5xiSCi+LGtYJkxvBPH/Y+bwzMP9B5sVPg7onkoZ0CAPvRv1Cb0TW7WYKqUn
         gFmRFLFgTKCMaihYY396muP+tr1GTb0gEjyVFY/4zwIG+sQiMjjpFxKwdOJnYu9LIi4T
         +KEg==
X-Gm-Message-State: AOUpUlGm6GML+5JIqMwZfLjcL3PsM2R3lt4yZJc8WvNfAtePgUeX6eGm
        9rdcAZ2ckXxI/DNnRBcedTskBjrP6FD1X0DFH6P4aw==
X-Google-Smtp-Source: AAOMgpe717Len8FPnONRglDMu1gz4UZtK/bntRGPUGeT2hQN2aOKDuAzco7aAr7M2ylbbSCP9t7WVVtLJXpwo8CrMlU=
X-Received: by 2002:a24:374d:: with SMTP id r74-v6mr3113225itr.57.1532953476155;
 Mon, 30 Jul 2018 05:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180726171751.178616-1-hanwen@google.com> <xmqqva91q1an.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva91q1an.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Jul 2018 14:24:24 +0200
Message-ID: <CAFQ2z_P0_gtNw0NHBYiF=-9ZB6u9VEkq89R4qH_ZTcZ5jfxbkA@mail.gmail.com>
Subject: Re: [PATCH] RFC Highlight keywords in remote sideband output.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 8:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>     Hold your objection a bit.  I'll come back to it soon ;-)
>
> It theoretically may make more sense to color on the sender side,
> but that is true only if done at a higher layer that prepares a
> string and calls into the sideband code to send.  That code must
> know what the bytes _mean_ a lot better than the code at the
> sideband layer, so we do not have to guess.
>
> Having written all the above, I think you are doing this at the
> receiving end, so this actually makes quite a lot of sense.  I was
> fooled greatly by "EMIT_sideband", which in reality does NOT emit at
> all.  That function is badly misnamed.

fixed.

> The function is more like "color sideband payload"; actual
> "emitting" is still done at the places the code originally "emitted"
> them to the receiving user.
>
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > Change-Id: I090412a1288bc2caef0916447e28c2d0199da47d
>
> That's an unusual trailer we do not use in this project.

Yes, I know. I forgot to strip it from v2 again, though :-(

> > +void emit_sideband(struct strbuf *dest, const char *src, int n) {
>
> Open brace on its own line.

Done.

> > +        // NOSUBMIT - maybe use transport.color property?
>
> Avoid // comment.

Done

> In our codebase in C, asterisk sticks to the variable not the type.

Done.

> > +        } keywords[] =3D {
> > +                {"hint", GIT_COLOR_YELLOW},
> > +                {"warning", GIT_COLOR_BOLD_YELLOW},
> > +                {"success", GIT_COLOR_BOLD_GREEN},
> > +                {"error", GIT_COLOR_BOLD_RED},
> > +                {},
>
> Drop the last sentinel element, and instead stop iteration over the
> array using (i < ARRAY_SIZE(keywords)).

Done.

> > +        for (struct kwtable* p =3D keywords; p->keyword; p++) {
>
> Does anybody know if we already use the variable decl inside the
> "for (...)" construct like this?  I know we discussed the idea of
> using it somewhere as a weather-balloon to see if people with exotic
> environment would mind, and I certainly do not mind making this
> patch serve as such a weather-baloon, but if that is what we are
> doing, I want the commit log message clearly marked as such, so that
> we can later "git log --grep=3DC99" to see how long ago such an
> experiment started.

I elided this. (I had expected for the compile to enforce restrictions
like these using --std=3Dc99.)

> >   * Receive multiplexed output stream over git native protocol.
> > @@ -48,8 +95,10 @@ int recv_sideband(const char *me, int in_stream, int=
 out)
> >               len--;
> >               switch (band) {
> >               case 3:
> > -                     strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" =
: "",
> > -                                 DISPLAY_PREFIX, buf + 1);
> > +                     strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : =
"",
> > +                                 DISPLAY_PREFIX);
> > +                        emit_sideband(&outbuf, buf+1, len);
> > +
>
> Let's not lose SP around "+" on both sides.
>
> Also you seem to be indenting some lines with all SP and some with
> mixture of HT and SP.  We prefer to use as many 8-column HT and then
> fill the remainder with SP if needed to align with the opening
> parenthesis on line above it (imitate the way strbuf_addf() is split
> into two lines in the original in this hunk).

Fixed these, I think.

> Thanks.  While there are need for mostly minor fix-ups, the logic
> seems quite sane.  I think we can start without configuration and
> then "fix" it later.

I need the configuration to be able to test this, though.

> While I am OK with calling that variable "transport.<something>", we
> should not define/explain it as "color output coming from the other
> end over the wire transport".  Those who want to see messages
> emitted remotely during "git fetch" in color would want to see the
> messages generated by "git fetch" locally painted in the same color
> scheme, so it makes sense to let "git fetch" pay attention and honor
> that variable even for its own locally generated messages.  The
> variable instead means "color any message, either generated locally
> or remotely, during an operation that has something to do with
> object transport", or something like that.

I used color.remote for the property,  but I'm happy to colorize the
bikeshed with another color.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
