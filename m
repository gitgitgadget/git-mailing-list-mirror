Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3CE20248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCUWgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:36:20 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51905 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfCUWgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:36:19 -0400
Received: by mail-qt1-f201.google.com with SMTP id l26so439859qtk.18
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x8py1EfWFcndNauKK/WjQGUL3nFdfjOYN52e/U2gXS8=;
        b=D84GrFJi+Dlhur3UhH8g8x2hZJOfHkp6ID7M48LSBv8fZrGm+SNj2hq2GUlvJJStE4
         50KzQntKplyQvfcZw56O2bu/IJV47XmsmhkYCuDJk5OTmzmF76RkG+opN0q0J6wCJg0o
         awFbYII5iL3rJp93aS6+xHeyOAj8+S6XTCN/RoBFpUTSyeJCRCeGJ2c8Pmv3EEGYroh+
         goqWVJ3pSStuTd+g1cUi2JRbiuXYnFMgzj+3AFYt9EeiNOQ54ITgkNrkBhFpFJRSqMqI
         EFtCI7d10BtHxt5dLWecAlpeF+udLJKHH7nzw2B+4G3d2E0DxaKQa1WJeTZhxjlTKsGu
         iN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x8py1EfWFcndNauKK/WjQGUL3nFdfjOYN52e/U2gXS8=;
        b=o47l24AhZJhbDSaSBSAknccnJ+c9QBj1OXFdC2DD+llBnUsrUz+dQlDuM9ZOY1JWXR
         o+iNUA9/iUMDXMqhSyegOrl4ApTDXdYvWtkWOtc3cPGJN/y3MCnPMS0FfncsmvDmNL/E
         3qOjXdHCr0pb+9lyrWZVRQAZ9oSdWV+60nDr6O599BLhTNqHp0Jj0S8t/NVDx6+37UFS
         VI15C+30bcbCEDnzAU0VLn5hRsyP6ZvGIthH+5jOaGfJtqgSuCL3wmsMk9Lz+xqdpcQ6
         ImvixlqwfNLMwGKUWD3HXYk3NsiJ4BTEZY3q6qOEQqvRV8QuJGg8i/EdqeoxDW1UwOXo
         fytw==
X-Gm-Message-State: APjAAAW7jLxKGTb5/I++olixBZeiahUCg3VAVFLKBO9I0viQSUo2scgU
        mEXxfdQoZobftE7PhSjdJN9tAYtOOdiA1V5pXVzO
X-Google-Smtp-Source: APXvYqy7YRGcJioVNSPPHpsq3Ylb3W9BBoP+by7yMQvhhWSZtdMaaLkg38QmY+NQ0OrbnGv+KPx7CHoUH6RwyehcvTdH
X-Received: by 2002:a0c:b501:: with SMTP id d1mr5384339qve.115.1553207779033;
 Thu, 21 Mar 2019 15:36:19 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:36:15 -0700
In-Reply-To: <20190321214827.GA22582@sigill.intra.peff.net>
Message-Id: <20190321223615.53228-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190321214827.GA22582@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Mar 21, 2019 at 01:24:35PM -0700, Jonathan Tan wrote:
> 
> > > The test you're deleting is basically just verifying that our apache
> > > config is indeed "half-auth". Because in v0, the server is never even
> > > going to ask for credentials, so no interesting code paths in the client
> > > are triggered. So it's not actually testing anything of interest.
> > 
> > If both of us want to drop this test, that's great :-) but for
> > clarification: in addition to verifying that our apache config is
> > "half-auth", this test also verifies that in a no-op fetch, we don't hit
> > the path that is guarded by an authentication requirement. This seems
> > significant to me in light of the link you provided in your prior email
> > [1].
> 
> Yeah, I suppose it does. I just never really thought of that as a
> plausible regression to introduce, given the way the v0 protocol works. :)
> 
> Although in a sense it is interesting, because it did reveal something
> about v2 that we hadn't considered. I don't think it's worth addressing
> (especially now), but had we been doing cross-protocol tests sooner, we
> might have looked at it more in the design phase.
> 
> So I would also be OK with just marking it as as v0-only test.

OK - I'll wait to see what others think. Thanks for looking at this so
far.
