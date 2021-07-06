Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F03C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5519E613D1
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 08:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGFIUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 04:20:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47419 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhGFIUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 04:20:20 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CDBB71BF2F1;
        Tue,  6 Jul 2021 08:17:40 +0000 (UTC)
Date:   Tue, 6 Jul 2021 13:47:38 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Applying a patch with a diff header in its commit message
Message-ID: <20210706081738.5th24lypiicnbckv@yadavpratyush.com>
References: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
 <60da5ed21ec8c_1f78f2082a@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60da5ed21ec8c_1f78f2082a@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/21 06:44PM, Felipe Contreras wrote:
> Pratyush Yadav wrote:
> > I have a patch at $DAYJOB that contains a diff header ("diff --git 
> > a/...") in its commit message, and unfortunately it is not indented. So 
> > naturally, git-am trips up and thinks it is the start of the main diff 
> > and tries to apply the diff starting there. It does not apply and the 
> > patch is rejected as being corrupt.
> > 
> > I know one option for me is to manually edit the patch and indent the 
> > diff header. But I would like to avoid that if possible. Is there any 
> > way to apply that patch as-is? Is it possible to tell git-am where to 
> > start looking for the diff?
> 
> git apply?

Sure, that is an option. But then I would have to copy/paste the commit 
message and add the author information manually. Is there any way to do 
this automatically? What if I have 100 commits like this?

This is a valid Git commit. It would be nice if the Git email tooling 
could handle it cleanly.

-- 
Regards,
Pratyush Yadav
