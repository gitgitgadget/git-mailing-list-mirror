Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB2DC4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682A9206F7
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BxCpmnvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJFLNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFLNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 07:13:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C88C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 04:13:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4C5FFv29jNz9sSG; Tue,  6 Oct 2020 22:13:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1601982819; bh=wmbBMynWyn4w0O7iw6IXl+LWpiPLxkD+jJ/mXQSL3ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxCpmnvyRUA50hJ9eBYrOcingAaBqr8JQp+rTkZ8W5qxHhndlaEfCWqvPg6HFurm3
         8Jn13q/i46dRhf90j89+R2KsKTe4umdictDEHnX6TgTo58OEHwnPjDoDKqRKy+QYPd
         KLlWW9TS2cGzwbG+Js4HQvG/ykZxnvzY3pOr1DS2muRrjosC/RYUbMBZGdL6Qcrzvn
         UwSwWR5O38sgJ9J4c1jY0blWTzljI8C+ZDxz0tzH3TWB8MxNjJRGAhdGrFpQC/wtyF
         cKeQxnMiS68CnuaK6yq6tG0srwxq9ubv6HQPikA/hS3fCt1Msr9o14dJrHPQxEHXHq
         KkIh5JC9wgo8Q==
Date:   Tue, 6 Oct 2020 22:13:35 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] gitk update
Message-ID: <20201006111335.GA3364508@thinks.paulus.ozlabs.org>
References: <20201003092010.GC3089868@thinks.paulus.ozlabs.org>
 <xmqqy2kn8cmb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2kn8cmb.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 03, 2020 at 10:04:28AM -0700, Junio C Hamano wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > Hi Junio,
> >
> > Whenever it's convenient for you, please do a pull from my gitk
> > repository at git://ozlabs.org/~paulus/gitk.git to get 6 commits
> > updating gitk.
> >
> > Thanks,
> > Paul.
> 
> Will do.  Are these the six you mentioned, or am I missing some
> other commits?
> 
>     $ git log --first-parent --oneline ..paulus/master
>     6cd80496e9 gitk: Resize panes correctly when reducing window size
>     e244588eb6 gitk: replace tabs with spaces
>     a99bc27aec gitk: fix the context menu not appearing in the presence of submodule diffs
>     2faa6cdc5e gitk: Un-hide selection in areas with non-default background color
>     113ce1243f gitk: add diff lines background colors
>     e272a77964 gitk: be prepared to be run in a bare repository
>     c1a63459ed gitk: Preserve window dimensions on exit when not using ttk themes
>     f177c49a97 gitk: don't highlight files after submodules as submodules
>     d4247e0602 gitk: fix branch name encoding error
>     b8b60957ce gitk: rename "commit summary" to "commit reference"

Yes, that's right.  Obviously it's longer since I sent you a pull
request than I had thought.

Thanks,
Paul.
