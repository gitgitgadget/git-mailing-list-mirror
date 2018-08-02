Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CA21F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbeHBQMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:12:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37848 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbeHBQMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:12:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so1017113eds.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EGLsAtxqHP6wbTkJ9cD/jv40P8MMHlwTc7OjttdzjNQ=;
        b=ZymdycgGBCea5BZIuQvc8N639L+p3AgarGBSMSTOAtj6ceOCsGxJVhm6NXigV+t7Aw
         cTqK1frp3kyfY7rLbOaqhadgQGGVFDkeLan8q6gQp1SdnyH+r4q9By35kXeApYk5Uv4J
         sjn24e/G3Ohml9AgFpz+wXOsXR8y1KYgEhGpkEnwQv7qyp0h3t3qbeU7KtA/1xeiwKsA
         yhnAeRptdWi+NG8bikJy3855oWtATu16snogul1phWn06UZ4pGTqGAktu2ZwvgCj8Nbd
         gOMjnQDI55E+DWWT5YSkaqX4q/jMuFzEMak73L6FmOdeW/5u3uqkUm+EkWUfi5ho09BE
         rsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EGLsAtxqHP6wbTkJ9cD/jv40P8MMHlwTc7OjttdzjNQ=;
        b=PyrlWS+RZeqhWYvY2JsQyHHRLRmvz71l5Sz7XdriZD1MdeKbDJ89baMQroLOpzOT9Z
         yXDQvQ5X4g0X8WtWsxOS8vj5PUQG6sqQIK1IEa6WCXnT8aotINUTb4dlLrAqphTTViYO
         yfPfk2aszKTIMZWgLsK3Y1rSwNmecefPzthfui+nioF4+voFupp30lTyX0haBS6db67f
         rgcigpK6OAinfFc9SZ41vp5g0xOahp+oDrUFlp5mBGeKis9NB+JU/UmyXRoStd14762p
         W/KTrluVZijSMF8NS6nhEza9XeEKT/AuSrNCBeMYnnVvpjaD/iCENTXIixh7Xhq+PxZa
         V8Sg==
X-Gm-Message-State: AOUpUlGzVmkjSeiYeAfokYfeLaM0eoq6OipQNFV0Tor4/xjjsbfw4wp4
        VeN2bAputfwKhZ05IzV/8+Q=
X-Google-Smtp-Source: AAOMgpeiGCUeeVRPemlejFpZbb35bDuuAl2++sYIzYRN/mz7I3ZF3ywoJHKzniu1IGcQ1xuRSZJaNA==
X-Received: by 2002:a50:87d2:: with SMTP id 18-v6mr3506229edz.1.1533219686053;
        Thu, 02 Aug 2018 07:21:26 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id s21-v6sm858070edr.62.2018.08.02.07.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 07:21:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
Date:   Thu, 02 Aug 2018 16:21:19 +0200
Message-ID: <87ftzwu9wg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 02 2018, René Scharfe wrote:

> Am 02.08.2018 um 00:31 schrieb Ævar Arnfjörð Bjarmason:
>> But looking at this again it looks like this whole thing should just be
>> replaced by:
>>
>>      diff --git a/builtin/push.c b/builtin/push.c
>>      index 9cd8e8cd56..b8fa15c101 100644
>>      --- a/builtin/push.c
>>      +++ b/builtin/push.c
>>      @@ -558,9 +558,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>                      OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>>                      OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>>                      { OPTION_CALLBACK,
>>      -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>>      +                 0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>>                        N_("require old value of ref to be at this value"),
>>      -                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
>>      +                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>>      +                 parseopt_push_cas_option },
>>                      { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>>                              N_("control recursive pushing of submodules"),
>>                              PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>>
>> I.e. the reason this is confusing is because the code originally added
>> in 28f5d17611 ("remote.c: add command line option parser for
>> "--force-with-lease"", 2013-07-08) didn't use PARSE_OPT_LITERAL_ARGHELP,
>> which I also see is what read-tree etc. use already to not end up with
>> these double <>'s, see also 29f25d493c ("parse-options: add
>> PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).
>
> We could check if argh comes with its own angle brackets already and
> not add a second pair in that case, making PARSE_OPT_LITERAL_ARGHELP
> redundant in most cases, including the one above.  Any downsides?
> Too magical?

I'm more inclined to say that we should stop using
PARSE_OPT_LITERAL_ARGHELP in some of these cases, and change
"refname>:<expect" to "<refname>:<expect>" in push.c, so that the help
we emit is --force-with-lease[=<<refname>:<expect>>].

As noted in 29f25d493c this facility wasn't added with the intent
turning --refspec=<<refspec>> into --refspec=<refspec>, but to do stuff
like --option=<val1>[,<val2>] for options that take comma-delimited
options.

If we're magically removing <>'s we have no consistent convention to
tell apart --opt=<a|b|c> meaning "one of a, b or c", --refspec=<refspec>
meaning "the literal string 'refspec'" and --refspec=<<refspec>> meaning
add a <refspec> string, i.e. fill in your refspec here.
