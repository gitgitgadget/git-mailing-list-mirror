Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885701F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfHGRHi (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:07:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41879 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGRHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:07:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so10155736qtj.8
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vfn9DEgK8dxJkbHQyX7JVo/hTbx3z+Yl0pFHALjrq6s=;
        b=hvPNeb9fbRbYBM1zhozt3RVoTk1FjZfBnAbpvlTsPVocssTN4yHrH7MMI714zwoa8S
         frvz2qIX/ZxuozaaO6UoGZgtHo5DPKy0MHY98hopixKy/zHQr6Vw/+2dOQ9HlhtV3ddK
         E9YKiPw+W5S2VbKDBqLQ6SZ05bckpCjeJLmswWuG2n7LqxCDxgYEQxxZXXzDhdVJ+SkD
         tH5XEkDPuFtqlHHjjYtyjKYH9Ak9wqJXnaJeV7RZ34UzWW8KAv78nFsnNLIZAVR9lo0w
         0LTdfDV4iQ6j9YeLC+U/d1+GrE0I1fEYh5XsfT+fUrdy/s6NXxCVQk/G3llOYgfW3ppT
         h12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vfn9DEgK8dxJkbHQyX7JVo/hTbx3z+Yl0pFHALjrq6s=;
        b=ls4jR60QyFYIokhB01GcPmfvOIMMtaTn60c7OiEcmzuIG5mxBbzzltoFNCr1BngMA5
         h4OiOrC3jKuvqt8jw/USZf+RofhHoQFhMV/Ph9Jh9NFtcD+Re/lCXFDbCvvdmWbqYDp4
         2a5OdK+RJiSo6Gi/4Ta4izQoVybeZqmGIIEOUI/ZCFTK3AaWk7SV+/vXDYx5ksbq3/FB
         2DYuawzwTtQh/gEu61dus+Lv3WsZ0cj/4sxucySEiwzttrKzUJ6R1tSQVi+ZmH50p2zS
         U2EsRe+422Yvn05cB25lwR1khkxsP6SBGYihzrLN0I7ZKWwN46cfXemHXjSLI/QH2i+r
         0Ndg==
X-Gm-Message-State: APjAAAUA8s9r25pG3jCL3HIoMbTeb8xpNEZy+yHw4ZiOPAJ1oQppMQE6
        7EMDOx0dpOZEiyLWvHRmuY3s3A==
X-Google-Smtp-Source: APXvYqyZ9E1linR07aZqZ0I4nT2hoMTd8+lIzetoguBwfP4bnjKooSkD/S8NS3jMciMjlK+KIt8cDw==
X-Received: by 2002:ac8:19ac:: with SMTP id u41mr8948351qtj.46.1565197657141;
        Wed, 07 Aug 2019 10:07:37 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id o17sm36218875qkm.6.2019.08.07.10.07.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:07:36 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 7 Aug 2019 13:07:35 -0400
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190807170735.GA61464@syl.local>
References: <20190806014935.GA26909@google.com>
 <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
 <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, Aug 06, 2019 at 08:19:15AM -0400, Derrick Stolee wrote:
> On 8/6/2019 12:52 AM, Andrew Ardill wrote:
> > On Tue, 6 Aug 2019 at 11:51, Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> >> Are folks interested in writing and reviewing this kind of content?
>
> I am interested in writing and reviewing! Here are some topics I am
> interested in writing:
>
> * Updates to the commit-graph feature
> * What is a multi-pack-index and what is it for?
> * Git at Scale: What makes a repo big, and how to avoid it?
> * Advanced Git config settings
>
> Here are some topics I'd be interested in seeing in the wild
> (and was considering writing them myself if I didn't see them elsewhere):
>
> * Partial clone: what, why, and how?
> * Life cycle of a patch series
> * Crafting perfect patches with interactive add and rebase
>
> It would also be helpful to have a post for every major release
> highlighting new features and giving users examples of how to use them.
> Taylor has been writing these on the GitHub blog [1], but maybe he
> would be interested in writing them for this new venue?
>
> [1] https://github.blog/2019-06-07-highlights-from-git-2-22/

Yes, I generally try and publish a blog post once-per-release, and
generally with the following two goals in mind:

  - talk about and publicize some of the new features in the latest
    release (or releases, if I've missed a blog post or two)

  - share some interesting tidbits about existing features.

I think it would be good to have these blog posts in both places, should
this proposal materialize. I would have to ask about whether or not
GitHub would be comfortable about cross-posting to a new venue, and I'd
be happy to raise the question when it comes up.

> [...]
>
> Thanks,
> -Stolee

Thanks,
Taylor
