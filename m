Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F92DC433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CD22222D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgJTKXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:23:44 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51433 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgJTKXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 06:23:44 -0400
X-Originating-IP: 103.82.80.40
Received: from localhost (unknown [103.82.80.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id AB5691C001E;
        Tue, 20 Oct 2020 10:23:41 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     fuyao <fuyao@allwinnertech.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6buE6Ie754Kc?= <huangzhenwei@allwinnertech.com>
Subject: Re: Is cover letter can save changes?
References: <20201020070547.GI9517@g8Exdroid64>
Date:   Tue, 20 Oct 2020 15:53:39 +0530
In-Reply-To: <20201020070547.GI9517@g8Exdroid64> (fuyao@allwinnertech.com's
        message of "Tue, 20 Oct 2020 15:05:47 +0800")
Message-ID: <873629fb6c.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20 2020, fuyao wrote:

> Hi:
>    i have question about format-patch.
>
>    when use git format-patch with --cover-letter, we add information
>    in the cover letter. and then, i must send patch with -v2, the
>    information in the cover letter is lost in the v2 patch.
>
>    i found git notes can note things, but it add in patch not
>    cover letter. is some operate can do to save in cover letter.

You can try using `git branch --edit-description <branch_name>` and
write the contents of the cover letter there. Then you can use the
option `--cover-from-description` to use the branch description when
generating the cover letter.

>    and the git note record with commit, when amend it can lost note,
>    is the rewrite error?

Have you set the config `notes.rewriteRef` to your notes ref?

-- 
Regards,
Pratyush Yadav
