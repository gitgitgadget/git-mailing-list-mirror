Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6571F404
	for <e@80x24.org>; Sat, 24 Mar 2018 05:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbeCXFhM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 01:37:12 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:37128 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCXFhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 01:37:11 -0400
Received: by mail-lf0-f43.google.com with SMTP id m16-v6so17435645lfc.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sVfV6HsJgVtpgtb9rCkmo7hGiwLkPfR16Y0K3Bc2XQc=;
        b=hP/SuQKCYzAFQ/luk4Z6D7QpjjkQEFMmvxOkzlxYcjDd+fzjbOnfVEdJA1Aioh3aFQ
         pjjZ96BgyNir8Vo9zSP2X5AWQLuzy4dVuBmc4zvNxFs6MYR9rTP5LVKx7DSMmF6k4fB4
         MdyCv8a+brDSjzBEluulHecBA/GpHDhc2spLMyT2N2Bz98YFgWzJ8wyANAnTPH/Xzx1t
         u8jfRihTI587uNY3wxe+b8PRNi5w9PIEzCHz/sRSPs5/74cfuY8vOiQr81QAnMGfzQsi
         46w3cguCxjPYio8y0UZiS+c4NyAPm4ozcSY2cqHKa4Wb5t84FFKVhGOv6nvjRdWdSzfj
         r6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sVfV6HsJgVtpgtb9rCkmo7hGiwLkPfR16Y0K3Bc2XQc=;
        b=lf4E/zzuXdUICJgFVhCbxbskjY03t1QxjFWymXNNDSq802dyVinIAyqsfpY3jV4a6n
         Fr7qDmb3S3ArUjrkAOM+ZxnRocuf3DwyE0+WODlzBRsjQvlN9IDbEEGSd8p7M6PtgzEm
         Wf6eNjgRDCD/C2Gr8iypWiFqS4+YDbGqUu3/0lmgeLwfB22n548c0F3A1S+VH6INLOGn
         Ruyfsk+RKxVfFbHLt3piuCKrGZnaWMNWGVuNPM/mOTd47kz5pbVXAanP+cqeWAaB3jY8
         Aq6wlLgIOBx50qjsPIfNSRJOk/2ASXnaBaqBE75qtcXVZzUbl2fd8lIITBV2HP/rTXI4
         fGIg==
X-Gm-Message-State: AElRT7G0eQcIYhPHyLu82w6m2kTknj8kXsO9VOjV37B07OburVFKZHQM
        u6B/d2S2yJkuvX5dU77S47RwwZ1SQ3EDuRvikh8gbg==
X-Google-Smtp-Source: AIpwx49vGHy8FE5pgkzeMnjdP3uMp4gWoVVZRyOiXTQSupTsISxW2rCQ6GIpYIz/nocWS6EYUX3+E/uAQDtvtczStBE=
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr3475745lff.45.1521869830334;
 Fri, 23 Mar 2018 22:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 22:36:49
 -0700 (PDT)
In-Reply-To: <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com> <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 22:36:49 -0700
Message-ID: <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>, jeffhost@microsoft.com
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I queued everything (with all patch 3-8/8 retitled to share a
>> common prefix, so that "git shortlog" output would stay sane)
>> and I think I resolved the conflicts with Dscho's recreate-merges
>> topic correctly.  Please double check what will appear on 'pu' later
>> today.
>>
>> Thanks.
>>
>
> OK, thank you!

I looked at 'pu' and it LGTM, so I pushed 'pu' as a branch to my
github account to test with Travis-CI. All the linux builds are
green, but the 2 OSX builds are red[1] and the logs show compile
errors:

    CC ident.o
    CC json-writer.o

json-writer.c:123:38:  error:  format specifies type 'uintmax_t' (aka
'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
long long') [-Werror,-Wformat]

        strbuf_addf(&jw->json, ":%"PRIuMAX, value);
                                 ~~         ^~~~~
json-writer.c:228:37:  error:  format specifies type 'uintmax_t' (aka
'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
long long') [-Werror,-Wformat] [0m

        strbuf_addf(&jw->json, "%"PRIuMAX, value);
                                 ~~         ^~~~~
2 errors generated.
make: *** [json-writer.o] Error 1
make: *** Waiting for unfinished jobs....

[RFC Patch 1/1] changes the PRIuMax to PRIu64 to correct the compile error
and now Travis-CI is green [2].

[1]: https://travis-ci.org/winksaville/git/builds/357660624
[2]: https://travis-ci.org/winksaville/git/builds/357681929

-- Wink
