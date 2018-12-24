Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669E820A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbeLXK67 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 05:58:59 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35324 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXK67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 05:58:59 -0500
Received: by mail-ed1-f44.google.com with SMTP id x30so9849351edx.2
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mB2leEKgM0W0QnovgQY9qAL1Z5uQNP0IcQl8HFT1Bis=;
        b=jqqwH4I8V97/jQubEHH+zlyOBYkl+19h59kl4ONhXo1fM8s1sTkPGYoXMrTDKtL4ft
         fXCTHUZHvR8wSl88PVtOCAHNuceMDkRTK50xqS74p+5KEoAJw1GwJE+qyyWW2Evj0SCS
         ntNLHDXhzDyRLmACcxYlQE1CGGG4F/d++jqE0bf6CkaR17P9Yte9xt5dkwRWmnd8dNEh
         Evna+yPyqulN9QPWs9c4N2pYYdpF9VfTKiF+/CxGW9UCrMkVulxINy8TcNO5PStlCtrA
         8WTRXDi23D3zwLf3aq7KSrQsMeMgSsaxObydQIbWiiBcfIvhIZflR2ccJ0mYmEo0I8ob
         +ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mB2leEKgM0W0QnovgQY9qAL1Z5uQNP0IcQl8HFT1Bis=;
        b=EqXFsA/ZdvwlPcAHRF4I0R0edSSf6SNquSgrfXfeS1O3WTTGCR+uvwsHsmjuKv6dXj
         dkQQeOnqweGjjdGTHvZm+MO5DVuRgsyrLCWr+y65UjjCacfyRFSOxHYz9tPFlhWXgk/Z
         AfEm7c2XUjXpDKcJj6JuEeacIbJJz2kWPjV7HZ+jEsU2OiT6lynrBDaeLvXKNFFLxYSf
         yRiyiO0HV7C3GMuJeqYcQXjtDgd6Zrl+FQNd8M9Pu6N+945eubXeCJN4eSEvhTwFqZCB
         I7Cw/c0bPFW6bGozZ02pZxSLihXfdqZlDX3ZQsW1Kvngs73kqZZssJ0TLcWP2QleOdRk
         NLFw==
X-Gm-Message-State: AA+aEWZs4BK+l5l4xkHDcdGDKobPE2at9VHw/mlFdxstPOMTRZPjm8H7
        wSJZO4EL4fe9AdQ5BS5IPvd7uv9FvmoOzMTaWE0xaQ==
X-Google-Smtp-Source: AFSGD/VdTq1yZDpjg5GNMQu2p949ec8bEKBiayFEA9w5toah6nyaslTA/BWgrkA4Wvmp8hTIGO4WFBHEkwhNUojQBKM=
X-Received: by 2002:a50:e610:: with SMTP id y16mr10123458edm.163.1545649136481;
 Mon, 24 Dec 2018 02:58:56 -0800 (PST)
MIME-Version: 1.0
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
In-Reply-To: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Dec 2018 11:58:44 +0100
Message-ID: <CAP8UFD1ErRo7NQmCrAJLaELzV-1rKowyPsNCi3ecTqGN1qWxKQ@mail.gmail.com>
Subject: Re: Parsing trailers
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 23, 2018 at 11:44 PM William Chargin <wchargin@gmail.com> wrote:
>
> I'm interested in parsing the output of `git-interpret-trailers` in a
> script. I had hoped that the `--parse` option would make this easy, but
> it seems that the `trailer.separators` configuration option is used to
> specify both the input format (which separators may indicate a trailer)
> and the output format of `git interpret-trailers --parse`.

Yeah, but it can take many characters, not just one.
For example you might want to do something like:

seps=$(git config trailer.separators)
test -z "$seps" && seps=':'
git -c trailer.separators="|$seps" interpret-trailers --parse infile >outfile

So that the output uses '|' as a separator.

> Given that
> `trailer.separators` may contain any (non-NUL) characters, including
> whitespace, parsing the output is not straightforward.

Changing the default separator as shown above, should make it easier
to parse the result.
