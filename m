Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548601F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfHGRpA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:45:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39111 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGRpA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:45:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so89155886qtu.6
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcyIM6XZ4z3CgpT45DTOahpz62uM0tTz17SH8RH89gg=;
        b=DmcVyn199O+hjplrDwcwYuZcM2gBlWBRf0z7quKrFp17LH4oBVyV6F/DUOkvltZuXS
         UhIeUzmdDFpcbCJdT4iEXM07siFgqd7URqxTkMYBeJST90z4JnINTui9fQF5uwYeKvwG
         PzlyZtLg5G0LYrO/1UG4RWEjL+FnNb2Dw5duXHua8JcWfRo+OhUhiLc4t8eCafEqECgC
         W6XwRS45dxt7BG6jafEPaLARWOr7VWQiR5NNXDnCzUmO/xs96NsVWxb/IFAWnaU+SqWK
         VjmV7BC+hxN5Q23oGgp6PeFiF8UE8wtAspA0Q78brifTe9zuO87DfODMrRLV/6yzpXt4
         V+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcyIM6XZ4z3CgpT45DTOahpz62uM0tTz17SH8RH89gg=;
        b=C1rYceu8axt+6pkxmXhVR/tjncUEVWnkJzfCppSeHY9ZRhLjNLTxFBNmiReQqQU03+
         I022WVYsXv9d8CROKa9jHE1xHdBlzYH25gz5OMrdnqxYOHeS3xI9O6g3DjNITOMU9bGA
         T4Ub9R9fU/DwsqamU3jRkSZ31zCL2sOMlsq9tmoAmqv2m6vFQFu+MZ079T0Y5KA2Vpzy
         xUGlluFAvQ6fR1kuxMPOnJaN8r1N1lVITbgvnZJVIim3vIYukQ2I2LLCeQgav6NwGYp/
         KX2Pc0iI+2wQlJAuqNboXbCRl4Ox4BAYbmU1PrTKVG22rBHWegQdTJm6rbIW6xGVo4uM
         IFkw==
X-Gm-Message-State: APjAAAVnyl4c5MMABB1x8p0ddVYDQrimRhCMPvfGW73mm+hGtTtHizHj
        jxfS035/poE6b1RyAaPi4dUVwctBhfi2+FXO
X-Google-Smtp-Source: APXvYqzQE/+LnXeyU0qBQS+KmuBPTiEtLnN0Z4NJfakdROtlDebQC5dwYLOuF4ldLSTfd1ilyxuSJA==
X-Received: by 2002:a0c:d4eb:: with SMTP id y40mr9159961qvh.30.1565199899119;
        Wed, 07 Aug 2019 10:44:59 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id u4sm39583429qkb.16.2019.08.07.10.44.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:44:58 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:44:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190807174457.GA62589@syl.local>
References: <20190806014935.GA26909@google.com>
 <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
 <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
 <20190807170735.GA61464@syl.local>
 <xmqqef1wj3r4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef1wj3r4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 10:15:43AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> It would also be helpful to have a post for every major release
> >> highlighting new features and giving users examples of how to use them.
> >> Taylor has been writing these on the GitHub blog [1], but maybe he
> >> would be interested in writing them for this new venue?
> >>
> >> [1] https://github.blog/2019-06-07-highlights-from-git-2-22/
> >
> > Yes, I generally try and publish a blog post once-per-release, and
> > generally with the following two goals in mind:
> >
> >   - talk about and publicize some of the new features in the latest
> >     release (or releases, if I've missed a blog post or two)
> >
> >   - share some interesting tidbits about existing features.
> >
> > I think it would be good to have these blog posts in both places, should
> > this proposal materialize. I would have to ask about whether or not
> > GitHub would be comfortable about cross-posting to a new venue, and I'd
> > be happy to raise the question when it comes up.
>
> Yeah, I find these blog postings at GitHub quite helpful.  Thanks
> for writing them.

Thanks for maintaining the release notes. I often start there to figure
out what to write about, and having them so well organized makes my job
a lot easier.

> I wonder if a semi-automated republication (ala "Planet"), instead
> of cross-posting, is an option that is easier to manage, though.

Probably. I don't know how Planet works, but if it can accept an RSS
feed (and doesn't require too much on GitHub's end), it's probably
sensible.


Thanks,
Taylor
