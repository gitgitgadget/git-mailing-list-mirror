Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC49C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DA661164
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhFQLUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:20:38 -0400
Received: from verein.lst.de ([213.95.11.211]:58359 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232260AbhFQLUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 07:20:36 -0400
Received: from bagger.lan (ip5b406553.dynamic.kabel-deutschland.de [91.64.101.83])
        by verein.lst.de (Postfix) with ESMTPSA id 940D06736F;
        Thu, 17 Jun 2021 13:18:23 +0200 (CEST)
Date:   Thu, 17 Jun 2021 13:18:19 +0200
From:   Simon Hausmann <simon@lst.de>
To:     dorgon chang via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dorgon chang <dorgonman@hotmail.com>
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
Message-ID: <YMsveynHB8MNiz+S@bagger.lan>
References: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 07:47:49AM +0000, dorgon chang via GitGitGadget wrote:
> From: "dorgon.chang" <dorgonman@hotmail.com>
> 
> If the submit contain binary files, it will throw exception and stop submit when try to append diff line description.
> 
> This commit will skip non-text data files when exception UnicodeDecodeError thrown.
> 
> Signed-off-by: dorgon.chang <dorgonman@hotmail.com>

As suggested on
https://github.com/git/git/pull/977#issuecomment-862197824, I'm happy to
state that the patch looks good to me. IIRC the diff there is solely for
the submit template, so it should only include text. That your patch
ensures in what seems an idiomatic way.

Signed-off-by: Simon Hausmann <simon@lst.de>




Simon
