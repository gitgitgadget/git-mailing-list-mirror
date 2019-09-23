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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF491F463
	for <e@80x24.org>; Mon, 23 Sep 2019 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbfIWUsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 16:48:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52840 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfIWUsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 16:48:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id k68so19214702qkb.19
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrgQ0wixAqvvAuPMUdQCNgcMwCu4hIM4La4Y4OXKyro=;
        b=m32BMHPm8q+w2vKcODosi13xdMAM7oDsUplW2k/W5XctAkERNjM6hXuJBM5pYdeeFc
         0DecGv3EiJU+X9R0FOqCjDOrAScp8NCnbB6xp56RtBdodhOHs7f0M1l+mPvQ1p5E48xK
         2n/3ZAAdOIvvfNdCxQ6UvE+Fe8HoUGadjnGQzmAtYsG3CqdzDqPqGQKK//TETPCARTW0
         BfBG2VpeFD5xcS+AeatTHivJtnNOmrbYDHx6G6EANblsCSdPiGr1HnCHheBtPxETgmS4
         Hq1jwdP+823BWWjkxX3s/cJnMaqwqCUx5oBXfEjUgKAHXIoFXpAzoXLkWHSfX+ZH21rt
         rNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrgQ0wixAqvvAuPMUdQCNgcMwCu4hIM4La4Y4OXKyro=;
        b=Zeh1pastuokeVpU+XfVq3U8znfRJl73tVzqo8/vGtkSallMlr4vV61PD81r1T80q18
         qNjqvQLen1byaXD5sra0NnNU5kZc23jJvYTnzT4ONtFJmLAmX5HHew2m2WrnhLS3zQA9
         G54nf0GItvWyhtYy+BSsudUuslJMCd63KRwVf7BZTlB4Pc1MhdocW3Dm7WEn8ML8wrlP
         V2+Mnyp5eF8SuZYXfHkrygbuK6VEyjPydntchoyzDP3QuFy/vaaR5t+rJPTdgbZqEqra
         IGT5iGK/Lh4YBr4r5PhRIBuGYP7kWjnTpbdRBvF5THLsuYovSOK1647zBmovfpI1baSO
         JzGg==
X-Gm-Message-State: APjAAAXujSD6xhK3WBTRYiCFFF9yQYhC2MHc9QDSIdtKvUd259qL6j+2
        UI0Tb0ZZNEsz5qiMqwx/L6xmJmMfOZqpq6w88SLz
X-Google-Smtp-Source: APXvYqynvimnj+k4MmwvfSzZdwdzDnPx4iHeCqfFaWpCqWDiVq1VPvxU2F9IL8qgIafOyTLTbD0AKnZp9dF6NP2kPui/
X-Received: by 2002:ac8:3f79:: with SMTP id w54mr2061010qtk.324.1569271691216;
 Mon, 23 Sep 2019 13:48:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 13:48:07 -0700
In-Reply-To: <20190923192704.GD21344@sigill.intra.peff.net>
Message-Id: <20190923204807.173287-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190923192704.GD21344@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, christian.couder@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I approved this. I did leave some comments elsewhere in the thread, but
> I think we can continue to iterate on the idea.

Thanks.

> > There was a "How can applicants make a contribution to your project?"
> > question and a few questions about communication channels. I answered
> > them as best I could but if anyone has already answered them, it would
> > be great to just use the same answer everywhere. (I can't see all
> > project information of other projects since I haven't filled out a
> > "short initial application", but I don't think that applies to me.)
> 
> What you wrote there looks pretty good to me. Copying it here for
> purposes of discussion:
> 
> > Please introduce yourself on the public project chat:
> >
> > IRC - Follow this link to join this project's public chat. If you are
> > asked for username, pick any username! You will not need a password to
> > join this chat.
> >
> > Git mailing list - Follow this link to join this project's public
> > chat.
> 
> where the IRC link goes to Freenode's webchat, and the mailing list link
> goes to https://git-scm.com/community.

Thanks. For the record, most of the text is from Outreachy - I just
supplied the links.

> The other proposal is from Christian, who wrote:
> 
> > Please introduce yourself on the public project chat:
> >
> >     a mailing list - Once you join the project's communication
> >     channel, the mentors have some additional instructions for you to
> >     follow:
> > 
> >     Start the subject of your emails to the mailing list with "[Outreachy]" so that mentors and people interested in Outreachy can easily notice your emails.
> >     Follow this link to join this project's public chat.
> > 
> >     Send an email to majordomo@vger.kernel.org with "subscribe git" in
> >     the body of the email.
> 
> I think the "[Outreachy]" advice is good, and worth adding to yours. I
> think linking to the "community" page is a good idea for Christian's, as
> it has more tips on using the mailing list.

Good idea on the "[Outreachy]" - I've added it to my project as well.
