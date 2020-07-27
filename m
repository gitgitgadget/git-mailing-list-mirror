Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D4C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4189020714
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 05:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgG0FmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:42:22 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52361 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0FmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 01:42:22 -0400
Received: from localhost (unknown [42.109.213.7])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id CC1DE100002;
        Mon, 27 Jul 2020 05:42:18 +0000 (UTC)
Date:   Mon, 27 Jul 2020 11:12:15 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     mirucam@gmail.com, chriscool@tuxfamily.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v5 02/13] bisect--helper: use '-res' in
 'cmd_bisect__helper' return
Message-ID: <20200727054215.4nfke6byi6m63txf@yadavpratyush.com>
References: <20200717105406.82226-3-mirucam@gmail.com>
 <20200725173118.GA614724@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725173118.GA614724@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/20 11:01PM, Shourya Shukla wrote:
> > Following 'enum bisect_error' vocabulary, return variable 'res' is
> > always non-positive.
> > Let's use '-res' instead of 'abs(res)' to make the code clearer.
> 
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> 
> Although there is no set rule for this, but I think that your sign-off
> goes at the last generally. This is what I have seen on various patches.

The rule of thumb I follow is to have these in chronological order. So 
Christian first mentored, then the patch was published so Junio helped 
next and finally you sign off the patch before sending it out so that 
comes last.

-- 
Regards,
Pratyush Yadav
