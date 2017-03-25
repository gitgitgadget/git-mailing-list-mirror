Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8D720966
	for <e@80x24.org>; Sat, 25 Mar 2017 22:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdCYWcj (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 18:32:39 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38107 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCYWci (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 18:32:38 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so20956701itc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vl8WBhn1YOSgML2/pQ0MmdYqLwGU0u5QRdparZDnaqU=;
        b=qSLGUW/WWSx9JFjQTHbXPjkFHKQckLd63YLn6UcICszHcEeRB6FqzpRjRhkWcqMLaR
         Ii1FWwa/qZB9i+UYiFoba8LOYSKUaPzXa/UULZ1YNnaIFh7RIvYMhg2EAYyjTmoVIs/N
         6vWMMd8+Ft98yzXHMmpmrtC6YAfFq9e4tBYZrg9oBUz8oPTuYZEEOyvE4ca/a6BoBnYa
         YKIXn6YU8x2+wzZ863LYQDZPIkZOXHu5lJflsNgeqLY9H1vI6rjdix328dfhssjO4jP4
         eRwSIczfy8PkY6DPyDHnI1oUYDwQA5YPXxU42i9JQ1/E4Uq8JAK1fD+Ko8vgjdUpk3Zy
         cG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vl8WBhn1YOSgML2/pQ0MmdYqLwGU0u5QRdparZDnaqU=;
        b=IT4yBP05hHH0HroEgMRO50q+j8leyN0o2oiXn4TipX0q+vLkVxQYMA8WgQsrE9lVn+
         AanaUzs/pEG+bQaJxDI9bEuxQlMVrRNvv6FcHmh2XZX74T8XiCrnJdm0Ep5bwQVcULAf
         Ihoq2d4yPT5t2f4aItUgMUiEVMbC35eA42C7GFNI06bprBk2Cp38lAZd4lFj8H4G8mkI
         nmw04BwjyP5bFpRoQE5bosyylrnXw6deTwcjBHaaSv9/uCwMDr8fcM2yQDEAJvs15bK6
         mFTPVnSwXu6Ca101MXJNEJ2KbQwvstL+mEBJxbs776ZdM5XSrap01SW6amhdjwhUQQhT
         7FPw==
X-Gm-Message-State: AFeK/H0UnTPEL6Z6pnc9SuiTUtZ6sCL8EHJSyuTWSGv8BbGy5w/ZB+sEE6poeliBJd0hyJi1VcSdvjmkrYlrEg==
X-Received: by 10.107.150.201 with SMTP id y192mr16424575iod.33.1490481142905;
 Sat, 25 Mar 2017 15:32:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 15:32:02 -0700 (PDT)
In-Reply-To: <20170325213107.u2l5eunqgqbxpcbb@sigill.intra.peff.net>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <20170324231013.23346-1-avarab@gmail.com> <CACBZZX6iz5QpfpOO6s9c-GY7+ZZ2uXBxqgKfSRhU+__P0VLC5g@mail.gmail.com>
 <20170325213107.u2l5eunqgqbxpcbb@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 23:32:02 +0100
Message-ID: <CACBZZX6=_Jh-emAr=g1-VQwgA4MnDpu=zSOqPK5QHAa7uef_LQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] parse-options: add facility to make options configurable
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 10:31 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2017 at 05:47:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> After looking at some of the internal APIs I'm thinking of replacing
>> this pattern with a hashmap.c hashmap where the keys are a
>> sprintf("%d:%s", short_name, long_name) to uniquely identify the
>> option. There's no other obvious way to uniquely address an option. I
>> guess I could just equivalently and more cheaply use the memory
>> address of each option to identify them, but that seems a bit hacky.
>
> Rather than bolt this onto the parse-options code, what if it were a
> separate mechanism that mapped config keys to options. E.g., imagine
> something like:
>
>   struct {
>         const char *config;
>         const char *option;
>         enum {
>                 CONFIG_CMDLINE_BOOL,
>                 CONFIG_CMDLINE_MAYBE_BOOL,
>                 CONFIG_CMDLINE_VALUE
>         } type;
>   } config_cmdline_map[] =3D {
>         { "foo.one", "one", CONFIG_CMDLINE_BOOL },
>         { "foo.two", "two", CONFIG_CMDLINE_VALUE },
>   };
>
> And then you "apply" that mapping by finding each item that's set in the
> config, and then pretending that "--one" or "--two=3D<value>" was set on
> the command-line, before anything the user has said. This works as long
> as the options use the normal last-one-wins rules, the user can
> countermand with "--no-one", etc.
>
> You have to write one line for each config/option mapping, but I think
> we would need some amount of per-option anyway (i.e., I think the
> decision was that options would have to be manually approved for use in
> the system). So rather than a flag in the options struct, it becomes a
> line in this mapping.
>
> And you get two extra pieces of flexibility:
>
>   1. The config names can map to option names however makes sense; we're
>      not constrained by some programmatic rule (I think we _would_
>      follow some general guidelines, but there are probably special
>      cases for historic config, etc).
>
>   2. A command can choose to apply one or more mappings, or not. So
>      porcelain like git-log would call:
>
>        struct option options[] =3D {...};
>        apply_config_cmdline_map(revision_config_mapping, options);
>        apply_config_cmdline_map(diff_config_mapping, options);
>        apply_config_cmdline_map(log_mapping, options);
>
>      but plumbing like git-diff-tree wouldn't call any of those.
>
> I had in mind that apply_config_cmdline_map() would just call
> parse_options, but I think even that is too constricting. The revision
> and diff options don't use parse_options at all. So really, it would
> probably be more like:
>
>   struct argv_array fake_args =3D ARGV_ARRAY_INIT;
>   apply_config_cmdline_map(revision_config_mapping, &fake_args);
>   apply_config_cmdline_map(diff_config_mapping, &fake_args);
>   apply_config_cmdline_map(log_mapping, &fake_args);
>   argv_array_pushv(&fake_args, argv); /* add the real ones */
>
> At this point we've recreated internally the related suggestion:
>
>   [options]
>   log =3D --one --two=3Dwhatever
>
> which is the same as:
>
>   [log]
>   one =3D true
>   two =3D whatever
>
> So hopefully it's clear that the two are functionally equivalent, and
> differ only in syntax (in this case we manually decided which options
> are safe to pull from the config, but we'd have to parse the options.log
> string, too, and we could make the same decision there).

I like the simplicity of this approach a lot. I.e. (to paraphrase it
just to make sure we're on the same page): Skip all the complexity of
reaching into the getopt guts, and just munge argc/argv given a config
we can stick ahead of the getopt (struct options) spec, inject some
options at the beginning if they're in the config, and off we go
without any further changes to the getopt guts.

There's two practical issues with this that are easy to solve with my
current approach, but I can't find an easy solution to using this
method.

The first is that we're replacing the semantics of:

"If you're specifying it on the command-line, we take it from there,
otherwise we use your config, if set, regardless of how the option
works"

with:

"We read your config, inject options implicitly at the start of the
command line, and then append whatever command-line you give us"

These two are not the same. Consider e.g. the commit.verbose config.
With my current patch if have commit.verbose=3D1 in your config and do
"commit --verbose" you just end up with a result equivalent to not
having it in your config, but since the --verbose option can be
supplied multiple times to increase verbosity with the injection
method you'd end up with the equivalent of commit.verbose=3D2.

I think the semantics I've implemented are much less confusing for the
user, i.e. you can specify an option that's configurable and know that
you're overriding your config, not potentially joining the
command-line with whatever's in your config. We have a lot of options
without last-one-wins semantics.

I can't think of a good way around that with your proposed approach
that doesn't essentially get us back to something very similar to my
patch, i.e. we'd need to parse the command-line using the options spec
before applying our implicit config.

The second issue is related, i.e. I was going to add some flag an
option could supply to say "if I'm provided none of these other
maybe-from-config options get to read their config". This is needed
for hybrid plumbing/porcelain like "git status --porcelain".

Let's say we wanted to add a status.branch config option, and wanted
status.branch=3Dtrue along with "status --porcelain" not to mean "status
--porcelain --branch", potentially breaking scripts, but "status
--porcelain". This again needs needs the guts of the getopt parsing to
work as far as I can tell.
