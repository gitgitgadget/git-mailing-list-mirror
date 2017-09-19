Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A882090B
	for <e@80x24.org>; Tue, 19 Sep 2017 08:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdISIF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 04:05:58 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:56487 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdISIF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 04:05:57 -0400
Received: by mail-io0-f176.google.com with SMTP id m103so8022761iod.13
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7i0eY9bwglOMnXvOOa/OixjB+cz8WyFVMbT1AMP7jXs=;
        b=EMQ8l4Gy04jBVJSFy35UJYcUSwfUeO7NeWkKN4hQwYR7+I16RN4tCrsdvO6jiEbUBZ
         OMRJtxj5UIYkWmpTWMnO2+UhzmV5LV7H4Bnl31lNKq1jFsFoqRDOSc1XQXoxbyC6lIUV
         yYIl1ZSHFo9XnEeLOcQqjiC8n1hMnQA+t65rpWUBcUQm3vimLNNefzkyUmHF/JhppylU
         0sIxcwXSHd7NjhETsl3K544jsAMGodhl3N8ylFkBz2l9WcMPWY0iO910dJrS5yHcEDZt
         ZA/uwVDqmewwcLV0FeWlB8VO/gJHFZaqCLCtwWak0MJ3k1icaZHWz44OaAM0qRI5TlVz
         XQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7i0eY9bwglOMnXvOOa/OixjB+cz8WyFVMbT1AMP7jXs=;
        b=uSux7hIXOsre7EvQkd2IMzib2V4K5ZCjnnDcNvyxu/LMHqOv3OeladY/u/Coi5bHNU
         3hiatwHIIGOjQJqcoWqbK7fqJ4OkgkGshqTu20vJjYM+rtx1Zkg2bNYJ1ueMJDjAN6ul
         7t2GzIHhfcON/1ZtAP/LG+c2bChrCH5g5TKEU7pTqDHi2OC2I0naSkYWI14ePSst5VRG
         31hwcmMDTJ5KrWSf1fXK26jE9gjwzGB2PErzHrXxMMHmBRWnqjPQa3qbSjzIK+Ed0iGB
         Wc7L+tIGHgMA3sUeL0Bv+2NO5nRO/L40qgNm96aeIuEVjT71zrRmttXLxlue0HeEqv4N
         N5rw==
X-Gm-Message-State: AHPjjUjju6SmdqN/bBB5Ck0P28okdlHt5Q6EwLug6BJaDSret61zu5Cv
        GFjqcdE1hILFIWsVU7QUNMND2szwVQasn2qBdGQ=
X-Google-Smtp-Source: AOwi7QB1QwLrQCPiNV1NwEENPJue+wb0IOFGz87MT2HPOS6pumH8/4Yint40pOHaOdC4+1kwko/mo8G83idmpj/uOT8=
X-Received: by 10.107.137.96 with SMTP id l93mr720809iod.138.1505808356766;
 Tue, 19 Sep 2017 01:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Tue, 19 Sep 2017 01:05:56 -0700 (PDT)
In-Reply-To: <CAL21Bm=e9C4ANTsc4n1BG3xqjCJmORDSPcS5QEXYKUkK3cAH6w@mail.gmail.com>
References: <CAL21Bm=e9C4ANTsc4n1BG3xqjCJmORDSPcS5QEXYKUkK3cAH6w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Sep 2017 10:05:56 +0200
Message-ID: <CAP8UFD3vPQHJZNt1+egKkshiyqrGKiJp7eWU-Es6bTLgvXe1Kg@mail.gmail.com>
Subject: Re: My first contribution
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olga,

On Tue, Sep 19, 2017 at 8:44 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> Hello Jeff,
> I want to try myself into new role of a Git contributor.

Welcome to Git!

> All of the projects sound super interesting for me and I am ready to take
> part in all of them, but the project "Unifying Git's format languages" wi=
ll
> be super useful for me myself, so my dream is to try solve that task firs=
t.

Great that you found a project you like!

> I need help to choose my first task in the project, because first steps a=
re
> usually the most frightening.
> I am familiar enough with C and there's no problem to read any docs, but
> please help me choosing the first task. If you have any guidance like "ho=
w
> to start" or "how to choose tasks", please send that links also.

You can try to work first on the project you are interested in or you
can find and work on a small project first.

One way to find a small project is to see what people are
talking about on the mailing list[1]. Quite often there are bugs
that can be fixed, and more experienced people may help sketch out
a solution. You can also find small items good for newcomers marked
with the "leftoverbits" tag, which you can search for in the
mailing list[2].

We don't have a written guide specifically downloading git, getting it
built, running the tests, and so forth, but you might start with:

       git clone https://github.com/git/git

and reading the INSTALL file.

As the mailing list can be a bit intimidating at first, we don't mind
working with you one-on-one a bit during the application period.

About the mailing list, please add [Outreachy] in the subject to make
it clear that you are applying for the Outreachy program.

While at it on the Git mailing list we are used to replying to parts
of message after those parts. We don't usually reply before the
message. In other words we are used to "inline replying", not "top
posting" (see https://en.wikipedia.org/wiki/Posting_style). Please try
to use the same posting style as us, it will help keep discussions
more standard and easier to understand.

Also we feel free to remove parts of the messages we are quoting that
are not relevant anymore.

For getting in touch with us, direct email is our preferred method. We
could also meet on IRC if you like, but it looks like our timezones
might not overlap much. Still, we can probably set up a time.

Let us know if you have any questions at all. This is our first time
mentoring for Outreachy, so we've surely forgotten to mention some
obvious thing you would want to know. :)

Thanks,
Christian.

[1] There are details of the list at https://git-scm.com/community,
    but you may want to just browse the archive at:

      https://public-inbox.org/git

[2] https://public-inbox.org/git/?q=3Dleftoverbits
