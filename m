Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FAE20372
	for <e@80x24.org>; Thu, 12 Oct 2017 14:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbdJLO7u (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 10:59:50 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:50633 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdJLO7t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 10:59:49 -0400
Received: by mail-qk0-f175.google.com with SMTP id o187so1541688qke.7
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5ZXJOIwXWt101lLgWmIdc4KuZd4EukVtW6DMG6mYgZI=;
        b=bQoIKpuAWLhy4eibMgVhG+EedTUOMAUkSNxC9YUDuREA2HM1+ADvzMBwXDsUAyiYeo
         CuJPqx8s/yz/l+SkYPvqvNAsy/21NtQlwOEfJd6p6BtcKPLrYkrk2Z+6wEeBRb/OMqat
         duxOqUGgV1GfVf5ACXWBm/lYokLsrJQvsBhnMWArjHxFqjQg7wqM5qsXZL3uImwbhZQZ
         AKU4+AvAkIxrLtHoF5qEi1pum9AKizhOP1bV3jJ0o4cy9FMxhSWxXGv6cyIhJh55gMp8
         Z1lK7Ah8SavwWslzewTWwjKuetLw+qjrj+MRZLuWsNwQJiha8ZA8D4zFQoUJmt2WyvTz
         bMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5ZXJOIwXWt101lLgWmIdc4KuZd4EukVtW6DMG6mYgZI=;
        b=kTS/5T5V+Xk5iNqXhBiAg67qg0it+UHThP5dygx28NLp01q9racLr+HsMrMNESXcWk
         KDMVeyp7ozoz1g5ofuFPJnJRI3hsXI2kft0z5QtAQfsYsFjvl7npFhoFTLm3UqD6b9jl
         IBAs0uSPXPuDeYgI/ZG1hktC49VrSUP0+9sufMnzwc/96DSpYXel3dh9FEFw39i4iu0d
         Q9EbNGCmxL1iZEp35TxNGjoJqEquHCnc9DKGpxyMGHdLJxq4y9j6nZUSs0eLjKCGCEj8
         hhHXQ9rzmbv/kLZliyJEZvH6k5PUJCJ0/xudmRJ2eTUEhMLxC9kXeMqvhTNk3tx1yrCj
         MpFg==
X-Gm-Message-State: AMCzsaXCx6EUYDt4PzKf3/zyleFJbwb+hWdEFxXIp2X6VS6iQgek7BCD
        SpRJuOgzeK7hNWqjCc7BglLRnhYexxRqL5fQwsE=
X-Google-Smtp-Source: ABhQp+T0v0NP600JFUGoR3Q4AIedgLqsTM9KeWA+wm6tRA617CfrFLn2Oklft10ESRW6Ssp8IA7yT7uMqEAyZGAH+88=
X-Received: by 10.55.75.15 with SMTP id y15mr792669qka.321.1507820388121; Thu,
 12 Oct 2017 07:59:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Thu, 12 Oct 2017 07:59:47 -0700 (PDT)
In-Reply-To: <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com> <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Thu, 12 Oct 2017 16:59:47 +0200
Message-ID: <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        christian.couder@gmail.com, peff@peff.net,
        thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your coments and explanation.

Just one thing:

>  - After parse_options() returns to cmd_push(), see if push_options
>    is empty.  If it is, you did not get any command line option, so
>    override it with what you collected in the "from-config" string
>    list.  Otherwise, do not even look at "from-config" string list.

The idea is that there are default push options (read from config) that are
always sent to the server and you can add (not overwrite) additional by
specifying "--push-option".
So I would rather concatenate both lists - from command line and from-config.

> By the way, I really hate "push.optiondefault" as the variable
> name.  The "default" part is obvious and there is no need to say it,
> as the configuration variables are there to give the default to what
> we would normally give from the command line.  Rather, you should
> say for which option (there are many options "git push" takes) this
> variable gives the default.  Perhaps "push.pushOption" is a much
> better name; I am sure people can come up with even better ones,
> though ;-)

In the light of the above the "default" may be correct, but I don't
have a problem
with any name.

Marius


2017-10-11 15:38 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Marius Paliga <marius.paliga@gmail.com> writes:
>
>> @@ -505,6 +509,12 @@ static int git_push_config(const char *k, const
>> char *v, void *cb)
>>          recurse_submodules = val;
>>      }
>>
>> +    default_push_options = git_config_get_value_multi("push.optiondefault");
>> +    if (default_push_options)
>> +        for_each_string_list_item(item, default_push_options)
>> +            if (!string_list_has_string(&push_options, item->string))
>> +                string_list_append(&push_options, item->string);
>> +
>>      return git_default_config(k, v, NULL);
>>  }
>
> Sorry for not catching this earlier, but git_config_get_value* call
> inside git_push_config() is just wrong.
>
> There are two styles of configuration parsing.  The original (and
> still perfectly valid) way is to call git_config() with a callback
> function like git_push_config().  Under this style, the config files
> are read from lower-priority to higher-priority ones, and the
> callback function is called once for each entry found, with <key, value>
> pair and the callback specific opaque data.  One way to add the
> parsing of a new variable like push.optiondefault is to add
>
>         if (!strcmp(k, "push.optiondefault") {
>                 ... handle one "[push] optiondefault" entry here ...
>                 return 0;
>         }
>
> to the function.
>
> An alternate way is to use git_config_get_* functions _outside_
> callback of git_config().  This is a newer invention.  Your call to
> git_config_get_value_multi() will scan all configuration files and
> returns _all_  entries for the given variable at once.
>
> When there is already a callback style parser, in general, it is
> cleaner to simply piggy-back on it, instead of reading variables
> independently using git_config_get_* functions.  When there isn't a
> callback style parser, using either style is OK.  It also is OK to
> switch to git_config_get_* altogether, rewriting the callback style
> parser, but I do not think it is warranted in this case, which adds
> just one variable.
>
> In any case, with the above code, you'll end up calling the
> git_config_get_* function and grabbing all the values for
> push.optiondefault for each and every configuration variable
> definition (count "git config -l | wc -l" to estimate how many times
> it will be called).  Which is probably not what you wanted to do.
>
> Also, watch out for how a configuration variable defined like below
> is reported to either of the above two styles:
>
>         [push]  optiondefault
>
>  - To a git_config() callback function like git_push_config(), such
>    an entry is called with k=="push.optiondefault", v==NULL.
>
>  - git_config_get_value_multi() would return a string-list element
>    with the string set to NULL to signal that one value is NULL
>    (i.e. it is different from "[push] optiondefault = ").
>
> I suspect that with your code, we'd hit
>
>         if (strchr(item->string, '\n'))
>
> and end up dereferencing NULL right there.
>
>> @@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
>> char *prefix)
>>      int push_cert = -1;
>>      int rc;
>>      const char *repo = NULL;    /* default repository */
>> -    struct string_list push_options = STRING_LIST_INIT_DUP;
>>      const struct string_list_item *item;
>>
>>      struct option options[] = {
>
> Also, I suspect that this code does not allow the command line
> option to override the default set in the configuration file.
> OPT_STRING_LIST() appends to the &push_options string list without
> first clearing it, and you are pre-populating the list while reading
> the configuration, so the values taken from the command line will
> only add to them.
>
> The right way to do this would probably be:
>
>  - Do not muck with push_options in cmd_push().
>
>  - Prepare another string list, push_options_from_config, that is
>    file-scope global.
>
>  - In git_push_config(), do not call get_multi; instead react to a
>    call with k=="push.optionsdefault" and
>
>    - reject if "v" is NULL, with "return config_error_nonbool(k);"
>
>    - otherwise, append "v" to the "from-config" string list--do not
>      attempt to dedup or sort.
>
>    - if "v" is an empty string, clear the "from-config" list.
>
>  - After parse_options() returns to cmd_push(), see if push_options
>    is empty.  If it is, you did not get any command line option, so
>    override it with what you collected in the "from-config" string
>    list.  Otherwise, do not even look at "from-config" string list.
>
> By the way, I really hate "push.optiondefault" as the variable
> name.  The "default" part is obvious and there is no need to say it,
> as the configuration variables are there to give the default to what
> we would normally give from the command line.  Rather, you should
> say for which option (there are many options "git push" takes) this
> variable gives the default.  Perhaps "push.pushOption" is a much
> better name; I am sure people can come up with even better ones,
> though ;-)
>
