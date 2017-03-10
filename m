Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F591FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936069AbdCJMK0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 07:10:26 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33110 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934984AbdCJMJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 07:09:53 -0500
Received: by mail-io0-f179.google.com with SMTP id f84so45901952ioj.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zcnmEc3avPNDamNodk5zi6BgTiSJmHoSLEuMPUV+pBI=;
        b=Uu5W84HotY+yvUrWKNaV/J83sS0kZUVIEH1eUnnMQrEXdQiwViMSeBhqe5b1NlnySG
         xwjV8qASdskIVds7by6yeXYJSi927aQBYXATt66x+2xYPeiCLE+dSsrvYeOzMoP/jWL9
         vyPwvzFnNhrgaWCb98cSJ1G3mnc2XqZDdsTq9HUeYpYdlZGRfZ+8x4yUSJ+5WiC0wW2l
         OcybMOh2lRAVpnxNG/IfKb0qJeukB0fQxMvIQKv8pBkJYNNNZ26zOiD/+YxkeAaBrNda
         vKjuZo08UqXb4KWn1/8KdCfF0IC5xGek0qaWjxAwMv6YUqEZdMpmfBZwefO+65wnqa14
         Bovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zcnmEc3avPNDamNodk5zi6BgTiSJmHoSLEuMPUV+pBI=;
        b=fQWkNeZ3CBiiADODPwJUxePzFUgrWUUtLwcE/KcXar93GR4dYUTDNGpJ4PCfmf1vLZ
         1bbE7BC1OHHbb4LWippb8OVzGz5KS3zTbrBC1fjXJCvZtjn/zemC/3IDLYzI44Zu2quL
         7NULZmwOh5RYbFqJrZ9kSUMRNw5oYpVMcyZgXWGE8HHxkiaNSNykO0IeLQe68GQQWKZN
         YXAuSj7KNDw8S13Qqvyj6G9rLajlSbEiRp2PgdSLc1dOwjgX026YNkt/Grbb1GaBooRt
         clgTXLdFLcUlvgP+HVaLKhuToyXyWrLdnpdhIyu8sbnbK9lgxIXR1wMQO7QWFya48lr+
         AqdA==
X-Gm-Message-State: AMke39kwHJ9x10psQ8qWHjehHjpzVkQLz0YVrY7TwmW2vuEnJlguFhF8a8yyDFCbPnMS4oGAAKvvw0Oouo7m5Q==
X-Received: by 10.107.150.201 with SMTP id y192mr18327862iod.33.1489147791653;
 Fri, 10 Mar 2017 04:09:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 04:09:30 -0800 (PST)
In-Reply-To: <CACBZZX74fpEzic3Qs0kG5i5pb-up+Ct0cp71beDXaj+BoDcKRQ@mail.gmail.com>
References: <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
 <20170309200243.2203-1-avarab@gmail.com> <CAP8UFD3zGTO5RBpX-WE+8KfTa0pv5NcNDtBRVdRVEdGomL_Wfg@mail.gmail.com>
 <CACBZZX74fpEzic3Qs0kG5i5pb-up+Ct0cp71beDXaj+BoDcKRQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 13:09:30 +0100
Message-ID: <CACBZZX7EW013ZhDtUWome5nOqLjha34B9gJCRQgc0J0qkvWBuA@mail.gmail.com>
Subject: Re: [PATCH v2] ref-filter: Add --no-contains option to tag/branch/for-each-ref
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 12:46 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Mar 9, 2017 at 9:31 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, Mar 9, 2017 at 9:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>>> index 525737a5d8..4938496194 100644
>>> --- a/Documentation/git-tag.txt
>>> +++ b/Documentation/git-tag.txt
>>> @@ -12,7 +12,7 @@ SYNOPSIS
>>>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>>>         <tagname> [<commit> | <object>]
>>>  'git tag' -d <tagname>...
>>> -'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>> +'git tag' [-n[<num>]] -l [--[no-]contains <commit>] [--points-at <obje=
ct>]
>>>         [--column[=3D<options>] | --no-column] [--create-reflog] [--sor=
t=3D<key>]
>>>         [--format=3D<format>] [--[no-]merged [<commit>]] [<pattern>...]
>>>  'git tag' -v [--format=3D<format>] <tagname>...
>>> @@ -124,6 +124,10 @@ This option is only applicable when listing tags w=
ithout annotation lines.
>>>         Only list tags which contain the specified commit (HEAD if not
>>>         specified).
>>>
>>> +--no-contains [<commit>]::
>>> +       Only list tags which don't contain the specified commit (HEAD i=
f
>>> +       not secified).
>>
>> s/secified/specified/
>>
>>> +
>>>  --points-at <object>::
>>>         Only list tags of the given object.
>>>
>>> diff --git a/builtin/branch.c b/builtin/branch.c
>>> index 94f7de7fa5..e8d534604c 100644
>>> --- a/builtin/branch.c
>>> +++ b/builtin/branch.c
>>> @@ -548,7 +548,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>>>                 OPT_SET_INT('r', "remotes",     &filter.kind, N_("act o=
n remote-tracking branches"),
>>>                         FILTER_REFS_REMOTES),
>>>                 OPT_CONTAINS(&filter.with_commit, N_("print only branch=
es that contain the commit")),
>>> +               OPT_NO_CONTAINS(&filter.no_commit, N_("print only branc=
hes that don't contain the commit")),
>>>                 OPT_WITH(&filter.with_commit, N_("print only branches t=
hat contain the commit")),
>>> +               OPT_WITHOUT(&filter.with_commit, N_("print only branche=
s that don't contain the commit")),
>>
>> s/with_commit/no_commit/
>
> Thanks!
>
> FWIW this is the current status of my WIP v3. I noticed a couple of
> other issues where --contains was mentioned without --no-contains.
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 4938496194..d9243bf5e4 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -129 +129 @@ This option is only applicable when listing tags
> without annotation lines.
> -       not secified).
> +       not specified).
> diff --git a/builtin/branch.c b/builtin/branch.c
> index e8d534604c..dd96319726 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -553 +553 @@ int cmd_branch(int argc, const char **argv, const char *p=
refix)
> -               OPT_WITHOUT(&filter.with_commit, N_("print only
> branches that don't contain the commit")),
> +               OPT_WITHOUT(&filter.no_commit, N_("print only branches
> that don't contain the commit")),
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index b1ae2388e6..a11542c4fd 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -12 +12 @@ static char const * const for_each_ref_usage[] =3D {
> -       N_("git for-each-ref [--contains [<object>]]"),
> +       N_("git for-each-ref [(--contains | --no-contains) [<object>]]"),
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d83674e3e6..57289132a9 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -25 +25 @@ static const char * const git_tag_usage[] =3D {
> -       N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <ob=
ject>]"
> +       N_("git tag -l [-n[<num>]] [--[no-]contains <commit>]
> [--points-at <object>]"

Add to that:

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8ad5719962..bec3d0fb42 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1804 +1804 @@ EOF"
-       test_line_count ">" 70 actual
+       test_line_count ">" 10 actual

The tests currently fail with v2 if gpg isn't installed, which'll
cause the number to dip below 70, just setting it to a much more
conservative 10, but maybe this should just be "test -s actual" ...

>
> These last two hunks are going to bust the i18n files for most
> languages. Junio/Jiang, in cases like these where I could fix those up
> with a search/replace on po/* without knowing the languages in
> question (since it's purely changing e.g. --contains to
> --[no-]contains), what do you prefer to do, have that as part of this
> patch, or do it after the fact through the normal i18n maintenance
> process?
