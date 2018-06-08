Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4E61F403
	for <e@80x24.org>; Fri,  8 Jun 2018 23:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeFHXAl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 19:00:41 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36484 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbeFHXAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 19:00:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id v131-v6so6313023wma.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FEn9PPo39cNimIoyAd6H93fac7ABeNdxlOfE7U0Y7xQ=;
        b=SNspZtt3CNfS47kTVfSybXS6//ATfnPRwAURqRQNf0qKNIgenzkgNGWccSQOHw1uYK
         7aCAyDQ1KVbffckAfm9uKXmyKRJXkfQ5Ae3TS1FROUrULDzjp0inGFZIGJAjZo0QKoCf
         PlW24H40qROnSCYQtoeBxmT7JZgFDoC3mBY4IPrQ9ubgQpTHPpl0pqA5VDoRSWI1AijU
         ZK/PAAu1o1EbeZTDBJqdfeTwycy9UxhEy0DlQy1tZFCoO3wt1CzeQcHMqhOa98dLGfPB
         BvPCoja4jCrHmUGVONvuKHX1RppL3ftCcktyBAgDEJ1YINKfDPQRsjXgDPxVslJeRkdh
         NdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FEn9PPo39cNimIoyAd6H93fac7ABeNdxlOfE7U0Y7xQ=;
        b=DPn7prbtXZBbNfna0DvZTitbH/tvNtX8e900inHEvNQn15NkYtn7l7BQHpbJVOhDMl
         UdKWihatBfYazFLNp02VGyqitKROa57PUo3RmHdS2b1edi+HlkdGOVyXua1OZgE0H6An
         srmsA1EDOtN2bLkWBXUgYf0nBpfJtHbwmH6B0i0Pfy7Qp+Sl/WknUbCRqSdzORGcR0La
         awmnuMZzzEKIOwQVYP4WzGMD8fnS9YaG3vQkCLdRs3/GUktQACz8snMsENr5ZMtybgEl
         1NybUhBotWmCJuxlJfmrRpDnZB9QGinLzYg4CuHbHSxynnGNyTprYQIwYiklv21OmsW3
         TxCA==
X-Gm-Message-State: APt69E38EPDOVtkS1xOHgQFr4Xr5/6vYzfwcYbiDj6gERsQ2++KXPkKJ
        T9zlhiZx941sQ1Ot6SuxKvc=
X-Google-Smtp-Source: ADUXVKIAMgebJiw9eczcq4roX1z4Dnsl82O7HWSgQZukWwVybEJTHodoE+skgkyBXilZibQokyAVcA==
X-Received: by 2002:a50:93a5:: with SMTP id o34-v6mr8675076eda.291.1528498839297;
        Fri, 08 Jun 2018 16:00:39 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j16-v6sm10558434edp.22.2018.06.08.16.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 16:00:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>,
        Git Mailing List <git@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Joey Hess <id@joeyh.name>
Subject: Re: GDPR compliance best practices?
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <20180608224246.GC42503@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180608224246.GC42503@aiede.svl.corp.google.com>
Date:   Sat, 09 Jun 2018 01:00:37 +0200
Message-ID: <87d0x051ey.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 08 2018, Jonathan Nieder wrote:

> Separate from that legal context, though, I think it's an interesting
> feature request.  I don't think it goes far enough: I would like a way
> to erase arbitrary information from the history in a repository.  For
> example, if I accidentally check in an encryption key in my repository
> as content or a commit message, I would like a way to remove it,
> assuming that others who fetch from the same repo are willing to
> cooperate with me, of course (i.e. in place of the object, the server
> would store a placeholder and an _advisory_ token allowing clients to
> know (1) that this object was deleted, (2) what object to use instead,
> and (3) an explanatory note about why the deletion occured; clients
> could make whatever use of this information they choose).
>
> I've seen some discussion on this subject at
> https://www.mercurial-scm.org/pipermail/mercurial/2008-March/017802.html
> long ago and have some ideas of my own, but nothing concrete yet.
> Anyway, I thought it might be useful to get people's minds working on
> it.

You may find it interesting to look at how git-annex-forget does this:
https://git-annex.branchable.com/git-annex-forget/ &
http://git-annex.branchable.com/devblog/day_-4__forgetting/
