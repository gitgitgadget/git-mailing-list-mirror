Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018FC433FE
	for <git@archiver.kernel.org>; Wed, 11 May 2022 08:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiEKIVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiEKIVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 04:21:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146323BC9
        for <git@vger.kernel.org>; Wed, 11 May 2022 01:21:49 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Kynv049Q8z4ySZ; Wed, 11 May 2022 18:21:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1652257308;
        bh=8c2hzTtDuknYsDeotpVIu9pROWfCBKrerU78fSI9SFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+yDjxy63X/ba5VNwQ1drcdCuJ1t7iA0WE0Vm0YZy47I3LkNgEljRxBswrobQIIUh
         prB0qDMldQB9OwV4JVeZiAG2jgBBp64p837FkVXk564Xjc3yrQeOSMcvrjIUw6y2Qn
         gNvdPIC5x2rJzzHsoJgtLLj0YvQNbY67KwS3DYwNP6vlXm2r55yvg/dT30HBgCj6/x
         QdOaSAFgu5jbru77iKln8oQvzoASyFNpNGqz+7kNQKkBNWm7v5jtsdy8cNywFM1U/l
         jSj7aVP6nbgcBvdzRG/rvKJoITuEM17FR52Qe0VcNxGdPxOHCtuJePtfbNzTYIXDAW
         hvmYCet8l7vkA==
Date:   Wed, 11 May 2022 18:20:47 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Halil SEN <halilsen@gmail.com>,
        Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>,
        Christian =?iso-8859-1?Q?Gr=FCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
Message-ID: <Yntx33Q9pNLJ+QqS@cleo>
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
 <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <xmqqzgjuocjk.fsf@gitster.g>
 <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
 <xmqqtu9yd42d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtu9yd42d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 10:11:06AM -0700, Junio C Hamano wrote:
> Halil SEN <halilsen@gmail.com> writes:
> 
> > Junio C Hamano, <gitster@pobox.com> wrote:
> >> I didn't look at it back then primarily because
> >> the patches were made against a wrong history
> >
> > I remember looking for Paul's repository but I
> > failed to find it so created the patch against
> > the main git repo. Maybe I should have
> > mentioned this in my message since I knew
> > the documentation included that note.
> >
> > I am happy to rebase my patch if someone
> > could point me in the right direction.
> 
> Thanks for giving me a chance to double-check what we have in
> Documentation/SubmittingPatches is not stale:
> 
> - `gitk-git/` comes from Paul Mackerras's gitk project:
> 
> 	git://ozlabs.org/~paulus/gitk

Could you change that to

	git://git.ozlabs.org/~paulus/gitk

please?

The ozlabs.org infrastructure changes every so often, and while the
plain ozlabs.org works now and is not expected to stop working,
git.ozlabs.org would be a little more future-proof.

Thanks,
Paul.
