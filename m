Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5791F5A2
	for <e@80x24.org>; Mon, 18 Nov 2019 21:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRVp0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 16:45:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45523 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRVp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 16:45:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so8944031pgg.12
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Xv9JtGHufB5h1CigHiibUDn1EGTR8cDUxZeR5JevZA=;
        b=mrFnxY46ycoAZZzrF4YHg2MKVZslmET1VzynXiUvHDOOLR9wcOsg1G0UDJHcnn0Gns
         6o5MFwuqH1T6ulWGhFYDX9fQqaZmKT56d/i79Y/zExJ0w+sTpIgwWx8GstdqJqQH8htl
         OPLMo/dyDwSWIoZnUmi3N+8HMK2Un44b6x1cLMpzxtl6jYRpN2oDFxYj+C9n0RZjkuIS
         VMkvF7ACO8Bcake+Uw8fcrJuXS+2/0k2hbPUSmi6R0H0d/4fE+I3Gj9ahtBxEDsKawiu
         f01j2Pngviah9X5hS4596/xoyheYmxZYuX2gRf2oQQUXjfHBxy0Tuyqd63dYNyXoQASt
         /OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Xv9JtGHufB5h1CigHiibUDn1EGTR8cDUxZeR5JevZA=;
        b=mEGgZ4G+7ftfJSPDGTXRLg64bQ7Wp8aB+PYIUuEa4YGXfOVIajLLY+TY2pRLLSwSti
         FZFu/ZoBoXC+nFipHD5pdT1ihW77TB9RIdBGVDNWZkKpJLvnrdYItg6eTMcuRl7IVUkV
         vRC7ErQjS59jPRl6Cv/JXIeFh+r7OPJOJYOWlrWX3wBsP5K+nOVHqPev5sdPSb8f4Nvm
         lD9kUwwAPZ5TLhLGhNttcilmiEyPf06vCmakN1EFsPEKoGUvgM2fM7qvJewLWPafWZeP
         NTTSqQZ4DEk5fwha8+PcImcrlamzYlu34HmDAyNA5lhjGibRrVMBduZz3MO04rMsaLCH
         RDoQ==
X-Gm-Message-State: APjAAAXpnlPuyOoHb5jRPfqRXujhp9Swl7k7uIKLaJ2ZTwo2bIZyr1y0
        icwrX5ST5A12h9IumeQ4dEA6AiS5wug=
X-Google-Smtp-Source: APXvYqwdEDJPtZnn1KAsLXnje8koKMC9qyjtojeOlUtcmjZ4PWTchYArq3I9oBsxCLQLjsmyEBHcHw==
X-Received: by 2002:a62:b611:: with SMTP id j17mr1541746pff.201.1574113525250;
        Mon, 18 Nov 2019 13:45:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b21sm21243902pgs.35.2019.11.18.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:45:24 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:45:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191118214519.GH22855@google.com>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 12:05:45PM +0900, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +[[getting-help]]
> > +=== Getting Help
> > +
> > +If you get stuck, you can seek help in the following places.
> 
> Is this list meant to be an exhaustive list of authoritative
> sources?

To the best of my knowledge, as applicable, yeah.

> IOW, are we reasonably sure that some of us would be
> around and give useful help, and that we do not mind readers to
> consider these places "officially endorsed by the project"?

Right. That's my hope. I worry that sending newbies to non-endorsed
places for help will lead to them getting incorrect or conflicting help.

> 
> Or is this meant to be a list of reasonably well-known places, but
> may include places where the project does not want to be associated
> with the quality of answers given there?  

No.

> I am (implicitly) assuming that it is the former, but I think it is
> better to clarify what this "list of places" is meant to be.

I'll try to fudge the language so that it implies these are official
channels for getting help.

> I notice that stack overflow is missing in this list.  Intended?
> Not that I visit there at all nor I would recommend it, but I recall
> seeing questions asked by more than a few people after getting bad
> pieces of advice there.

Hm. SO for getting help contributing to a specific project? That doesn't
sound like a likely avenue or a good idea to me, since my understanding
is that we don't consider it an "official presence" (some projects do, I
guess).

I suppose the kinds of questions I expect to see on StackOverflow
include "How do I write a mutex lock in C" or "How do I generate patches
with a cover letter", not "I'm stuck on this Git tutorial" or "Would the
Git project welcome X change". To me, this doesn't seem like the place
to bring it up one way or another.

> 
> > +==== https://public-inbox.org/git[git@vger.kernel.org]
> > +
> > +This is the main Git project mailing list where code reviews, version
> > +announcements, design discussions, and more take place. If you fail to receive
> > +help via the channels above, you can ask your question here. The Git list
> > +requires plain-text-only emails and prefers inline and bottom-posting when
> > +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> > +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> > +"subscribe git" in the body.
> 
> Sounds good; I agree with Denton, especially with the mention of
> "you must join" on the other mailing list, that it is a good idea to
> explicitly say that subscription is optional in this entry.
> 
> You can ask questions even if you haven't tried other avenues and
> failed, but this entry makes it sound as if an earlier failure
> elsewhere is a prerequisite for asking for help here.

I envision an exchange sort of like this:

Newbie to git@vger.kernel.org: "I'm having trouble compiling Git and I
want to write a patch, I'm getting X error"

Veteran to Newbie, cc git-mentoring, bcc git@vger.kernel.org:
"Please build with blah flag and paste console output, plus let us know
system information blah blah blah"

I don't mind the idea of pushing folks to ask on the mentoring list
first. It's pretty well attended already - just now I count 16 list
members, a pretty significant majority of which are project veterans. I
have no problem suggesting newbies ask their questions, which others
probably had and solved before them, in a space separate from the main
mailing list.

Of course if you want to encourage newbies to ask in any of these three
venues, weighted equally, I can change the language. But suggesting the
main list as a last resort was intentional.

 - Emily
