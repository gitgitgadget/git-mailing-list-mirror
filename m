Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6480ECD6E7E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjJKPeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJKPeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 11:34:21 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AF92
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:34:19 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697038457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPzqs8lrIh39pMp6yoDymdNPRN/89z3c1g8KyGZrUYE=;
        b=rrksUFQlyTGHiG9GF2pu4sImPXaD/PTPrH23jpo+bjAxDDpyIt2ksWF4P6zRPGJxPLbXfv
        MGoMCOSvucdwglsAVl5dXz7+pjB2/y17+x5B1rqkG0ost6T/YAdiqdZ7nzq7cTa39le/s4
        LEYmwSthqlmRJ86TSPAPQwywC44BUo7KkNqVrENJDWzyp60nZQkPWZgdH6P0xIDK5avEIs
        EgM+GHCvY8xmQ6luYL4qWNCFy8WxXgvJFmVvJlbXaEEp6DCOY1/GoKTM8oiUISglsxdOTz
        PGvhX+jdxH0c2cgmpYfQi7d/ztvbo6CRGL1W0anFUpQtwUTBHsoq+w4LR9Q3hw==
Date:   Wed, 11 Oct 2023 17:34:17 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Isoken June Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy][PATCH 0/1] builtin/branch.c: ammend die() error
 message
In-Reply-To: <20231011152424.6957-1-isokenjune@gmail.com>
References: <20231011152424.6957-1-isokenjune@gmail.com>
Message-ID: <c98dd0b5988f9889ee4c2b5d4e645839@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-11 17:24, Isoken June Ibizugbe wrote:
> This patch improves the consistency and clarity of error messages
> across Git commands. It adheres to Git's Coding Guidelines for error
> messages:
> 
> - Error messages no longer end with a full stop.
> - Capitalization is avoided in error messages.
> - Error messages lead with a description of the issue, enhancing 
> readability.
> 
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>

When there's only one patch and not a series, there's no need for a 
cover letter, and the description of the patch actually needs to go into 
the patch itself, so it can be latter pulled into the repository as part 
of the patch submission.

> Isoken June Ibizugbe (1):
>   branch.c: ammend error messages for die()
> 
>  builtin/branch.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
