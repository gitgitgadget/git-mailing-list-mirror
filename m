Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EFD1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHBRQF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:16:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbeHBRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:16:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so2511683wrw.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SDv8++1cSRinWc4br1CqGGppdQZG5vJGu28J63vZ9SI=;
        b=Iue4+dpiKSCBNDz0+P6ob1Y+hdz5rrlpZugRTY6oY0SpLVyjcs5KodiWElVpeh0TWS
         5OIF05u7xo7dvXYN9t1zWOpdjoB7FSJlivCclg8TELZ0yJHY+9dncTAl9bhi5KQERhoI
         8cRbSMrmdLCLbevdWSgUfTC1B42NPDJXw4DpHbiA4+Tygt16Tm7FmkbazmDnmz4TgBTh
         3whYJ17waP98sYkpsu4bkV7fCoz/Zhf+xY6N7o/1KSmeJACwBhuY5IQiUT9GwnJUiz7U
         7+BtNd76VhKL5aIBKt3jT6l5FJ9YDsXc3QYT2MhZosaGe5rLc2InsSb9dUTMUptF5UxR
         4Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SDv8++1cSRinWc4br1CqGGppdQZG5vJGu28J63vZ9SI=;
        b=imOYZjFpexhKbSY8UaK5n8FpTzXgmkXpfFuIyER53inkfhzJEvQJc8XhY6qRxv1pu/
         FoeHib4U6I+kjUOtX1y9DDzIJcmvXBmAs1d+kQP2WrVPlp5rvmi6746h/huqxvyO2Ejk
         e26gND8gr5LyoKM/WRjAXUOG+Fd0TFUo2hSCnZOKODgz0piSgSGYjJCy0FBJO1DS4U0M
         ipkgDFFEUkjWGepwAxFFZM4BD4qK+mWQ3YCBmoW+Nd0YgelUSu3rIg60S+OwBcqoCSid
         SHo0gZwfxC0VDitKiJNreHTOPxLhpy1kk7VuwHdEtj2oKDzojmrrAdvNqSWSCpLc3BbH
         OlKg==
X-Gm-Message-State: AOUpUlGCKjPEKVl1cV4xeS1vIrTOR/Ji9ZT53fyAlRkhgR5zDDJSpiqa
        CS7V/ohM/glECbE/VxczFt8=
X-Google-Smtp-Source: AAOMgpeC79+yaGtLugsvt7L/stcSTMnC84PIuMtGK6zrEHGgIfDaufyDMBI7xL+RTH1mM+PldemNtg==
X-Received: by 2002:adf:82f0:: with SMTP id 103-v6mr2277141wrc.131.1533223463673;
        Thu, 02 Aug 2018 08:24:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g18-v6sm2301137wmh.21.2018.08.02.08.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:24:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <87ftzwu9wg.fsf@evledraar.gmail.com>
Date:   Thu, 02 Aug 2018 08:24:22 -0700
In-Reply-To: <87ftzwu9wg.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 02 Aug 2018 16:21:19 +0200")
Message-ID: <xmqqk1p84wrd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 02 2018, René Scharfe wrote:
>
>> Am 02.08.2018 um 00:31 schrieb Ævar Arnfjörð Bjarmason:
>>> But looking at this again it looks like this whole thing should just be
>>> replaced by:
>>>
>>>      diff --git a/builtin/push.c b/builtin/push.c
>>>      index 9cd8e8cd56..b8fa15c101 100644
>>>      --- a/builtin/push.c
>>>      +++ b/builtin/push.c
>>>      @@ -558,9 +558,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>>                      OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>>>                      OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>>>                      { OPTION_CALLBACK,
>>>      -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>>>      +                 0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>>>                        N_("require old value of ref to be at this value"),
>>>      -                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
>>>      +                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>>>      +                 parseopt_push_cas_option },
>>>                      { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>>>                              N_("control recursive pushing of submodules"),
>>>                              PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>>>
>>> I.e. the reason this is confusing is because the code originally added
>>> in 28f5d17611 ("remote.c: add command line option parser for
>>> "--force-with-lease"", 2013-07-08) didn't use PARSE_OPT_LITERAL_ARGHELP,
>>> which I also see is what read-tree etc. use already to not end up with
>>> these double <>'s, see also 29f25d493c ("parse-options: add
>>> PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).

Yup.  It shows that I did not know (or remember) about LIT-ARGH when
I wrote it (the line stayed in the same shape since its introduction
to the codebase), and I did not know (or remember) when I sent this
patch.  The above is the best solution to my puzzlement within the
framework of the current codebase.

>> We could check if argh comes with its own angle brackets already and
>> not add a second pair in that case, making PARSE_OPT_LITERAL_ARGHELP
>> redundant in most cases, including the one above.  Any downsides?
>> Too magical?
>
> I'm more inclined to say that we should stop using
> PARSE_OPT_LITERAL_ARGHELP in some of these cases, and change
> "refname>:<expect" to "<refname>:<expect>" in push.c, so that the help
> we emit is --force-with-lease[=<<refname>:<expect>>].

I fail to see why the outermost <> pair could be a good idea.
Without them, i.e. in what the current output shows, I can see
<refname> and <expect> are something that I should supply real
values (i.e. placeholders) and I should have a colon (literal) in
between them.  It is an established convention that a token enclosed
in a <> pair is a placeholder.

But I am not sure what you mean by <<refname>:<expect>>.

> As noted in 29f25d493c this facility wasn't added with the intent
> turning --refspec=<<refspec>> into --refspec=<refspec>, but to do stuff
> like --option=<val1>[,<val2>] for options that take comma-delimited
> options.

There is no --refspec=<<refspec>> to begin with.

A single placeholder can be written in the source as "refspec" and
shown as "--refspec=<refspec>" because you get the surrounding <>
pair for free by default.  Nobody would want to write "<refspec>" in
the arg help, as most of the option arguments are a single value
placeholder.  But if you want "<val1>[,<val2>]" in the final output,
you do *not* want surrounding <> pair, so you use the option and
write everythnig manually in the source without magic.

Or are you saying that we should consistently write surrounding "<>"
to all placeholders, and stop special casing single-token ones?
IOW, get rid of literal-arghelp and instead make that the default?

> If we're magically removing <>'s we have no consistent convention to
> tell apart --opt=<a|b|c> meaning "one of a, b or c", --refspec=<refspec>
> meaning "the literal string 'refspec'" and --refspec=<<refspec>> meaning
> add a <refspec> string, i.e. fill in your refspec here.

Ah, this is where you are off-by-one.  "--refspec=<refspec>" means
"give your refspec as its value".
