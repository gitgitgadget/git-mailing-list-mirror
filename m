Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE4D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfAVUab (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:30:31 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:34911 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVUab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:30:31 -0500
Received: by mail-vs1-f50.google.com with SMTP id e7so15562516vsc.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=os8Pae4GMo07PlHWtbyX5nfK2omT5bfNUZy+h9LUJxU=;
        b=rIkH5V5+kkOjVnTgXbAtv5/IFe8JBAd0mhrtoU4jUq7nX/+s2KesCO7fruQN9dLiQK
         e+oP4J/obrC63cskBaneWNDgiBN+Ne70CYraV03fQw76HdbYNzWRaiM8zrDd0vpgyxmX
         knmUE23kl4utH2EFcN++BWe2aowC6i/a/1m2s4hawQLkKgfbj+J7u53nTVh5iMQ5fFoe
         4/5aU6LcIYN8yG17RCZ5bdWX5jKGfkZUJcybAshpY66JKpSIaggV1p1MrcbjbW96MtJr
         VupgsRyGCn+VgXSKfVTLuP5t8B9JFFufSHOCZGpWdwH6HThGQyXlRbCvfqPvzLQGSVzF
         l9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=os8Pae4GMo07PlHWtbyX5nfK2omT5bfNUZy+h9LUJxU=;
        b=Ga4Zm0t8ObwaG72Pa0dwAd3Tp0+8AjwciK71vY2V7McfGk/JqWJ/PQszzPFv9DZpLo
         YtOqY4M8D9DJEaVK2aaPWRS81fz+QznH8Ni53aq600x5P7VMPJgEHTWS+wADeeXk2W4V
         RtLCAYTe/RZE/A+HQioAJ8AppbUX7pOlIDE8TttIU0pFsCV/p4d+KM88TAsqj5JzVB4h
         CK69DQlqXytrs5gZfGc2SdEapOSb4QyGewD0t1cmQuUD/8s/WpuZ0rt5Uz0+9T6gHmvF
         8t7jiiLrCmqX+a0XsdHG///+mc4Kf2+q2SORjiidvYAhbHR2/V67veeDrpPIJ1BzuhA6
         bXjg==
X-Gm-Message-State: AJcUukdLsLsa9zfT5uZRDzGx+R87cfgrXwVXS9LoeItkgVWQHz/u5//j
        SzkYHYdDcJyD6Hn20IcNPMOWEqgFOxh9ycWtwPQ=
X-Google-Smtp-Source: ALg8bN6JMLDWSPNtB50WIFydrlPdPKn7tu3aNB4J5O+Sump7AReCEXCnjSv+LnUnv/l7XJpKO0Dgk6W9NYjoA9mcRE4=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr14211723vsi.136.1548189030388;
 Tue, 22 Jan 2019 12:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net>
In-Reply-To: <20190122075027.GA29441@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jan 2019 12:30:17 -0800
Message-ID: <CABPp-BE9vTw8vsn=c=wNoTyU6Sg_n4YGEXnGGcFDHRt9Uo5mOg@mail.gmail.com>
Subject: Re: Contributor Summit Topics and Logistics
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 11:52 PM Jeff King <peff@peff.net> wrote:
>
> The Git Merge Contributor Summit is a little over a week away. If you're
> interested in coming but haven't signed up, please do! We have a few
> spaces available still. Details are in the previous announcement:
>
>   http://public-inbox.org/git/20181206094805.GA1398@sigill.intra.peff.net/
>
> There's no set agenda; we'll decide what to discuss that day. But if
> anybody would like to mention topics they are interested in (whether you
> want to present on them, or just have an open discussion), please do so
> here. A little advance notice can help people prepare more for the
> discussions.

* git repo-filter[1] or whatever it ends up being named (filter-branch
alternative): is it wanted in git.git?

* merge-recursive rewrite -- steps others want to see me take in that process?

* Making --merge option of rebase be the default[2]: what steps need
to be taken?

* I'll second Derrick's request for partial clone, perhaps also
briefly discuss related capabilities like sparse checkouts and partial
indexes too?



[1] https://public-inbox.org/git/20181111062312.16342-1-newren@gmail.com/
[2] https://public-inbox.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
