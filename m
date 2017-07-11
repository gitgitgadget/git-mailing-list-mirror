Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F99202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932658AbdGKNum (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:50:42 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36019 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbdGKNuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:50:40 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so59449pgb.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vBJZL+k3zrcekt783TR5Vutmo3cMkZwEoj6ba9fxRFM=;
        b=nC2QPs2PTqQRJlSVDodmmbFmgPEXB2HflRJAQbsh99xWqKLtM5wvgOm7agnIFKlNHr
         PXA7N7EnN/8OkbOHpsTNtR+6d20GB7pe9Ot6XL8c5VjXJR11zqnShOxAg6+IQVXXxcL+
         Ex5C5ayj+GoDmcAkjjULab5xCFRvHMwo8DNPSaTsIx7mhUkB6k2OaSj1wnbjEUuJV/sU
         niYVPpAr7SYtU3TDf6qkLBd0qA5UW8wTIHF/p42jkw/DKTYzGkp0Uaap8auKezxNcfto
         lUeRwDhBj3U3JA9V6dWu8DSPNQFg7xaAKo+I5AZPrClP57RNnQIechuRS2U/ZIl77SHY
         08Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vBJZL+k3zrcekt783TR5Vutmo3cMkZwEoj6ba9fxRFM=;
        b=sODXcKVp/apXZ2F/vsTIuxFMkuiXk++K3SB1gTg6OpFwtiRJMFx3TB+Oihelot5plx
         fOr5Sx/wH6moL8GlqeImE2L3mha9WBCVJnszMckKwD8HIfs2RKI2M1KP+eEb7YohCCfb
         VnkeER720/99crMWAPVC+BRAB6BlxuLXZgYPXEgHp0GaBi8W5cXaJYLRTCsEU+++Y8Fx
         tUSUwGOiyTmGZ4aiGdkJ6WlBFrZs/McZY9+AibaNI82SJo25QtUGQLoJq8SrZPuebZUU
         iL1SDJEmOqsgH/HLP521dBY2Br63mXnM+SsSF1EsAhUXQwkZwBcDpUTmKD46WfYBB9pQ
         PeYQ==
X-Gm-Message-State: AIVw111sx7+06KIGj44Kv+aL6vR5ZKwKgtgAeZaERxX2OUr1iv5GvRZv
        Hg4L5sNoBJZXTPlYiew6s0KfKiSpzA==
X-Received: by 10.98.222.3 with SMTP id h3mr49065726pfg.93.1499781040124; Tue,
 11 Jul 2017 06:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Tue, 11 Jul 2017 06:50:39 -0700 (PDT)
In-Reply-To: <20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Jul 2017 15:50:39 +0200
Message-ID: <CAN0heSqN6SJ_dppbYEDYVs+pSzVdLvLUDL4_VSNn79ro6c_8=g@mail.gmail.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 12:19, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 10, 2017 at 11:55:13PM +0200, Martin =C3=85gren wrote:
>
>> Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such
>> as "Vim: Warning: Output is not to a terminal" and a garbled terminal.
>> A user who makes use of `git tag -a` and `git tag -l` will probably
>> choose not to configure `pager.tag` or to set it to "no", so that `git
>> tag -a` will actually work, at the cost of not getting the pager with
>> `git tag -l`.
>
> Right, I think we are all agreed that "pager.tag" as it is now is
> essentially worthless.
>
> If I understand your series correctly, though, it adds pager.tag.list
> but leaves "pager.tag" behaving more or less the same. It's good that we
> now have a way for a user to do the thing they actually want, but it
> feels like we're leaving pager.tag behind as a booby-trap.
>
> Should we disable it entirely (or only respect it in list mode)?
>
> At which point, I wonder if we actually need pager.tag.list at all.
> Slicing up the namespace further would be valuable if there were a
> command which had two pager-worthy modes, and somebody might want to
> enable the pager for one but not the other. But it seems like most
> commands in this boat (e.g., tag, branch, stash) really have two modes:
> listing things or creating things.
>
> Would it makes sense to just have git-tag respect pager.tag in listing
> mode, and otherwise ignore it completely?

Yes. I doubt anyone would notice, and no-one should mind with the
change (famous last words).

It does mean there's a precedence for individual commands to get to
choose when to honor pager.foo. If more such exceptions are added, at
some point, some command will learn to ignore pager.foo in some
particular situation and someone will consider it a regression.

> One nice side effect is that it keeps the multi-level pager.X.Y
> namespace clear. We've talked about transitioning to allow:
>
>   [pager "foo"]
>   enable =3D true
>   command =3D some-custom-pager
>
> to configure aspects of the pager separately for git-foo. This has two
> benefits:
>
>   1. Syntactically, it allows configuration for commands whose names
>      aren't valid config keys.
>
>   2. It would allow setting a command with "enable=3Dfalse", so that "git
>      foo" did not paginate, but "git -p foo" paginated with a custom
>      command.
>
> Those are admittedly minor features. And assuming we don't go crazy with
> the multi-level names, we could have "pager.tag.list" live alongside
> "pager.tag.command". So it's not really an objection, so much as wonder
> out loud whether we can keep this as simple as possible.

Well, I respect your hunch about .enable and .command and I certainly
don't want to take things in a direction that makes that approach less
clean. You have convinced me that I will instead try to teach git tag
to be more clever about when to use the pager, at least to see what
that looks like.

Let's call such a "git tag" the "future git tag". Just to convince
myself I've thought through the implications -- how would
pager.tag.enable=3Dtrue affect that future git tag? Would it be fair to
say that enable=3Dfalse means "definitely don't start the pager (unless
--paginate)" and that enable=3Dtrue means "feel free to use it (unless
--no-paginate)"? The future git tag would default to using
enable=3Dtrue. Would --paginate also be "feel free to use it", or rather
"the pager must be used"?

At some point, I thought about "true"/"false"/"maybe", where "maybe"
would be what the future git tag implements. Of course, there's a fair
chance not everyone will agree what exactly should be paged with
"maybe". So it's back to adding various knobs. ;)

Anyway, this is more my thinking out loud. I'll drop pager.tag.list in
v2 and will instead make pager.tag more clever. That should force me
to think through this some more.

>> This is an attempt to implement something like that. I decided to let
>> `pager.tag.list` fall back to `pager.tag` before falling back to "on".
>> The default for `pager.tag` is still "off". I can see how that might
>> seem confusing. However, my argument is that it would be awkward for
>> `git tag -l` to ignore `pager.tag` -- we are after all running a
>> subcommand of `git tag`. Also, this avoids a regression for someone
>> who has set `pager.tag` and uses `git tag -l`.
>
> Yeah, I agree that turning "pager.tag" into a complete noop is probably
> a bad idea. But if we made it a silent noop for the non-list cases, that
> would be OK (and the hypothetical user who set it to make `git tag -l`
> work would see a strict improvement; they'd still get their paging but
> not the weird breakage with non-list modes). And I think that applies
> whether we have a pager.tag.list in addition or not.

Good thinking.

Thanks a lot for your comments. I appreciate it.

Martin
