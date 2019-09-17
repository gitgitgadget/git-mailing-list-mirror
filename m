Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9893B1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfIQTcj (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 15:32:39 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36483 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIQTcj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 15:32:39 -0400
Received: by mail-pf1-f178.google.com with SMTP id y22so2744369pfr.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNjuHHiKPntTgF7qga98dVqFqssA/FhZ94hjjgdP8Xw=;
        b=GcAqe8M+rcl/th5RZs5GYRGAaD/Hy4D5Td4cxNQ6LhSGHEGt1NYN8wuOMp/1PNO4pQ
         omajOmWDlEPSGzFV38Y2HgNtqh7xM40Ecvd3IkUbvlXvUmL+qV8cahbBBk8bNDFO8n2S
         MhyA9JGs2q8Hq5G04bTG3f35c2bHGg9SArRpvG8BHhVe/kxt4AJu1F88spEFAM490EPB
         ExD3h2ht6sjcyn+T+uhlPGD3avCs1UNhFtn+5N4SCqBfl/Agnivkxo18mNlBnIGM+IXu
         aEJonZ9+K0ZCENOCWwdWboQq46nMMZlUz6uk/kUXe2KmgLzozXclI1dokZUhaemMxmSo
         ynQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNjuHHiKPntTgF7qga98dVqFqssA/FhZ94hjjgdP8Xw=;
        b=V3lKCDvmN2Nmn4te7ETRplEKJFuIyGPlLNTmjVgbonM1jGaaMAiT26FFRyGQQMErCl
         EN0s6a0elQtJmsZBKC+uffd8YPPUiNPVUcYGUFf414bEIXKC4kQcww07gMgPq8hyDV0c
         wu9V0OW6GGZ3sBPGOJVySNybw3iRIGjTJHkKTewlr8PKEwbQ3zI5nUXx7mWhL333bVB4
         Vw7RCxYr0bPPxx3ggKx1rcUREkL+YZWxJuTQKTPR+aWvmCPAVaM2GEf8PuzGz3GBzXAU
         H7JRUy57mLnyOiIV0b/1uuyNBZY2VavNHG86koQNgszzEBk76aGZTa7cWgWPbjlVFlGS
         NgMg==
X-Gm-Message-State: APjAAAVKX3Yzw8lJSnd9WeIucnu45Uva2cxslJah9bIsGhuv7KpgoOsq
        9ni8JF/3iB/+UHTDNjqrLK928Q==
X-Google-Smtp-Source: APXvYqzLsOGkcEBKRKfBPJExd4wo3QnOGyLivwBj2EAeDH3mr7O9oUQKv+rCKPK01iwtbd0/f7iUnA==
X-Received: by 2002:a62:112:: with SMTP id 18mr6103541pfb.156.1568748757926;
        Tue, 17 Sep 2019 12:32:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y7sm3398685pfl.119.2019.09.17.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:32:37 -0700 (PDT)
Date:   Tue, 17 Sep 2019 12:32:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     James Ramsay <james@jramsay.com.au>
Cc:     pedro rijo <pedrorijo91@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190917193233.GC17913@google.com>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com>
 <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
 <CAPMsMoAwfp+jv9h7xAD9PbqV+cU4njyf7Tex6HUCznqjb5hi_w@mail.gmail.com>
 <45DA95BF-17D8-4238-9ECF-A4D1AC1A9634@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45DA95BF-17D8-4238-9ECF-A4D1AC1A9634@jramsay.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 03:22:38PM -0400, James Ramsay wrote:
> On 13 Sep 2019, at 10:05, pedro rijo wrote:
> 
> > Just a minor question: since we have git-scm, pro-git, and git
> > translations in github, why not keep in the same place, under the same
> > organization? I just find it easier to find than having repos
> > scattered across different git hosting services
> 
> It wasn't a technical reason, but a matter of me (and my employer GitLab)
> volunteering the time needed to get the blog project off the ground. In the
> context of the Virtual Git Contributors' Summit, folks seemed happy with
> using GitLab or any other service with a Git interface.

I really appreciate you setting it up, James - the starting inertia is
one of the trickier bits of something like this :)

If we decide later down the road that we really feel the need to have
the site, book, translations, etc all in one place I think it'll be
pretty trivial to mirror/move/whatever. I'm just happy to have somewhere
to start!

 - Emily
