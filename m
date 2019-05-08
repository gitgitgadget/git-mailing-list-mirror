Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A4D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfEHTxa (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:53:30 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33154 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfEHTxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:53:30 -0400
Received: by mail-ua1-f74.google.com with SMTP id h6so2900145uab.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XIGt/8MUN32LOjPLtS5lPCe1ewQhhKCzCSQkKW+Iy7w=;
        b=d82RrMJnXBuyD4T0eVvRD8EkzuoqiyaSNIpiOPqwrPQOCgVkEPhM8R7L8rEk9cYtPh
         kR5523RFZUO95ILp3EKwQ3fRp0uhz6mcL0XIV+SZ8/9h31TVW+LqxHu26gA4a52v4ZXO
         ulA1u2to7pUIvgKDwndFsMCrJYhZO4XmdV7yu02qpk2K7t3chiAtryHpiw8RJcgc3ij5
         tOmKshsA8iwEM7Ir3nmTlQ6Oux8QgkXhmVF496oZ6gd9zsYc5uOS6okwNZ/qLeIYJ20q
         +yDa1mqz/JTXd8JZivmfqe5p3yHLIAC/NyEb4lBe1AIWzDApNUgj5dNkN6jgTub/9R4A
         CSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XIGt/8MUN32LOjPLtS5lPCe1ewQhhKCzCSQkKW+Iy7w=;
        b=Iuzwm7EmBmhnW7l6RZ1PMVyK4ULMrliVGPiXwWk8d2KVzymJRnuSJhmQ3lo65tom8b
         g4qQqHJMQvuqNFuqOTlpPESvio4aMlMy57PBSRkaW7eBgTnfUSGU7zq2yHQflyP96jZr
         Cuu8s/q3bTda7Wf/4/fUWeXXPTT5e5MSgi5GGpGDpiG/MyJYhB4QR8ZLJ2Qq2lBvE/8x
         8eFWiuphOAsm4v8vNM0MShmCREgHYEuMF4PF270Jkik1ASdQgFUwry1RaHWRPOw7ZIcp
         P0vgWvitAiJlmbI3r/QygfEkVPToE3gUgNACeB7IWAqebDS5sqqVr6yuW4+yQRX8gVUM
         umng==
X-Gm-Message-State: APjAAAVYuOUl9IoJqc97jArrCthD40ehzeGoeEWsjsg4veUH8kYFr5jR
        oWTDA+PQL/z+ecEKvzsDwb/i2wQPnJNBOXXRDtI8
X-Google-Smtp-Source: APXvYqxqv6T7euce+9hvQklrE9LB+c9k3aVcoR3kSamObmRW9fUhcT2Kdg+AGDU8oOZb9JAXJajjNtCYv3HSe9DUg05p
X-Received: by 2002:a1f:cd1:: with SMTP id 200mr21673749vkm.62.1557345208630;
 Wed, 08 May 2019 12:53:28 -0700 (PDT)
Date:   Wed,  8 May 2019 12:53:25 -0700
In-Reply-To: <20190508185807.GA14000@google.com>
Message-Id: <20190508195325.98698-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190508185807.GA14000@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: [PATCH v5 1/2] documentation: add tutorial for first contribution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > And "official" is a phrase I have trouble with in this context.  A
> > mirror does not have to be blessed as official; that's the point of
> > a mirror---anybody can make one to help users with better
> > connectivity or availability, as long as its users trust the mirror
> > maintainer for mirror's correctness and freshness.
> 
> You're right and I'll remove it. However, I've seen at least one
> instance of confusion over Git's lack of an "official" mirror (over on
> #git on Freenode). I'd like to rephrase this to explain the reasoning
> behind having multiple mirrors, none of which are official.
> 
> To that end, I propose replacing the phrase with "one of the best places
> to clone from is this mirror on GitHub." followed by the clone command
> to git/git, then followed by:
> 
> 	NOTE: As Git is a distributed version control, the Git project also
> 	follows a distributed model. There is no central official mirror; any
> 	mirror which you can reasonably trust is being kept correct and fresh to
> 	the Git source distributed by the Git maintainer is fine to work from.
> 
> What do we think?

In the interest of avoiding mailing list churn, I think we should not
bother with explaining what an "official" mirror is right now, as long
as we already have steps that a newcomer can take (which we do). Someone
else can add it later if they wish.

For me, the "official" mirrors are whatever is listed in the latest "A
note from the maintainer" (e.g. [1]). Even if we want to link to this or
replicate part of its contents, I think we can do it after this patch is
merged.

(Also, with that paragraph, I don't think a newcomer should be expected
to know what mirror is reasonably trusted.)

[1] https://public-inbox.org/git/xmqqwolmcvyb.fsf@gitster-ct.c.googlers.com/

> Alternatively, if the desire is to just be done with it, I have no
> problem with Junio rewording however he feels is best and otherwise
> applying this patch - if there is value in reducing the churn on the
> mailing list for this patch.

This sounds good to me too.
