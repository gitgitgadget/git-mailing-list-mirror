Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECE11FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 10:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbdCIKOm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 05:14:42 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33334 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdCIKOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 05:14:41 -0500
Received: by mail-qk0-f182.google.com with SMTP id y76so111436213qkb.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cQfvITQ70Ifh7odZ5vbi9yMe15SJWKIKzaG7Go7GAnU=;
        b=fJ18IrReOVBaXnTV5hERzpdCA83V4GviGNnGyKckEYo8DfJQuz6TUSpVGugvIXArwo
         lbSKvYaJy5RXWF+zkeRlYg/0bOULfoKDjvb04LKPnbXJCJzs2k32IF2NcgHn743kriHH
         +2GsxPkvrkWmQAJmsAg//LZYCLNgX/yv6DEvHckIAZxRKcdcPfrJFl+L/phdX3SHsw7L
         qqSna3GxygNpdQ/dN5DANigaiOvWBx/Y34nJBCOCeloDzXb2VgKellqWRckr33ObiX3y
         7EPNa+nY0rRLncESM67mQzwRtSeAZPZylGK7kAVnhIARXEbWjK2iUrq9oRgdRl2bdFrQ
         Ksxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQfvITQ70Ifh7odZ5vbi9yMe15SJWKIKzaG7Go7GAnU=;
        b=owNPBaOkx1JoVWoih4IDNnuwpRLqJLW1iSZUmYeeRPThaD1611/lu9nc4YM4J9P86u
         9/AXUbxyeanxkTiCcvYCPSypLOXTgRjGP/fmI3eQ4lDfkUGvStus4hJjIZ4BCu3yoJ0R
         +AsiXeC6Bp8gcbC/QIIOKaEOP9cV2XiUbdacq0CcvACQyaAMQMcmBiYjknUoPPAyksr7
         qh/9B4AB4cMzqo6IOLzpwesprHma8xOab2986waYVtJdaY1xwaebqGiwWueL7rtDT+JS
         zp1u+32ap47K0H1fEauRFSGkthN7B9G/ZY4QnYy0AISruhipdsnhaueceJoiVlRSDw+L
         DYbg==
X-Gm-Message-State: AMke39m6KghBbaBEdduQ2zEZ/JwhP2GPIUbQ+T7d87NFlOhCuPKpNd43G7FMFFkEe0S3hreCVkQIGv8GteYJoQ==
X-Received: by 10.237.57.164 with SMTP id m33mr13840904qte.293.1489052702884;
 Thu, 09 Mar 2017 01:45:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.165.66 with HTTP; Thu, 9 Mar 2017 01:44:42 -0800 (PST)
In-Reply-To: <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
 <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com> <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
From:   Guillaume Wenzek <guillaume.wenzek@gmail.com>
Date:   Thu, 9 Mar 2017 10:44:42 +0100
Message-ID: <CAAvNd=gAvONS-XP2vOLExdWiwDXTPbB5beiXikwdig7xC5OKow@mail.gmail.com>
Subject: Re: BUG Report: git branch ignore --no-abbrev flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for looking into it,

The full version number is "2.12.0.246.ga2ecc84866" but I don't think
that's an official number, I'm using my company (Google) apt
repository.

The git package date is 2017/03/03 while previous version was from
2017/02/16, the commit you identified is actually between the two, so
that may be it.

On 8 March 2017 at 22:59, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Guillaume Wenzek <guillaume.wenzek@gmail.com> writes:
>>
>>> After updating to git 2.12.0 on Monday I noticed that the "git branch"
>>> wasn't behaving as usual.
>>
>> Are you sure you are trying 2.12?  v2.12.0 and before should behave
>> the same way and honor --no-abbrev as far as I know.
>>
>> On the other hand, 'master' has 93e8cd8b ("Merge branch
>> 'kn/ref-filter-branch-list'", 2017-02-27), which seems to introduce
>> the regression.
>>
>> Karthik?
>
> I haven't fully checked if filter.abbrev is set correctly, but I
> noticed the output format is formulated without taking the value of
> filter.abbrev into account at all, so this is an attempt to fix
> that omission.
>
> I also notice that filter.abbrev is _ONLY_ used by builtin/branch.c and
> the actual ref-filter code does not have to know anything about it.
>
> We probably should eliminate filter.abbrev field from the structure
> and use a regular variable in builtin/branch.c and use it to pass
> the result of command line parsing from cmd_branch() down to
> build_format() as an argument.
>
> But that is outside the scope of regression fix.
>
>
>  builtin/branch.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index cbaa6d03c0..537c47811a 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -335,9 +335,18 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>                     branch_get_color(BRANCH_COLOR_CURRENT));
>
>         if (filter->verbose) {
> +               struct strbuf obname = STRBUF_INIT;
> +
> +               if (filter->abbrev < 0)
> +                       strbuf_addf(&obname, "%%(objectname:short)");
> +               else if (!filter->abbrev)
> +                       strbuf_addf(&obname, "%%(objectname)");
> +               else
> +                       strbuf_addf(&obname, " %%(objectname:short=%d) ", filter->abbrev);
> +
>                 strbuf_addf(&local, "%%(align:%d,left)%%(refname:lstrip=2)%%(end)", maxwidth);
>                 strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
> -               strbuf_addf(&local, " %%(objectname:short=7) ");
> +               strbuf_addf(&local, " %s ", obname.buf);
>
>                 if (filter->verbose > 1)
>                         strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
> @@ -346,10 +355,12 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>                 else
>                         strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
>
> -               strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
> -                           "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
> +               strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
> +                           "%%(if)%%(symref)%%(then) -> %%(symref:short)"
> +                           "%%(else) %s %%(contents:subject)%%(end)",
>                             branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
> -                           branch_get_color(BRANCH_COLOR_RESET));
> +                           branch_get_color(BRANCH_COLOR_RESET), obname.buf);
> +               strbuf_release(&obname);
>         } else {
>                 strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
>                             branch_get_color(BRANCH_COLOR_RESET));
