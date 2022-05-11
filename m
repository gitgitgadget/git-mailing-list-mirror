Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE9C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 08:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiEKIVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 04:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243545AbiEKIVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 04:21:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAE140FE
        for <git@vger.kernel.org>; Wed, 11 May 2022 01:21:49 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4Kynv041WTz4xXh; Wed, 11 May 2022 18:21:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1652257308;
        bh=2YCo8ni0a5J40M5/t+whvHZFlANUugVd1ffyaxuphO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OE4lbQ/rPtxzT9wAJsK4onE8RWLXZ9utVBEFxV8f0lv2HEZrhs+gV6cbp10Vas5yT
         vERmjFaMbX73QIFNEJOGnOgXBw5xFokVrsuxxMEvpZS8CvZd1EB9AU1jtGwmGFYrej
         V4uHpsI/WLmPBqX6ShKE6nwdWD8korsO82Qs5Rensvx5Owwa8KU/sPUylo2F2MNGMn
         lhXgplL53p4OO1r6cTpQ73dgwGYqQbvRXYrcC9VgHM0UQjUi3jvpMJ7M7Ad3T4qpXU
         3KVsPibex8XGiHYXzAORBtB2Ja0NsUPBmr3O5nh0y3eej2sR+zct/SfD9kRg7Pgkky
         JtENW+v87j1tQ==
Date:   Wed, 11 May 2022 18:17:51 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>,
        Christian =?iso-8859-1?Q?Gr=FCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org, Halil Sen <halilsen@gmail.com>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
Message-ID: <YntxL/fTplFm8lr6@cleo>
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
 <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <xmqqzgjuocjk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzgjuocjk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 09:23:27AM -0700, Junio C Hamano wrote:
> Matthias Aßhauer <mha1993@live.de> writes:
> 
> > It looks like the issue at [1]. It sadly seems like nobody ever
> > reviewed or applied thos suggested patches, but there is some more
> > off-list discussion at [2].
> >
> > [1] https://lore.kernel.org/git/pull.1219.git.git.1645386457.gitgitgadget@gmail.com/#t
> > [2] https://github.com/git/git/pull/1219#issuecomment-1113122632
> 
> Thanks for a pointer.
> 
> I do recall seeing [1] but I do not see anything happened on the
> thread since then.  I didn't look at it back then primarily because
> the patches were made against a wrong history (no, you do not want
> to make a gitk patch against my tree nor throw a pull request at my
> repository), and there was no way for me to pick it up.

I have just picked up Halil Sen's two patches and applied them, and
pushed the result out to git.ozlabs.org.

> As Documentation/SubmittingPatches says:
> 
>     Some parts of the system have dedicated maintainers with their own
>     repositories.
>     ... 
>     Patches to these parts should be based on their trees.
> 
> Having said that, gitk has been quiescent for quite a while, and I
> wonder if Paul's been too busy for (or no longer interested in)
> maintaining it and perhaps he can use a replacement maintainer?

I am indeed very busy and would welcome a replacement maintainer for
gitk, if somebody was willing to take it up.

Thanks,
Paul.

