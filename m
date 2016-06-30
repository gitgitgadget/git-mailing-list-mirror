Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8891FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbcF3P6f (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 11:58:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33056 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbcF3P6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 11:58:33 -0400
Received: by mail-it0-f68.google.com with SMTP id y93so9459061ita.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 08:58:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g0mQ6VL7WE6tcp2TGaNQ4M6JpfVPD3z866BNzDbyO6k=;
        b=tYO3S8UGaRrOiwTRmJMcwk5nVuN5u6mwU0oBjytDAQ7Cq6qxwszDp2gOtg8Alb58gV
         MoSDMl++JikPoVXd9nDn1VtDhaplL5BEjzEmcIPIFNizzEhVDtXED+kUTO2gqWNqcd0c
         m7fUBAS2zAj85/IgqXWbnFvbSUVb0SMXDYnXSrlBZ54Z7kWphJ1GDCEy6E/sJNhWrNMX
         sBcAfJkuE3PdBq+NMxJ2PbfToY7P5+dSt9T74hhm65je9/21F/beNjoKCNh6Ejmpu6jx
         +jlaPDY7PAaTFMaPSIEl0F1fcCC0h7VxrGLTDX0EWgkJj0D9Vpkzb+wiDBlvOMqMw4Cu
         gAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g0mQ6VL7WE6tcp2TGaNQ4M6JpfVPD3z866BNzDbyO6k=;
        b=mjtsBinXZ1O45724saTug3W6et7BOkiKC5qb139//IJ/8QrhBHpwVR3z69l5sIEjuN
         vpuj3HcvT8aA2U7GhV+75MZkEk/RYW5UKpIF/omzqJFn5gCpIWU+fIN3aN8N/ez+AJzm
         ZIHkjU5qF5EUCK+KEZ9bqrmUlzGCO0QySvY/HqsqHgaydcdKvhrHNstim0+1vOgjFp38
         6BW5FmA5rltsKNCRFYAAErlee9oNPWD8v/+cHtW7yOSo2aiuyBkmouHYYZaKfLlE+3X5
         SbcavTMG8xN2sCkY0+Pq1QYCVTfWznxftZ/aN2+580oOM5lHlaeRJznifijeXCizGwu2
         4szg==
X-Gm-Message-State: ALyK8tKE7h+g92qGeY890xU3UBfj9w3oMahc4jdiJQOzbfCohXhdRYctoD9aTCL+GDnZjKDiZx4HtTzcUpcIOg==
X-Received: by 10.36.81.15 with SMTP id s15mr16335485ita.57.1467301581800;
 Thu, 30 Jun 2016 08:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 08:45:52 -0700 (PDT)
In-Reply-To: <xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
References: <20160623162907.23295-1-pclouds@gmail.com> <20160625052238.13615-1-pclouds@gmail.com>
 <xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 17:45:52 +0200
Message-ID: <CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] nd/icase updates
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/grep.c b/grep.c
>> index cb058a5..92587a8 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -432,15 +432,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>>       icase          = opt->regflags & REG_ICASE || p->ignore_case;
>>       ascii_only     = !has_non_ascii(p->pattern);
>>
>> +     if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>>               p->fixed = !icase || ascii_only;
>>       else
>>               p->fixed = 0;
>>
>> @@ -449,6 +442,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>>               kwsincr(p->kws, p->pattern, p->patternlen);
>>               kwsprep(p->kws);
>>               return;
>> +     } else if (opt->fixed) {
>> +             compile_fixed_regexp(p, opt);
>> +             return;
>>       }
>
> This if/elseif/else cascade made a lot simpler and while the
> discussion is fresh in my brain it makes sense, but it may deserve a
> bit of commenting.
>
> And while attempting to do so, I found one possible issue there.
>
> Can't p->ignore_case be true even when opt->regflags does not have
> REG_ICASE?  The user never asked us to do a regexp match in such a
> case, and the logical place to compensate for that case would be
> inside compile_fixed_regexp(), where we use regexp engine behind
> user's back for our convenience, I would think.
>
> In the current code, compile_fixed_regexp() is only called when we
> want ICASE, but hardcoding that assumption to it unnecessarily robs
> flexibility (and the function name does not tell us it is only for
> icase in the first place), so I taught it to do the REG_ICASE thing
> only when opt->ignore_case is set.
>
> How does this look?
>
>
>  grep.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 92587a8..3a3a9f4 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -407,17 +407,21 @@ static int is_fixed(const char *s, size_t len)
>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         int err;
> +       int regflags;
>
>         basic_regex_quote_buf(&sb, p->pattern);
> -       err = regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
> +       regflags = opt->regflags & ~REG_EXTENDED;
> +       if (opt->ignore_case)
> +               regflags |= REG_ICASE;
> +       err = regcomp(&p->regexp, sb.buf, regflags);

Makes sense. But then if opt->ignore_case is false and regflags
happens to have REG_ICASE set, should we clear it as well?

The rest looks good (after your comment fixup). I see you already have
all the changes in your SQUASH??? commit. Do you want me to resend or
you will just squash this in locally?
-- 
Duy
