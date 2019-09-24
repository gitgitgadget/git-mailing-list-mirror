Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01A21F463
	for <e@80x24.org>; Tue, 24 Sep 2019 23:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439238AbfIXXxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 19:53:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43140 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388576AbfIXXxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 19:53:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so3646715qke.10
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/371iyQvPTtVUGLd9RoofFLAp4Ozr7YMyyMfWA4LXw=;
        b=F9AD7ybu/mq1V+/7zefWeiwjRkmy38MA7dgVT1KuaFjOetCseGwRHaUPu9WnscXrE0
         C9btBWxVgKcjCH24vheRVdYSKa3H8XgeCfRLrOiWFJ7Vy6Y1FRr+Bn1LTz9DgeHG0pa9
         r93meI3DM6Jl6/K1Pto7KR6KMW0F/pG9r1yCgKxhJfIlTsnOcz3/wUD4TcNrCjEPwnAA
         wrGiQmGPpS1EwNhhD4wls/zQQdTuYrfP36mxdzslqluuprtmFTCXMsA0MDu7yNtBi+hB
         98O8vhSw7w9YP6Iu9t9aFZh90genUjgJCLfR/WKjKnNVWElt40EN5drJZenprTjmkuLJ
         zouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/371iyQvPTtVUGLd9RoofFLAp4Ozr7YMyyMfWA4LXw=;
        b=f3w/cj6W2idQQCAR8i8Kply76tW/OZ4wvSvw/XMXodipxHmR6/ofloPucFAOy1S4rJ
         yxw9KND8DRDQi/BRnKspGY4aiW3IEeyKuzd9Q4tMcJb/5NAZLibUb7+sGhlLpfWrxzBE
         WH7kpWZeoN6bNBxq4ToMuGr3oaLsd3wW3NCg/VJWbilJdQf+hIrWSYrYMDao0xRuz1Tr
         /zA97EiNZ+zmDhENemlSAZIqnAWArTctoyeLF0OpwtQuoD9mtbyB2iNMe5lWtZTFG+dz
         1MaiudU3BiHujjCCgiZPjpdRft8qj1kc3VJPt2ZctYxjyieKjik7mnS06gbQkRzmPUCq
         mZRQ==
X-Gm-Message-State: APjAAAXNZS9i9avN1VktaL3l4Ui/zd3ScVxv7BrGpFlTymCez/mzlQmm
        biYHo6rXIIs4ju8SdLFEjbvuwAPqyQvmh9FT6bNBW8KZbozESw==
X-Google-Smtp-Source: APXvYqzTnX0/b/xHvgmWJcLqmqm/83EG1S1PAAeTCTZcwt+YaQdS6GaUVSpPdkLxt9SwguMebzQIoYv0CPA3xeQ9q/M=
X-Received: by 2002:a37:a409:: with SMTP id n9mr721010qke.485.1569369187617;
 Tue, 24 Sep 2019 16:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190924064454.GA30419@sigill.intra.peff.net> <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
In-Reply-To: <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 24 Sep 2019 16:52:56 -0700
Message-ID: <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
Subject: Re: [PATCH] add a Code of Conduct document
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I've cc'd git@sfconservancy.org here, because I think it's important for
> > all of the project committee members to endorse it (and because the
> > document puts us on the hook for enforcing it!).
>
> I tried looking it up but I couldn't find who the project committee
> members are. Is this list published anywhere? More on that later...

To be honest, I'm a little worried about it too. What if I have a
problem with someone on the project committee? What if I have a
problem with someone I don't know is on the project committee?

I helped my other FOSS project to adopt a Code of Conduct earlier in
the year (https://github.com/openbmc/docs/blob/master/code-of-conduct.md)
and we got around this by asking for volunteers from the technical
steering committee to agree to have their contact info listed on the
escalation path; at the end of the escalation path we also listed
someone external to the project (which we were able to do because we
had been adopted by the Linux Foundation, and they have someone for
that).

A possible con of being on this escalation path is having your name
and contact info outed to trolls as a supporter of something
controversial like a code of conduct. However, I'd argue that the
growing list of ACKs on this thread expose us in a similar way. On the
other side, the benefit of having a transparent escalation path like
this is that you can bypass a problematic individual who may be in a
position of power. It also provides an opportunity for increased
discretion in delicate situations like the example Peff gave
downthread.

[snip...]

While I'd feel more comfortable with a "menu" of folks I could
escalate a concern to in private, I otherwise like this document and
agree with sentiment elsewhere in the list that it will not change the
way the project behaves now - only write down the current state. ACK
from me.
