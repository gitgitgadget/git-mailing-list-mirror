Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7654EC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbiCPVgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiCPVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:36:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D8212
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:34:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4086B21109;
        Wed, 16 Mar 2022 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647466494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YG43eBG+OuRZ84qAmMspiQX4eV414FWkJveXj/unro=;
        b=nRTsRSGLmYfyx8yNBfUdSKKUF/SC6FTfpC6VAdkIWNzo2dnZ+TSj0GuwL0dW76ra2n0xwv
        uUi4/8+AewghJABlfaE4VhaoHIqr/w9gAoDXsEtRvzsWhdGc3K5ArgcRw7dgBDzayivgUg
        YFIQ4mFzsdeY9+fgLRNMD+EvDZ1LNGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647466494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YG43eBG+OuRZ84qAmMspiQX4eV414FWkJveXj/unro=;
        b=zcjxAARW21vofDnxslebLg+E84KwkMNDQqDEzKGACCgH9Z4cdHdupZpDT1lJApq4kwnidG
        QLO/LrfuR2BdzQAQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2AC67A3B92;
        Wed, 16 Mar 2022 21:34:54 +0000 (UTC)
Date:   Wed, 16 Mar 2022 22:34:52 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Alice Merrick <amerrick@google.com>, Git List <git@vger.kernel.org>
Subject: Re: Let's have a user experience workshop
Message-ID: <20220316213452.GJ163591@kunlun.suse.cz>
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <20220316201058.GI163591@kunlun.suse.cz>
 <CAJoAoZnKebM4m3AXW6+RBY7dBsQhAcReqd61VtXHNjcnPBeemQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZnKebM4m3AXW6+RBY7dBsQhAcReqd61VtXHNjcnPBeemQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 01:41:59PM -0700, Emily Shaffer wrote:
> On Wed, Mar 16, 2022 at 1:11 PM Michal Suchánek <msuchanek@suse.de> wrote:
> 
> > > * Reply directly to this email if you are interested in organizing the
> > > event to discuss git UX (scheduling the event, sending invites,
> > > communicating with invitees)
> >
> > Can you, please, use a sane mailing list for the discussion?
> >
> > The user experience of Google Groups really bad.
> >
> > Also it seems it is accessible only to people with a google account.
> >
> > Could you use a more inclusive technology?
> 
> Git already uses Google Groups for the security list (e.g. for fixing
> pre-disclosure security issues) and for the mentoring list, and it's
> fine to subscribe to one with a non-Google account; it acts just as a

The link you provided only allows access with a Google account. If there
is one that allows access in other ways it was not provided.

Please try to use open technologies that are accessible to everyone, not
only people affliated with one specific company.

Thanks

Michal
