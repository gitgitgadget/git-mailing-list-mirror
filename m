Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B961C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 23:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiEYXtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 19:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiEYXtY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 19:49:24 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 16:49:22 PDT
Received: from npcomp.net (unknown [209.195.0.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B176BFCB
        for <git@vger.kernel.org>; Wed, 25 May 2022 16:49:21 -0700 (PDT)
Received: by npcomp.net (Postfix, from userid 1000)
        id A1F97DE738; Wed, 25 May 2022 23:34:18 +0000 ()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
        s=eldondev; t=1653521658;
        bh=xBrR4ZX7YByB9x5nJo4y5FHVqc5c5w6/pUZq/z9moQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fwtOhpkpCm5qrmpa9fmX6YPxlLwJnszaLMR/irCOyjgYO0G9rk6y0S5Luli9YLqzi
         kmAPEZq6d03TpXSNt+IZG5M+1PzJOUIjfzgr3EUplMcrnPKI8sa1AAx4CmYbdvGrpD
         l9QTqEB4vDlISf6rcg2Pmc0IO9QaSFj3LXPMasO0=
Date:   Wed, 25 May 2022 23:34:18 +0000
From:   git-vger@eldondev.com
To:     Aman <amanmatreja@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: About GIT Internals
Message-ID: <Yo68+kjAeP6tnduW@invalid>
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aman, responses inline below.

On Wed, May 25, 2022 at 09:40:42PM +0530, Aman wrote:
> Could someone please assist - in sharing some resources - which I
> could go through, to better understand GIT software internals.

There is an excellent free book at https://git-scm.com/book/en/v2 .

Chapter 10 is about git internals. It is important to realize that,
unlike many other version control systems, git works effectively on
files locally on your computer, without any server or other shared
resources to manage. Also, one good way to learn may be to form a
question that you want to answer first. "How do I ...." or "what happens
when I ....". Since git works locally, it is possible to create a git
repo, look at the files contained in the .git directory, take action
with git, and then look at the files again.

Many people use git from the command line. If you are not familiar with
the command line, you may be interesting in learning more about it.
Mozilla, the makers of the Firefox web browser, have a wiki page to
familiarize yourself with the command line here: 
https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Understanding_client-side_tools/Command_line

Happy Explorations!
Eldon
