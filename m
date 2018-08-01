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
	by dcvr.yhbt.net (Postfix) with ESMTP id C048E1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeHBATg (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:19:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeHBATg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:19:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so230230edr.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zxg89B+F+ndrFh+FRMBqava1vwYVkcsbCU17Ulcwdys=;
        b=nsMJnYdFOC2w/K/437FtvGOzBQV31Y+qLrsOMavd3BlmQLspK4cLXTipF3Swfu6FFA
         0MxYPRMKH3ByNOT5C9GG+fS757MQOoIledpfYkDzhawyxuiNSEOnbMq9Eujg590dXnh6
         OjcLh43NnJg5mKT/NYrd9Ecu4YbQM7HJqSR47RNXK0h4DkhVjSe64qJKwt832bpJJNn/
         4t+m5g6JJa84cdp5U6s+cG8zAXKjBwclZbFIqxvZUHpCakGjupmai+5fR+LWGiIHlNql
         wIve4rN/0A88CQkQryNOulRLExUQTTKfCXLvGWjw6fl+NpjKCCzTm6ib8fyB1jEZiZTu
         LHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zxg89B+F+ndrFh+FRMBqava1vwYVkcsbCU17Ulcwdys=;
        b=CUymxbd46vFzhLc57PwzAdQb9vEBY86p+SI0xXwcVBTHKUEIrlmsal6JixNr9x3yW2
         CdPOMb3Vh/LOEomSbTPkMutQ37Ub+o+MOpEg2SLAtysj0xRpptVjBj3l2rGt8rcytKGc
         z3DxE2OJ6n9klBHGJs39McTOdLINqX6rwAyfaFPK5v9CgFTEApYjyOjgPXRImeENwwEC
         3OCdzb6Wy2Z22QxVCrZ2o41JTYmRFZJgPPTAhkrZDG4zOQvhnal4Pk8ql8kq0tHP9PfC
         QBgoxumic2OPVK0BIkRl0MEz37cN+9c7/UsDLudeRBBwew7fV5DiY5yzyz4vapHEUlKn
         uxHQ==
X-Gm-Message-State: AOUpUlF257xLQ3y23k/lfY2bz7uc2kg5Y82wGDAnBUcTXOjXzcjchJpX
        Mv6OrGNxHoArYKU5w9mklt0=
X-Google-Smtp-Source: AAOMgpdsaCYvznt8aaCNzcwuZ9m8X+8Tvu5WXJgsqGIuig68gC5whQwqLi88Q2Uxz7m4pNFLwqey0A==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr630385eds.292.1533162694946;
        Wed, 01 Aug 2018 15:31:34 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id c34-v6sm519699edc.71.2018.08.01.15.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:31:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com> <87k1p9u860.fsf@evledraar.gmail.com> <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 02 Aug 2018 00:31:33 +0200
Message-ID: <87h8kdu3ay.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 01 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +		  /* N_() will get "<>" around, resulting in "<refname>:<expect>" */
>>
>> ...but this comment isn't accurate at all, N_() doesn't wrap the string
>> with <>'s, as can be seen by applying this patch:
>
> I know.  It is a short-hand for "what's inside N_() we see here".
> Try to come up with an equivalent that fits on a 80-char line.

I was going to say:

/* parse_options() will munge this to "<refname>:<expect>" */

or:

/* note: parse_options() will add surrounding <>'s for us */

or:

/* missing <>'s are not a bug, parse_options() adds them */

But looking at this again it looks like this whole thing should just be
replaced by:

    diff --git a/builtin/push.c b/builtin/push.c
    index 9cd8e8cd56..b8fa15c101 100644
    --- a/builtin/push.c
    +++ b/builtin/push.c
    @@ -558,9 +558,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
                    OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
                    OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
                    { OPTION_CALLBACK,
    -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
    +                 0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
                      N_("require old value of ref to be at this value"),
    -                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
    +                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
    +                 parseopt_push_cas_option },
                    { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
                            N_("control recursive pushing of submodules"),
                            PARSE_OPT_OPTARG, option_parse_recurse_submodules },

I.e. the reason this is confusing is because the code originally added
in 28f5d17611 ("remote.c: add command line option parser for
"--force-with-lease"", 2013-07-08) didn't use PARSE_OPT_LITERAL_ARGHELP,
which I also see is what read-tree etc. use already to not end up with
these double <>'s, see also 29f25d493c ("parse-options: add
PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).
